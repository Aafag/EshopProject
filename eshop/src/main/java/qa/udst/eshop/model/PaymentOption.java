package qa.udst.eshop.model;

import jakarta.persistence.*;

@Entity
public class PaymentOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private PaymentMethod method;

    private String displayName; // e.g., "PayPal", "Visa"

    // === NEW FEATURE: PaymentOption – getters/setters ===
    public Long getId() { 
        return id; 
    }
    public void setId(Long id) { 
        this.id = id; 
    }

    public PaymentMethod getMethod() { 
        return method; 
    }
    public void setMethod(PaymentMethod method) { 
        this.method = method; 
    }

    public String getDisplayName() {
         return displayName; 
        }
    public void setDisplayName(String displayName) {
         this.displayName = displayName;
         }
}