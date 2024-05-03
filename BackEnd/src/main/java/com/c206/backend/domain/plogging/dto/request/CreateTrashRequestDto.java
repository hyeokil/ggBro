package com.c206.backend.domain.plogging.dto.request;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CreateTrashRequestDto {

    private MultipartFile image;

    private Double latitude;

    private Double longitude;

}
