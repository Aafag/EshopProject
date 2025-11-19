package qa.udst.eshop.service;

import org.springframework.stereotype.Service;
import qa.udst.eshop.model.*;
import qa.udst.eshop.repository.WishlistRepository;
import qa.udst.eshop.repository.WishlistItemRepository;
import qa.udst.eshop.repository.ProductRepository;

import java.util.List;

@Service
public class WishlistService {

    private final WishlistRepository wishlistRepo;
    private final WishlistItemRepository itemRepo;
    private final ProductRepository productRepo;

    // Single wishlist (in-memory simulation for demo)
    private Wishlist wishlist = new Wishlist();

    public WishlistService(WishlistRepository wishlistRepo,
                           WishlistItemRepository itemRepo,
                           ProductRepository productRepo) {
        this.wishlistRepo = wishlistRepo;
        this.itemRepo = itemRepo;
        this.productRepo = productRepo;
        this.wishlist = wishlistRepo.save(this.wishlist); // persist once
    }

    //Get current wishlist items
    public List<WishlistItem> getWishlist() {
        return wishlist.getItems();
    }

    //Add product to wishlist
    public WishlistItem addToWishlist(Long productId) {
        Product product = productRepo.findById(productId).orElse(null);
        if (product == null) return null;

        WishlistItem item = new WishlistItem();
        item.setProduct(product);
        item.setWishlist(wishlist);
        item = itemRepo.save(item);

        wishlist.getItems().add(item);
        wishlistRepo.save(wishlist);
        return item;
    }

    //  Remove from wishlist
    public void removeFromWishlist(Long itemId) {
        WishlistItem item = itemRepo.findById(itemId).orElse(null);
        if (item != null) {
            wishlist.getItems().remove(item);
            itemRepo.delete(item);
            wishlistRepo.save(wishlist);
        }
    }
}
