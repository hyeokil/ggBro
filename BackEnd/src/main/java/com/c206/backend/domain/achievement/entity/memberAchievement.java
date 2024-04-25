package com.c206.backend.domain.achievement.entity;

import com.c206.backend.domain.member.entity.Member;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class memberAchievement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberAchievementId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "achievement_id")
    private Achievement achievement;

    private int progress;

    private int goalMultiply;

    public void updateProgress(int progress) {
        this.progress = progress;
    }

}

