package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SecurityProviderSecretResolver {

    private final Environment environment;

    public String resolve(String apiKeyRef) {
        if (apiKeyRef == null || apiKeyRef.isBlank()) {
            return null;
        }
        if (apiKeyRef.startsWith("ENV:")) {
            return environment.getProperty(apiKeyRef.substring("ENV:".length()));
        }
        if (apiKeyRef.startsWith("PROP:")) {
            return environment.getProperty(apiKeyRef.substring("PROP:".length()));
        }
        return apiKeyRef;
    }
}
