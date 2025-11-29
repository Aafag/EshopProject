package qa.udst.eshop.flags;

import com.flagsmith.FlagsmithClient;
import com.flagsmith.config.FlagsmithConfig;
import com.flagsmith.exceptions.FlagsmithClientError;
import com.flagsmith.models.Flags;

public final class FeatureFlags {
    private static final String API_KEY = "JXNn4TZXYVoeEnUeWej49d";
    private static final String API_URL = null;
    private static volatile FlagsmithClient client;

    private FeatureFlags() {
    }

    public static boolean isEnabled(String featureName) {
        ensureClient();
        try {
            Flags env = client.getEnvironmentFlags();
            Boolean v = env.isFeatureEnabled(featureName);
            return Boolean.TRUE.equals(v);
        } catch (FlagsmithClientError e) {
            throw new RuntimeException("Flagsmith error for '" + featureName + "'", e);
        }
    }

    private static void ensureClient() {
        if (client != null)
            return;
        synchronized (FeatureFlags.class) {
            if (client != null)
                return;
            FlagsmithClient.Builder b = FlagsmithClient.newBuilder().setApiKey(API_KEY);
            if (API_URL != null && !API_URL.isBlank()) {
                b = b.withConfiguration(FlagsmithConfig.newBuilder().baseUri(API_URL).build());
            }
            client = b.build();
        }
    }
}
