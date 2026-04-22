package org.triptogether.myPage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * SSE 기반 실시간 알림 푸시 서비스.
 *
 * - 유저 1명이 여러 탭을 열 수 있으므로 userIdx → List&lt;SseEmitter&gt; 로 관리
 * - 30분 타임아웃 후 브라우저가 자동 재연결 (EventSource 기본 동작)
 * - 30초 주기 하트비트로 프록시·방화벽 idle timeout 회피
 */
@Slf4j
@Service
public class NotificationSseService {

    private static final long TIMEOUT_MS = 30L * 60 * 1000;

    private final Map<Long, List<SseEmitter>> emitters = new ConcurrentHashMap<>();

    public SseEmitter subscribe(Long userIdx) {
        SseEmitter emitter = new SseEmitter(TIMEOUT_MS);
        emitters.computeIfAbsent(userIdx, k -> new CopyOnWriteArrayList<>()).add(emitter);

        Runnable remove = () -> {
            List<SseEmitter> list = emitters.get(userIdx);
            if (list != null) {
                list.remove(emitter);
                if (list.isEmpty()) emitters.remove(userIdx);
            }
        };
        emitter.onCompletion(remove);
        emitter.onTimeout(remove);
        emitter.onError(e -> remove.run());

        // 초기 connect 이벤트 (프록시가 응답을 버퍼링하지 않도록 즉시 플러시 유도)
        try {
            emitter.send(SseEmitter.event().name("connect").data("ok"));
        } catch (IOException e) {
            remove.run();
        }

        return emitter;
    }

    public void sendTo(Long userIdx, FeedNotificationDto noti) {
        List<SseEmitter> list = emitters.get(userIdx);
        if (list == null || list.isEmpty()) return;

        for (SseEmitter emitter : list) {
            try {
                emitter.send(SseEmitter.event().name("notification").data(noti));
            } catch (IOException e) {
                emitter.complete(); // onCompletion 콜백이 리스트에서 제거
            }
        }
    }

    // 30초 주기 하트비트 (주석 라인만 전송하여 idle timeout 회피)
    @Scheduled(fixedRate = 30000)
    public void heartbeat() {
        emitters.forEach((userIdx, list) -> {
            for (SseEmitter emitter : list) {
                try {
                    emitter.send(SseEmitter.event().comment("ping"));
                } catch (IOException e) {
                    emitter.complete();
                }
            }
        });
    }
}
