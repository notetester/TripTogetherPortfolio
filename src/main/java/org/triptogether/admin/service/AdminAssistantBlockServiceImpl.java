package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminAssistantBlockMapper;
import org.triptogether.admin.vo.AdminAssistantBlockVO;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAssistantBlockServiceImpl implements AdminAssistantBlockService {

    private final AdminAssistantBlockMapper blockMapper;

    @Override
    public List<AdminAssistantBlockVO> getBlocks(boolean activeOnly) {
        return blockMapper.selectBlocks(activeOnly);
    }

    @Override
    public boolean isBlocked(Long userIdx, String ipAddress) {
        if (userIdx != null) {
            AdminAssistantBlockVO userBlock =
                    blockMapper.selectActiveBlock("USER", String.valueOf(userIdx));
            if (userBlock != null) return true;
        }
        if (ipAddress != null && !ipAddress.isBlank()) {
            AdminAssistantBlockVO ipBlock = blockMapper.selectActiveBlock("IP", ipAddress);
            if (ipBlock != null) return true;
        }
        return false;
    }

    @Override
    @Transactional
    public void upsertBlock(AdminAssistantBlockVO block) {
        // 기존 활성 차단 있으면 먼저 비활성화 (UNIQUE(is_active, block_type, block_value) 충돌 방지)
        AdminAssistantBlockVO existing =
                blockMapper.selectActiveBlock(block.getBlockType(), block.getBlockValue());
        if (existing != null) {
            blockMapper.deactivateBlock(existing.getBlockId());
        }
        blockMapper.insertBlock(block);
        log.info("[AssistantBlock] 등록 type={}, value={}, by={}",
                block.getBlockType(), block.getBlockValue(), block.getBlockedBy());
    }

    @Override
    public void deactivateBlock(Long blockId) {
        blockMapper.deactivateBlock(blockId);
        log.info("[AssistantBlock] 해제 blockId={}", blockId);
    }
}
