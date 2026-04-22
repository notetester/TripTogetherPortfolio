package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.common.mapper.ChatbotBlockMapper;
import org.triptogether.common.vo.ChatbotBlockVO;

import java.util.List;

/**
 * 챗봇 전용 차단 서비스.
 * 기존 USER_BLOCKLIST / BLOCKED_IP와 별개 시스템.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotBlockService {

    private final ChatbotBlockMapper blockMapper;

    // IP 또는 USER가 활성 차단인지 확인
    public boolean isBlocked(String ip, Long userIdx) {
        if (ip != null && blockMapper.isBlocked("IP", ip)) return true;
        if (userIdx != null && blockMapper.isBlocked("USER", String.valueOf(userIdx))) return true;
        return false;
    }

    public void upsertBlock(ChatbotBlockVO block) {
        blockMapper.upsertBlock(block);
        log.info("[ChatbotBlock] 차단 등록/갱신: type={}, value={}, by={}",
                block.getBlockType(), block.getBlockValue(), block.getBlockedBy());
    }

    public void deactivateBlock(Long blockId) {
        blockMapper.deactivateBlock(blockId);
        log.info("[ChatbotBlock] 차단 해제: blockId={}", blockId);
    }

    public ChatbotBlockVO getBlock(Long blockId) {
        return blockMapper.selectBlock(blockId);
    }

    public List<ChatbotBlockVO> getBlocks(boolean onlyActive) {
        return blockMapper.selectBlocks(onlyActive);
    }
}
