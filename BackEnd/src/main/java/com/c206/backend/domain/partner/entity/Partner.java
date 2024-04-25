package com.c206.backend.domain.partner.entity;

import com.c206.backend.domain.partner.entity.enums.PartnerType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Partner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long partnerId;

    private String imageUrl;

    private String name;

    @Enumerated(EnumType.STRING)
    private PartnerType partnerType;



}
