package SpringAuditJPA.listener;

import SpringAuditJPA.entity.History;
import SpringAuditJPA.entity.Product;
import SpringAuditJPA.repository.HistoryRepository;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreRemove;
import jakarta.persistence.PreUpdate;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor(onConstructor = @__(@Lazy)) // Inyecta por de bajo la anotacion
public class AuditProductListener {


    private final HistoryRepository historyRepository;

    @PrePersist
    private void prePersist(Product product){
       saveHistory(product,"INSERT");
    }

    @PreUpdate
    private void preUpdate(Product product){
        saveHistory(product,"UPDATE");
    }

    @PreRemove
    private void preRemove(Product product){
        saveHistory(product,"DELETE");
    }

    private void saveHistory(Product product, String operation){
        String user = SecurityContextHolder.getContext().getAuthentication().getName();

        History history = new History();
        history.setName(product.getName());
        history.setDate(LocalDateTime.now());
        history.setOperation(operation);
        history.setUser(user);
        historyRepository.save(history);
    }
}
