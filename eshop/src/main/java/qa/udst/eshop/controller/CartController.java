package qa.udst.eshop.controller;

import org.springframework.web.bind.annotation.*;
import qa.udst.eshop.model.CartItem;
import qa.udst.eshop.service.CartService;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")

@RequestMapping("/api/cart")
public class CartController {
    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping
    public List<CartItem> getCart() {
        return cartService.getCartItems();
    }

    @PostMapping("/{productId}")
    public CartItem addToCart(@PathVariable Long productId, @RequestParam int quantity) {
        return cartService.addToCart(productId, quantity);
    }

    @DeleteMapping("/{itemId}")
    public void removeFromCart(@PathVariable Long itemId) {
        cartService.removeFromCart(itemId);
    }

    @DeleteMapping("/clear")
    public void clearCart() {
        cartService.clearCart();
    }
}
