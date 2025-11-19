package qa.udst.eshop.service;

import org.springframework.stereotype.Service;
import qa.udst.eshop.model.CartItem;
import qa.udst.eshop.model.Product;
import qa.udst.eshop.repository.CartItemRepository;
import qa.udst.eshop.repository.ProductRepository;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CartService {
    private final CartItemRepository cartRepo;
    private final ProductRepository productRepo;

    public CartService(CartItemRepository cartRepo, ProductRepository productRepo) {
        this.cartRepo = cartRepo;
        this.productRepo = productRepo;
    }

    public List<CartItem> getCartItems() {
        return cartRepo.findAll();
    }

    public CartItem addToCart(Long productId, int quantity) {
        Product product = productRepo.findById(productId).orElseThrow();
        CartItem item = new CartItem();
        item.setProduct(product);
        item.setQuantity(quantity);
        item.setUnitPrice(product.getPrice());
        item.setLineTotal(product.getPrice().multiply(BigDecimal.valueOf(quantity)));
        return cartRepo.save(item);
    }

    public void removeFromCart(Long itemId) {
        cartRepo.deleteById(itemId);
    }

    public void clearCart() {
        cartRepo.deleteAll();
    }
}
