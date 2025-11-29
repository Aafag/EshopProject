package qa.udst.eshop.service;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.*;

@Service
public class FlagService {
    private final RestTemplate rest = new RestTemplate();
    private final String apiKey = "JXNn4TZXYVoeEnUeWej49d";
    private final String url = "https://api.flagsmith.com/api/v1/flags/";

    public Map<String, Boolean> getFlagsRawByName() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        ResponseEntity<List> res = rest.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), List.class);
        Map<String, Boolean> out = new HashMap<>();
        List<Map<String, Object>> list = res.getBody();
        if (list != null) {
            for (Map<String, Object> f : list) {
                Map<String, Object> feature = (Map<String, Object>) f.get("feature");
                String name = feature != null ? (String) feature.get("name") : null;
                Boolean enabled = (Boolean) f.get("enabled");
                if (name != null && enabled != null)
                    out.put(name, enabled);
            }
        }
        return out;
    }
}
