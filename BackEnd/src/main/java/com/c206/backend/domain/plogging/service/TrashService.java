package com.c206.backend.domain.plogging.service;

import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.request.GetTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;
import com.c206.backend.domain.plogging.dto.response.GetTrashResponseDto;

public interface TrashService {

    CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto);

    GetTrashResponseDto getTrashList(GetTrashRequestDto getTrashRequestDto);

}
