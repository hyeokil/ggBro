package com.c206.backend.domain.history.service;

import com.c206.backend.domain.history.dto.response.HistoryDetailResponseDTO;
import com.c206.backend.domain.history.dto.response.HistoryListResponseDTO;

import java.util.List;

public interface HistoryService {

    List<HistoryListResponseDTO> historyList(Long memberId);


    HistoryDetailResponseDTO historyDetail(Long memberId, Long ploggingId);

}
