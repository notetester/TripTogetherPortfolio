package org.triptogether.assistant.service;

import java.util.List;
import java.util.Map;

public interface AssistantService {
    Map<String, Object> chat(
            String userMessage,
            List<Map<String, String>> history,
            Long userIdx,
            Long chatPostIdx
    );
}

