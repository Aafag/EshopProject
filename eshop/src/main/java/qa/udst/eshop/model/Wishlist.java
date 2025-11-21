package qa.udst.eshop.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
public class Wishlist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "wishlist", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonBackReference
    private List<WishlistItem> items = new ArrayList<>();

    // === NEW FEATURE: Wishlist – getters/setters ===
    public Long getId() { 
        return id; 
    }
    public void setId(Long id) { 
        this.id = id; 
    }

    public List<WishlistItem> getItems() { 
        return items;
     }

    public void setItems(List<WishlistItem> items) { 
        this.items = items;
     }
    
}
