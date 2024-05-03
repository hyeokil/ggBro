package com.c206.backend.domain.plogging.service.Impl;


import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.exception.MemberError;
import com.c206.backend.domain.member.exception.MemberException;
import com.c206.backend.domain.member.repository.MemberRepository;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.domain.pet.exception.PetError;
import com.c206.backend.domain.pet.exception.PetException;
import com.c206.backend.domain.pet.repository.MemberPetRepository;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.service.PloggingService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class PloggingServiceImpl implements PloggingService {

    private final MemberRepository memberRepository;
    private final MemberPetRepository memberPetRepository;
    private final PloggingRepository ploggingRepository;

    @Override
    public Long createPlogging(Long memberPetId, Long memberId) {
        Member member = memberRepository.findById(memberId).orElseThrow(()
                -> new MemberException(MemberError.NOT_FOUND_MEMBER));
        MemberPet memberPet = memberPetRepository.findById(memberPetId).orElseThrow(()
                -> new PetException(PetError.NOT_FOUND_MEMBER_PET));
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        Plogging plogging = ploggingRepository.save(Plogging.builder()
                .member(member)
                .memberPet(memberPet)
                .time(now.format(formatter) + " ~ ")
                .distance(0)
                .build());
        return plogging.getId();
    }
}
