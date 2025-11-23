package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import qa.udst.eshop.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

    // ✅ Search by product name (case-insensitive)
    Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);

    // ✅ Filter by category ID
    Page<Product> findByCategoryId(Long categoryId, Pageable pageable);
}
