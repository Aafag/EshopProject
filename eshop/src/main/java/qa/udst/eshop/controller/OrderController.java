package qa.udst.eshop.controller;

import org.springframework.web.bind.annotation.*;
import qa.udst.eshop.model.Order;
import qa.udst.eshop.model.OrderStatus;
import qa.udst.eshop.service.OrderService;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public Order placeOrder() {
        return orderService.placeOrder();
    }

    @GetMapping
    public List<Order> getOrders() {
        return orderService.getAllOrders();
    }

    @PutMapping("/{orderId}/status")
    public Order updateStatus(@PathVariable Long orderId, @RequestParam OrderStatus status) {
        return orderService.updateStatus(orderId, status);
    }
}
