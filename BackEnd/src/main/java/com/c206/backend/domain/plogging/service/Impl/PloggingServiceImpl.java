package com.c206.backend.domain.plogging.service.Impl;


import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.exception.MemberError;
import com.c206.backend.domain.member.exception.MemberException;
import com.c206.backend.domain.member.repository.MemberRepository;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.domain.pet.exception.PetError;
import com.c206.backend.domain.pet.exception.PetException;
import com.c206.backend.domain.pet.repository.MemberPetRepository;
import com.c206.backend.domain.plogging.dto.LocationInfo;
import com.c206.backend.domain.plogging.dto.request.FinishPloggingRequestDto;
import com.c206.backend.domain.plogging.dto.response.GetTrashResponseDto;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.entity.PloggingRoute;
import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.c206.backend.domain.plogging.exception.PloggingError;
import com.c206.backend.domain.plogging.exception.PloggingException;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.repository.PloggingRouteRepository;
import com.c206.backend.domain.plogging.repository.TrashRepository;
import com.c206.backend.domain.plogging.service.PloggingService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class PloggingServiceImpl implements PloggingService {

    private final MemberRepository memberRepository;
    private final MemberPetRepository memberPetRepository;
    private final PloggingRepository ploggingRepository;
    private final TrashRepository trashRepository;
    private final PloggingRouteRepository ploggingRouteRepository;
    private final TrashServiceImpl trashServiceImpl;

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

    @Override
    public GetTrashResponseDto finishPlogging(Long ploggingId, FinishPloggingRequestDto finishPloggingRequestDto) {
        List<Object[]> results = trashRepository.countTrashByPloggingId(ploggingId);
        int normal=0,plastic = 0,can=0,glass=0;
        for (Object[] result : results) {
            int count = ((Number) result[1]).intValue();
            switch ((TrashType) result[0]) {
                case NORMAL -> normal = count;
                case PLASTIC -> plastic = count;
                case CAN -> can = count;
                case GLASS -> glass = count;
            }
        }
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(()
                -> new PloggingException(PloggingError.NOT_FOUND_PLOGGING));
        plogging.updateDistance(finishPloggingRequestDto.getDistance());
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        plogging.updateTime(now.format(formatter));
//       플로깅 1회 업적 진행상황 동기화
        trashServiceImpl.updateMemberAchievement(plogging.getMember().getId(),1L,1);
//        플로깅한 거리
        trashServiceImpl.updateMemberAchievement(plogging.getMember().getId(),
                2L,
                finishPloggingRequestDto.getDistance());

        for (LocationInfo path : finishPloggingRequestDto.getPath()) {
            ploggingRouteRepository.save(PloggingRoute.builder()
                    .plogging(plogging)
                    .latitude(path.getLatitude())
                    .longitude(path.getLongitude())
                    .build());
        }
        return new GetTrashResponseDto(
                normal,
                plastic,
                can,
                glass
        );
    }
}
