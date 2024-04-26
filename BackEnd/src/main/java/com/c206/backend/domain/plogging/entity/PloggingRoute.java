package com.c206.backend.domain.plogging.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class PloggingRoute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ploggingRouteId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "plogging_id")
    private Plogging plogging;

    private Double latitude;

    private Double longitude;
}
