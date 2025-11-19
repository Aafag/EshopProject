package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.WishlistItem;

public interface WishlistItemRepository extends JpaRepository<WishlistItem, Long> {
}