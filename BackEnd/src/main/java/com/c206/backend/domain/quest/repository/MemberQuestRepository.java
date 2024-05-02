package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.MemberQuest;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberQuestRepository extends JpaRepository<MemberQuest, Long> {
}
