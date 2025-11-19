package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.PaymentOption;

public interface PaymentOptionRepository extends JpaRepository<PaymentOption, Long> {
}