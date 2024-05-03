package com.c206.backend.domain.plogging.service.Impl;

import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.exception.PloggingError;
import com.c206.backend.domain.plogging.exception.PloggingException;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.service.TrashService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TrashServiceImpl implements TrashService {

    private final PloggingRepository ploggingRepository;

    @Value("${aws.s3.bucket}")
    private String bucket;




    @Override
    public CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto) {
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(()
                -> new PloggingException(PloggingError.NOT_FOUND_PLOGGING));
        try {


        }
        return null;
    }
}
