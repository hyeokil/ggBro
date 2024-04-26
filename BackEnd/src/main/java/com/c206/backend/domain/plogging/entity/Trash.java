package com.c206.backend.domain.plogging.entity;


import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.c206.backend.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Trash extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long trashId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "plogging_id")
    private Plogging plogging;

    @Enumerated(EnumType.STRING)
    private TrashType trashType;

    private Double latitude;

    private Double longitude;

    private String image;
}
