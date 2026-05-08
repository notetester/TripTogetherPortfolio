package org.triptogether.auth.risk;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/**
 * Provider 별 동시성/분당 호출 한계를 단일 인스턴스 in-memory 로 관리.
 * 클러스터링 환경에서는 인스턴스마다 독립 카운터를 갖는다는 점에 유의.
 */
@Slf4j
@Component
public class ProviderCallThrottler {

    private final ConcurrentHashMap<String, Semaphore> concurrencyMap = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, Deque<Long>> rateMap = new ConcurrentHashMap<>();

    public Lease acquire(SecurityAssessmentProviderConfigVO provider) throws InterruptedException {
        if (provider == null || provider.getProviderCode() == null) {
            return Lease.noop();
        }
        String code = provider.getProviderCode();

        Integer rate = provider.getRatePerMinute();
        if (rate != null && rate > 0) {
            if (!tryAcquireRate(code, rate)) {
                return Lease.denied("rate limit exceeded (" + rate + "/min)");
            }
        }

        Integer max = provider.getMaxConcurrent();
        if (max != null && max > 0) {
            Semaphore sem = concurrencyMap.computeIfAbsent(code, k -> new Semaphore(max, true));
            int timeoutMs = provider.getTimeoutMillis() == null ? 3000 : provider.getTimeoutMillis();
            boolean got = sem.tryAcquire(timeoutMs, TimeUnit.MILLISECONDS);
            if (!got) {
                return Lease.denied("concurrency limit reached (" + max + ")");
            }
            return Lease.holding(sem);
        }
        return Lease.noop();
    }

    private synchronized boolean tryAcquireRate(String code, int rate) {
        long now = System.currentTimeMillis();
        long windowStart = now - 60_000L;
        Deque<Long> q = rateMap.computeIfAbsent(code, k -> new ArrayDeque<>());
        while (!q.isEmpty() && q.peekFirst() < windowStart) {
            q.pollFirst();
        }
        if (q.size() >= rate) {
            return false;
        }
        q.addLast(now);
        return true;
    }

    public static final class Lease implements AutoCloseable {
        private final Semaphore sem;
        private final boolean granted;
        private final String denyReason;

        private Lease(Semaphore sem, boolean granted, String denyReason) {
            this.sem = sem;
            this.granted = granted;
            this.denyReason = denyReason;
        }

        static Lease noop() { return new Lease(null, true, null); }
        static Lease holding(Semaphore sem) { return new Lease(sem, true, null); }
        static Lease denied(String reason) { return new Lease(null, false, reason); }

        public boolean isGranted() { return granted; }
        public String denyReason() { return denyReason; }

        @Override
        public void close() {
            if (sem != null) sem.release();
        }
    }
}
