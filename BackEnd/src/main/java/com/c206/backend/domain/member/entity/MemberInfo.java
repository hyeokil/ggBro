package com.c206.backend.domain.member.entity;



import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberInfoId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    private Long profilePetId;

    private int exp;

    private int currency;

    public void updateProfilePetId(Long profilePetId) {
        this.profilePetId = profilePetId;
    }

}
