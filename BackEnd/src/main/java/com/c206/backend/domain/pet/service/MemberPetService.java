package com.c206.backend.domain.pet.service;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.pet.dto.response.MemberPetDetailResponseDto;
import com.c206.backend.domain.pet.dto.response.MemberPetListResponseDto;
import com.c206.backend.domain.pet.dto.response.PetListResponseDto;

import java.util.List;

public interface MemberPetService {

    // 회원이 보유한 펫 리스트 조회
    List<MemberPetListResponseDto> getMemberPetList(Long memberId);

    // 회원이 보유한 펫 상세조회
    MemberPetDetailResponseDto getMemberPetDetail(Long memberId, Long memberPetId, boolean isRedis);

    // 펫 구출하기 (회원 펫 생성)
    Boolean rescuePet(Long memberId);

    //회원가입 시 펫 1개 기본 지급해 주기
    void provideBasePet(Member member);

    //펫 닉네임 변경
    boolean updatePetNickname(Long memberId, Long memberPetId, String petNickname);

    boolean activePet(Long memberId, Long memberPetId);

    List<PetListResponseDto> getPetList(Long memberId);

}
