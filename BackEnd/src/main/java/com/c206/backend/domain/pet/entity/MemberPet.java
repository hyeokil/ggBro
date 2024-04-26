package com.c206.backend.domain.pet.entity;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.global.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberPet extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberPetId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pet_id")
    private Pet pet;

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
