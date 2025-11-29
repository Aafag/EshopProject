package qa.udst.eshop.controller;

import org.springframework.web.bind.annotation.*;
import java.util.*;
import qa.udst.eshop.flags.FeatureFlags; // use this if SDK
// import qa.udst.eshop.service.FlagService;   // use this if RestTemplate

@RestController
@RequestMapping("/api")
public class FlagsController {

    // For SDK:
    @GetMapping("/flags")
    public Map<String, Boolean> getFlags() {
        Map<String, Boolean> flags = new HashMap<>();
        flags.put("wishlist_enabled", FeatureFlags.isEnabled("wishlist"));
        flags.put("enable_paypal", FeatureFlags.isEnabled("payment-methods"));
        flags.put("ordermanagment_enabled", FeatureFlags.isEnabled("ordermanagment"));
        flags.put("search_enabled", FeatureFlags.isEnabled("find-search"));
        flags.put("flash_sale", FeatureFlags.isEnabled("flash-sale")); // optional
        return flags;
    }

    // If RestTemplate (uncomment and inject FlagService):
    // private final FlagService flagService;
    // public FlagsController(FlagService flagService) { this.flagService =
    // flagService; }
    // @GetMapping("/flags")
    // public Map<String, Boolean> getFlags() {
    // Map<String, Boolean> raw = flagService.getFlagsRawByName();
    // Map<String, Boolean> flags = new HashMap<>();
    // flags.put("wishlist_enabled", raw.getOrDefault("wishlist", false));
    // flags.put("enable_paypal", raw.getOrDefault("payment-methods", false));
    // flags.put("ordermanagment_enabled", raw.getOrDefault("ordermanagment",
    // false));
    // flags.put("search_enabled", raw.getOrDefault("find-search", false));
    // flags.put("flash_sale", raw.getOrDefault("flash-sale", false));
    // return flags;
    // }
}
