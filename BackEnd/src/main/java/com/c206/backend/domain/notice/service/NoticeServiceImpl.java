package com.c206.backend.domain.notice.service;


import com.c206.backend.domain.notice.dto.response.NoticeListResponseDto;
import com.c206.backend.domain.notice.entity.Notice;
import com.c206.backend.domain.notice.repository.NoticeRepository;
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
public class NoticeServiceImpl implements NoticeService{

    private final NoticeRepository noticeRepository;
    @Override
    public List<NoticeListResponseDto> noticeList() {
        List<Notice> noticeList = noticeRepository.findAll();
        List<NoticeListResponseDto> noticeResList = new ArrayList<>();

        for(Notice noticeItem : noticeList){
            NoticeListResponseDto noticeListResponseDto = new NoticeListResponseDto(noticeItem.getId(), noticeItem.getImage(), noticeItem.getTitle());
            noticeResList.add(noticeListResponseDto);
        }

        return noticeResList;
    }
}