package qa.udst.eshop.service;

import org.springframework.stereotype.Service;
import qa.udst.eshop.model.*;
import qa.udst.eshop.repository.CartItemRepository;
import qa.udst.eshop.repository.OrderItemRepository;
import qa.udst.eshop.repository.OrderRepository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {
    private final OrderRepository orderRepo;
    private final OrderItemRepository orderItemRepo;
    private final CartItemRepository cartRepo;

    public OrderService(OrderRepository orderRepo, OrderItemRepository orderItemRepo, CartItemRepository cartRepo) {
        this.orderRepo = orderRepo;
        this.orderItemRepo = orderItemRepo;
        this.cartRepo = cartRepo;
    }

    public Order placeOrder() {
        List<CartItem> cartItems = cartRepo.findAll();
        if (cartItems.isEmpty())
            throw new IllegalStateException("Cart is empty");

        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setUnitPrice(cartItem.getUnitPrice());
            orderItem.setLineTotal(cartItem.getLineTotal());
            orderItems.add(orderItem);
            total = total.add(cartItem.getLineTotal());
        }

        Order order = new Order();
        order.setItems(orderItems);
        order.setTotal(total);
        order.setStatus(OrderStatus.PENDING);
        order.setCreatedAt(LocalDateTime.now());
        order = orderRepo.save(order);

        for (OrderItem item : orderItems) {
            item.setOrder(order);
            orderItemRepo.save(item);
        }

        cartRepo.deleteAll();
        return order;
    }

    public List<Order> getAllOrders() {
        return orderRepo.findAll();
    }

    public Order updateStatus(Long orderId, OrderStatus status) {
        Order order = orderRepo.findById(orderId).orElseThrow();
        order.setStatus(status);
        return orderRepo.save(order);
    }
}
