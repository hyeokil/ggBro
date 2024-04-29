package com.c206.backend.domain.plogging.repository;

import com.c206.backend.domain.plogging.entity.Trash;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrashRepository extends JpaRepository<Trash, Long> {
    List<Trash> findByPloggingId(Long ploggingId);

}
