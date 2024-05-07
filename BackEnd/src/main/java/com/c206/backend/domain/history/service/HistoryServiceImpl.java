package com.c206.backend.domain.history.service;

import com.c206.backend.domain.history.dto.response.HistoryListResponseDto;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService{

    private final PloggingRepository ploggingRepository;

    @Override
    public List<HistoryListResponseDto> historyList() {


        return null;
    }
}
