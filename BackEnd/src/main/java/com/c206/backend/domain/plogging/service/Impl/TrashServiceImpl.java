package com.c206.backend.domain.plogging.service.Impl;

import com.amazonaws.services.s3.AmazonS3;
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

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TrashServiceImpl implements TrashService {

    private final PloggingRepository ploggingRepository;

    @Value("${aws.s3.bucket}")
    private String bucket;

    private AmazonS3 amazonS3;

    @Override
    public CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto) {
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(()
                -> new PloggingException(PloggingError.NOT_FOUND_PLOGGING));
        // 바이트로 들어온 데이터를 다시 이미지로 변화 해야한다
        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(createTrashRequestDto.getImage());
            BufferedImage image = ImageIO.read(bis);
        } catch (IOException e) {
            throw new PloggingException(PloggingError.IMAGE_CONVERSION_ERROR);
        };
        // 이미지로 변환해서 s3에 저장
        String fileName =

        // 플라스크로 보내서 종류 가져오기




        }
        return null;
    }
}
