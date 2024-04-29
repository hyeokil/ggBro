package com.c206.backend.domain.pet.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PetError {

    NOT_FOUND_MEMBER_PET(HttpStatus.INTERNAL_SERVER_ERROR, "해당 펫을 찾을 수 없습니다."),
    NOT_FOUND_PET(HttpStatus.INTERNAL_SERVER_ERROR, "해당 펫을 찾을 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
