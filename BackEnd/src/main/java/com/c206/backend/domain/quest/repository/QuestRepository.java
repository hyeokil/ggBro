package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.Quest;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface QuestRepository extends JpaRepository<Quest, Long> {

    List<Quest> findByMemberId(Long memberId);
}
