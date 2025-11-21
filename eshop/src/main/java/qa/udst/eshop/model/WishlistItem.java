package qa.udst.eshop.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;

@Entity
public class WishlistItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "wishlist_id")
    @JsonIgnore
    private Wishlist wishlist;

    // === NEW FEATURE: WishlistItem – getters/setters ===
    public Long getId() { 
        return id; 
    }
    public void setId(Long id) { 
        this.id = id;
     }

    public Product getProduct() { 
        return product; 
    }
    public void setProduct(Product product) { 
        this.product = product; 
    }

    public Wishlist getWishlist() { 
        return wishlist; 
    }

    public void setWishlist(Wishlist wishlist) { 
        this.wishlist = wishlist;
     }

}
