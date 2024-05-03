package com.c206.backend.domain.plogging.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PloggingError {

    NOT_FOUND_PLOGGING(HttpStatus.INTERNAL_SERVER_ERROR, "해당 플로깅을 찾을 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
