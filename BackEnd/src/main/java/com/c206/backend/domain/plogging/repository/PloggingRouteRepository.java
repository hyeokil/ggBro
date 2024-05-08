package com.c206.backend.domain.plogging.repository;

import com.c206.backend.domain.plogging.entity.PloggingRoute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PloggingRouteRepository extends JpaRepository<PloggingRoute, Long> {

}
