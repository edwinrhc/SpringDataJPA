package SpringAuditJPA.repository;

import SpringAuditJPA.entity.History;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HistoryRepository extends CrudRepository<History,Integer> {
}
