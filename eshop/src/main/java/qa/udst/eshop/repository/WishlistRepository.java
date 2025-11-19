package qa.udst.eshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import qa.udst.eshop.model.Wishlist;

public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
}