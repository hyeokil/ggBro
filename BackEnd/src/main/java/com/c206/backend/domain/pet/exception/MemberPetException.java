package com.c206.backend.domain.pet.exception;

import lombok.Getter;

@Getter
public class MemberPetException extends RuntimeException {
    private final MemberPetError errorCode;
    private final int status;
    private final String errorMessage;

    public MemberPetException(MemberPetError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
