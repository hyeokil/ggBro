package com.c206.backend.domain.quest.service;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.repository.MemberRepository;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.domain.pet.entity.Pet;
import com.c206.backend.domain.pet.repository.MemberPetRepository;
import com.c206.backend.domain.quest.dto.response.MemberQuestListResponseDto;
import com.c206.backend.domain.quest.entity.MemberQuest;
import com.c206.backend.domain.quest.entity.Quest;
import com.c206.backend.domain.quest.repository.MemberQuestRepository;
import com.c206.backend.domain.quest.repository.QuestRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class QuestServiceImpl implements QuestService{

    private final MemberRepository memberRepository;
    private final QuestRepository questRepository;
    private final MemberQuestRepository memberQuestRepository;
    private final MemberPetRepository memberPetRepository;
    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<MemberQuestListResponseDto> getQuestList(Long memberId) {
        List<MemberQuest> findedQuestList = memberQuestRepository.findByMemberId(memberId);
        List<MemberQuestListResponseDto> resList = new ArrayList<>();
        for(MemberQuest findedQuest : findedQuestList){
            MemberQuestListResponseDto resItem = MemberQuestListResponseDto.builder()
                    .goal(findedQuest.getGoal())
                    .progress(findedQuest.getProgress())
                    .is_done(findedQuest.isDone())
                    .member_id(findedQuest.getMember())
                    .quest_id(findedQuest.getQuest())
                    .build();
            resList.add(resItem);
        }
        return resList;
    }

    @Override
    public void addQuestList(Long memberId) {
        //사용자아이디
        Member member = memberRepository.findById(memberId).get();
        // 리스트 중 랜덤하게, 혹은 사용자 맞춤으로 3개 뽑을것
        List<Quest> questInfoList = questRepository.findAll();
        // 펫 중 랜덤하게, 혹은 사용자 맞춤으로 1개 뽑을것
        List<MemberPet> petList = memberPetRepository.findByMemberId(memberId);
        MemberPet selectedPet = petList.get(0);

        for(int i=0; i<3; i++){
            MemberQuest memberQuest = MemberQuest.builder()
                    .member(member)
                    .memberPet(selectedPet)
                    .quest(questInfoList.get(i))
                    .goal(questInfoList.get(i).getGoalMax()) // 사용자 맞춤으로 계수를 곱하고, 그렇게 나온 Max, Min의 랜덤값으로 지정
                    .progress(0)
                    .isDone(false)
                    .build();
            memberQuestRepository.save(memberQuest);
        }
    }
}
