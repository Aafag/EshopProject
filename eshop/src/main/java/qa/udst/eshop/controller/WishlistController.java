package qa.udst.eshop.controller;

import org.springframework.web.bind.annotation.*;
import qa.udst.eshop.model.WishlistItem;
import qa.udst.eshop.service.WishlistService;

import java.util.List;

@RestController
@RequestMapping("/api/wishlist")
public class WishlistController {

    private final WishlistService wishlistService;

    public WishlistController(WishlistService wishlistService) {
        this.wishlistService = wishlistService;
    }

    //Get wishlist
    @GetMapping
    public List<WishlistItem> getWishlist() {
        return wishlistService.getWishlist();
    }

    //Add to wishlist   
    @PostMapping("/{productId}")
    public WishlistItem addToWishlist(@PathVariable Long productId) {
        return wishlistService.addToWishlist(productId);
    }
//Remove from wishlist
    @DeleteMapping("/{itemId}")
    public void removeFromWishlist(@PathVariable Long itemId) {
        wishlistService.removeFromWishlist(itemId);
    }
}
