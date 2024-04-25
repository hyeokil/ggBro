package com.c206.backend.domain.member.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Member  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberId;

    private String email;

    private String password;

    private String nickname;

    private int exp;

    private int currency;

    public void updateNickname(String nickname) {
        this.nickname = nickname;
    }

    public void updateExp(int exp) {
        this.exp = exp;
    }

    public void updateCurrency(int currency) {
        this.currency = currency;
    }








}