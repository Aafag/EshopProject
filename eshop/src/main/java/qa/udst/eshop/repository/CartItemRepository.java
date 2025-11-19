package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
}
