package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.OrderItem;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}
