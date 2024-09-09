package SpringAuditJPA.listener;

import SpringAuditJPA.entity.Product;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreRemove;
import jakarta.persistence.PreUpdate;

public class AuditProductListener {

    @PrePersist
    private void prePersist(Product product){

    }

    @PreUpdate
    private void preUpdate(Product product){

    }

    @PreRemove
    private void preRemove(Product product){

    }
}
