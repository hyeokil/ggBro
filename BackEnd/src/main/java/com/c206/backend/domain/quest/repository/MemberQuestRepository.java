package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.MemberQuest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberQuestRepository extends JpaRepository<MemberQuest, Long> {
    List<MemberQuest> findByMemberId(Long memberId);
    MemberQuest findTopByMemberIdAndQuestIdOrderByIdDesc(Long memberId, Long questId);
//    MemberQuest findByMemberQuestId(Long memberQuestId);
}
