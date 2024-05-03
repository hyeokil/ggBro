package com.c206.backend.domain.quest.service;

import com.c206.backend.domain.quest.entity.Quest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface QuestService {

    List<Quest> getQuestList(Long memberId);

}
