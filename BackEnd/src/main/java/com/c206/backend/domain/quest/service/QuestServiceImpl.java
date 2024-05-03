package com.c206.backend.domain.quest.service;

import com.c206.backend.domain.quest.entity.Quest;
import com.c206.backend.domain.quest.repository.MemberQuestRepository;
import com.c206.backend.domain.quest.repository.QuestRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class QuestServiceImpl implements QuestService{

    private final QuestRepository questRepository;
    private final MemberQuestRepository memberQuestRepository;
    @Override
    public List<Quest> getQuestList(Long memberId) {
        List<Quest> findedQuestList = memberQuestRepository.findByMemberId(memberId);
        return findedQuestList;
    }
}
