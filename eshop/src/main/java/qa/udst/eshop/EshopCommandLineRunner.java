package qa.udst.eshop;

import java.math.BigDecimal;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import qa.udst.eshop.model.*;
import qa.udst.eshop.repository.*;

@Component
public class EshopCommandLineRunner implements CommandLineRunner {

    // Inject repositories
    private final CategoryRepository categoryRepo;
    private final ProductRepository productRepo;
    private final PaymentOptionRepository paymentRepo;

    public EshopCommandLineRunner(CategoryRepository categoryRepo, ProductRepository productRepo,
            PaymentOptionRepository paymentRepo) {
        this.categoryRepo = categoryRepo;
        this.productRepo = productRepo;
        this.paymentRepo = paymentRepo;
    }

    @Override
    public void run(String... args) throws Exception {
        System.out.println("\n E-SHOP SEED DATA STARTING ");
        System.out.println("Loading test data for demo...\n");

        // Seed Categories
        Category electronics = new Category();
        electronics.setName("Electronics");
        electronics = categoryRepo.save(electronics);

        Category fashion = new Category();
        fashion.setName("Fashion");
        fashion = categoryRepo.save(fashion);

        Category books = new Category();
        books.setName("Books");
        books = categoryRepo.save(books);

        System.out.println("Categories created: Electronics, Fashion, Books");

        // Seed Products
        Product laptop = new Product();
        laptop.setName("MacBook Pro");
        laptop.setDescription("16-inch, M2 Pro, 512GB SSD");
        laptop.setPrice(new BigDecimal("1299.00"));
        laptop.setStock(10);
        laptop.setImageName("macbook.png"); // ✅ local asset filename
        laptop.setCategory(electronics);
        productRepo.save(laptop);

        Product tshirt = new Product();
        tshirt.setName("Cotton T-Shirt");
        tshirt.setDescription("Black, size M, 100% cotton");
        tshirt.setPrice(new BigDecimal("19.99"));
        tshirt.setStock(100);
        tshirt.setImageName("tshirt.jpg"); // ✅ local asset filename
        tshirt.setCategory(fashion);
        productRepo.save(tshirt);

        Product ebook = new Product();
        ebook.setName("Flutter for Beginners");
        ebook.setDescription("Digital eBook, PDF format");
        ebook.setPrice(new BigDecimal("9.99"));
        ebook.setStock(999);
        ebook.setImageName("ebook.png"); // ✅ local asset filename
        ebook.setCategory(books);
        productRepo.save(ebook);

        System.out.println("Products added: MacBook Pro, T-Shirt, eBook");

        // Seed Payment Options
        PaymentOption card = new PaymentOption();
        card.setMethod(PaymentMethod.CREDIT_CARD);
        card.setDisplayName("Visa / Mastercard");
        paymentRepo.save(card);

        PaymentOption paypal = new PaymentOption();
        paypal.setMethod(PaymentMethod.PAYPAL);
        paypal.setDisplayName("PayPal");
        paymentRepo.save(paypal);

        System.out.println("Payment methods: Credit Card, PayPal");

        // Test
        System.out.println("\nSEED DATA LOADED SUCCESSFULLY!");
        System.out.println("Open H2 Console: http://localhost:8080/h2-console");
        System.out.println("JDBC URL: jdbc:h2:mem:eshopdb | User: sa | Pass: (empty)\n");
        System.out.println("=== READY FOR TESTING ===\n");
    }
}
