package com.c206.backend.domain.partner.entity;

import com.c206.backend.domain.member.entity.Member;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberPartner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberPartnerId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id")
    private Partner partner;

    private int exp;

    private String nickname;

    private boolean active;

    public void updateNickname(String nickname) {
        this.nickname = nickname;
    }

    public void updateExp(int exp) {
        this.exp = exp;
    }

    public void updateActive() {
        this.active = true;
    }

}
