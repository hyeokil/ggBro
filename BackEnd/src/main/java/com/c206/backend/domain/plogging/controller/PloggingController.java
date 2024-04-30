package com.c206.backend.domain.plogging.controller;

import com.c206.backend.domain.plogging.service.PloggingService;
import com.c206.backend.global.common.dto.Message;
import io.lettuce.core.dynamic.annotation.Param;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/plogging")
public class PloggingController {

    private final PloggingService ploggingService;


    @PostMapping("/start/{memberPetId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<Long>> createPlogging(
            @PathVariable("memberPetId") Long memberPetId,
            @AuthenticationPrincipal Long memberId) {
        Long ploggingId = ploggingService.createPlogging(memberPetId, memberId);
        return ResponseEntity.ok().body(Message.success(ploggingId));
    }


}
