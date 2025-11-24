package qa.udst.eshop.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import qa.udst.eshop.model.PaymentOption;
import qa.udst.eshop.repository.PaymentOptionRepository;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")

@RequestMapping("/api/payment-options")
public class PaymentOptionController {

    private final PaymentOptionRepository paymentRepo;

    public PaymentOptionController(PaymentOptionRepository paymentRepo) {
        this.paymentRepo = paymentRepo;
    }

    //  Get all available payment methods
    @GetMapping
    public List<PaymentOption> getAll() {
        return paymentRepo.findAll();
    }
}
