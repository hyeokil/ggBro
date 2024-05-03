package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.MemberQuest;
import com.c206.backend.domain.quest.entity.Quest;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemberQuestRepository extends JpaRepository<MemberQuest, Long> {
    List<MemberQuest> findByMemberId(Long memberId);
}
