package com.c206.backend.domain.history.dto.response;


import com.c206.backend.domain.history.dto.RouteDTO;
import com.c206.backend.domain.history.dto.TrashDTO;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class HistoryDetailResponseDTO {

    private Long ploggingId;

    private List<TrashDTO> trashList;

    private List<RouteDTO> routeList;

}
