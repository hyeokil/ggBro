package com.c206.backend.domain.history.dto;

import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import org.locationtech.jts.geom.Point;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class TrashDTO {
    private Point Location;

    private TrashType type;

    private String image;
}
