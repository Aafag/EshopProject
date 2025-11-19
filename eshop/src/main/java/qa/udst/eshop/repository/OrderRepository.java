package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.Order;
import qa.udst.eshop.model.OrderStatus;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByStatus(OrderStatus status);
}
