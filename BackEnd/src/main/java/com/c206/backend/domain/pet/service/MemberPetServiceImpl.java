package com.c206.backend.domain.pet.service;

import com.c206.backend.domain.pet.dto.response.MemberPetDetailResponseDto;
import com.c206.backend.domain.pet.dto.response.MemberPetListResponseDto;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.domain.pet.exception.MemberPetError;
import com.c206.backend.domain.pet.exception.MemberPetException;
import com.c206.backend.domain.pet.repository.MemberPetRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MemberPetServiceImpl implements MemberPetService {

    private final MemberPetRepository memberPetRepository;
//    private final PloggingRepository ploggingRepository;
//    private final TrashRepository trashRepository;

    @Override
    public List<MemberPetListResponseDto> getMemberPetList(Long memberId) {
        List<MemberPet> memberPets = memberPetRepository.findByMemberId(memberId);
        List<MemberPetListResponseDto> memberPetListResponseDtoList = new ArrayList<>();
        for (MemberPet memberPet : memberPets) {
            MemberPetListResponseDto memberPetListResponseDto = new MemberPetListResponseDto(
                    memberPet.getId(),
                    memberPet.isActive(),
                    memberPet.getPet().getImage()
            );
            memberPetListResponseDtoList.add(memberPetListResponseDto);
        }
        return memberPetListResponseDtoList;
    }

    @Override
    public MemberPetDetailResponseDto getMemberPetDetail(Long memberPetId) {
        MemberPet memberPet = memberPetRepository.findById(memberPetId).orElseThrow(()
                -> new MemberPetException(MemberPetError.NOT_FOUND_MEMBER_PET));
        // 조회 한번에 너무 많은 리소스 사용 -> 쓰레기 주울시 컬럼에 추가하는 것으로 변경
//        List<Plogging> ploggings = ploggingRepository.findByMemberPetId(memberPetId);
//        int normal, plastic, can, glass;
//        for (Plogging plogging : ploggings) {
//            List<Trash> trashes = trashRepository.findByPloggingId(plogging.getId());
//            for (Trash trash : trashes) {
//                if (trash.getTrashType()== TrashType.NORMAL) {
//                    normal += 1;
//                } else if (trash.getTrashType() == TrashType.PLASTIC) {
//                    plastic += 1;
//                } else if (trash.getTrashType() == TrashType.CAN) {
//                    can += 1;
//                } else {
//                    glass += 1;
//                }
//            }
//
//        }
        return new MemberPetDetailResponseDto(
                memberPet.getNickname(),
                memberPet.isActive(),
                memberPet.getExp(),
                memberPet.getPet().getImage(),
                memberPet.getNormal(),
                memberPet.getPlastic(),
                memberPet.getCan(),
                memberPet.getGlass()

        );
    }
}
