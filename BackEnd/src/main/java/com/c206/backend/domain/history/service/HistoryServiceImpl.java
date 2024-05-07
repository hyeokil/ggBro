package com.c206.backend.domain.history.service;

import com.c206.backend.domain.history.dto.response.HistoryListResponseDto;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService{

    private final PloggingRepository ploggingRepository;

    @Override
    public List<HistoryListResponseDto> historyList(Long memberId) {

        List<Plogging> ploggingList = ploggingRepository.findByMemberId(memberId);

        List<HistoryListResponseDto> historyList = new ArrayList<>();

        for(Plogging plogItem : ploggingList){
            HistoryListResponseDto historyListResponseDto = new HistoryListResponseDto(
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
}
