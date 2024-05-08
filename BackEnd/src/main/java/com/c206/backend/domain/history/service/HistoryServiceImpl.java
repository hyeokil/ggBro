package com.c206.backend.domain.history.service;

import com.c206.backend.domain.history.dto.RouteDTO;
import com.c206.backend.domain.history.dto.TrashDTO;
import com.c206.backend.domain.history.dto.response.HistoryDetailResponseDTO;
import com.c206.backend.domain.history.dto.response.HistoryListResponseDTO;
import com.c206.backend.domain.history.exception.HistoryError;
import com.c206.backend.domain.history.exception.HistoryException;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.entity.PloggingRoute;
import com.c206.backend.domain.plogging.entity.Trash;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.repository.PloggingRouteRepository;
import com.c206.backend.domain.plogging.repository.TrashRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService{

    private final PloggingRepository ploggingRepository;

    private final TrashRepository trashRepository;

    private final PloggingRouteRepository ploggingRouteRepository;

    @Override
    public List<HistoryListResponseDTO> historyList(Long memberId) {

        List<Plogging> ploggingList = ploggingRepository.findByMemberId(memberId);

        List<HistoryListResponseDTO> historyList = new ArrayList<>();

        for(Plogging plogItem : ploggingList){
            HistoryListResponseDTO historyListResponseDto = new HistoryListResponseDTO(
                    plogItem.getId(),
                    plogItem.getCreatedAt(),
                    plogItem.getUpdatedAt(),
                    plogItem.getMemberPet().getId(),
                    12.1,
                    33,
                    "testImage"
            );
            historyList.add(historyListResponseDto);
        }

        return historyList;
    }

    @Override
    public HistoryDetailResponseDTO historyDetail(Long memberId, Long ploggingId) {

        //플로깅 찾기
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(() ->
        new HistoryException(HistoryError.NOT_FOUND_PLOGGING));

        // 찾은 플로깅이 회원과 일치하는지 체크
        if(!Objects.equals(plogging.getMember().getId(), memberId)){
            throw new HistoryException(HistoryError.NOT_FOUND_MEMBER_PLOGGING);
        }

        //임의로 쓰레기 데이터 설정. 위도 경도의 자료형은 추후 달라질 수 있다.
        List<TrashDTO> trashDTOList = new ArrayList<>();
        List<Trash> trashList = trashRepository.findByPloggingId(ploggingId);

        for(Trash trashItem : trashList){
            TrashDTO trashDTO = new TrashDTO(
                    trashItem.getLatitude(),
                    trashItem.getLongitude(),
                    trashItem.getTrashType(),
                    trashItem.getImage()
            );

            trashDTOList.add(trashDTO);
        }




        //임의로 경로 데이터 설정. 위도 경도의 자료형은 추후 달라질 수 있다.
        List<RouteDTO> routeDTOList = new ArrayList<>();
        List<PloggingRoute> ploggingRouteList = ploggingRouteRepository.findByPloggingId(ploggingId);

        for(PloggingRoute routeItem : ploggingRouteList){
            RouteDTO routeDTO = new RouteDTO(
                    routeItem.getLatitude(),
                    routeItem.getLongitude()
            );

            routeDTOList.add(routeDTO);
        }


        HistoryDetailResponseDTO historyDetail = new HistoryDetailResponseDTO(
                ploggingId,
                trashDTOList,
                routeDTOList
        );


        return historyDetail;
    }
}
