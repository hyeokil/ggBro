package com.c206.backend.domain.pet.service;

import com.c206.backend.domain.pet.dto.response.MemberPetDetailResponseDto;
import com.c206.backend.domain.pet.dto.response.MemberPetListResponseDto;

import java.util.List;

public interface MemberPetService {

    // 회원이 보유한 펫 리스트 조회
    List<MemberPetListResponseDto> getMemberPetList(Long memberId);

    // 회원이 보유한 펫 상세조회
    MemberPetDetailResponseDto getMemberPetDetail(Long memberId, Long memberPetId);

    // 펫 구출하기 (회원 펫 생성)
    Boolean rescuePet(Long memberId);

}
