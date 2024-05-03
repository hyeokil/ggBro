package com.c206.backend.domain.plogging.service;

import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;

public interface TrashService {

    CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto);

}
