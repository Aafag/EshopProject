package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
