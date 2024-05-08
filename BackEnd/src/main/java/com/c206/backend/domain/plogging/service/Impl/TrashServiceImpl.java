package com.c206.backend.domain.plogging.service.Impl;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.c206.backend.domain.achievement.repository.MemberAchievementRepository;
import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.entity.MemberInfo;
import com.c206.backend.domain.member.exception.MemberError;
import com.c206.backend.domain.member.exception.MemberException;
import com.c206.backend.domain.member.repository.MemberInfoRepository;
import com.c206.backend.domain.member.repository.MemberRepository;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.domain.pet.entity.Pet;
import com.c206.backend.domain.pet.entity.enums.PetType;
import com.c206.backend.domain.pet.repository.MemberPetRepository;
import com.c206.backend.domain.pet.repository.PetRepository;
import com.c206.backend.domain.pet.service.MemberPetServiceImpl;
import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.request.GetTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;
import com.c206.backend.domain.plogging.dto.response.GetTrashResponseDto;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.entity.Trash;
import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.c206.backend.domain.plogging.exception.PloggingError;
import com.c206.backend.domain.plogging.exception.PloggingException;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.repository.TrashRepository;
import com.c206.backend.domain.plogging.service.TrashService;
import com.c206.backend.domain.quest.entity.MemberQuest;
import com.c206.backend.domain.quest.repository.MemberQuestRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TrashServiceImpl implements TrashService {

    private final PloggingRepository ploggingRepository;
    private final MemberInfoRepository memberInfoRepository;
    private final MemberAchievementRepository memberAchievementRepository;
    private final MemberQuestRepository memberQuestRepository;
    private final MemberPetRepository memberPetRepository;
    private final PetRepository petRepository;
    private final MemberRepository memberRepository;
    private final MemberPetServiceImpl memberPetServiceImpl;
    private final TrashRepository trashRepository;

    @Value("${aws.s3.bucket}")
    private String bucket;

    private final AmazonS3 amazonS3;

    private void  updateMemberAchievement(Long memberId, Long achievementId) {
        memberAchievementRepository.findByMemberIdAndAchievementId(memberId,achievementId).updateProgress();
    }

    private void  updateMemberQuest(Long memberId, Long questId) {
        MemberQuest memberQuest=memberQuestRepository.findTopByMemberIdAndQuestIdOrderByIdDesc(memberId,questId);
        if (memberQuest!=null) {
            memberQuest.updateProgress();
        }
    }

    private String generateFileName(Long ploggingId) {
        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd_HHmmssSSS");
        String formattedDateTime = currentTime.format(formatter);
        return "trash_" + ploggingId + "_" + formattedDateTime + ".jpg";
    }

    private String uploadImageAndGetUrl(String fileName, byte[] imageData) {
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(imageData.length);
        // S3에 이미지 업로드
        amazonS3.putObject(bucket, fileName, new ByteArrayInputStream(imageData), metadata);
        URL imageUrl = amazonS3.getUrl(bucket, fileName);
        return imageUrl.toString();
    }

    @Override
    public CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto) {
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(()
                -> new PloggingException(PloggingError.NOT_FOUND_PLOGGING));
        // 바이트로 들어온 데이터를 다시 이미지로 변화 해야한다
//        BufferedImage image;
//        try {
//            ByteArrayInputStream bis = new ByteArrayInputStream(createTrashRequestDto.getImage());
//            image = ImageIO.read(bis);
//        } catch (IOException e) {
//            throw new PloggingException(PloggingError.IMAGE_CONVERSION_ERROR);
//        };
        // 파일 이름 생성
        String fileName = generateFileName(ploggingId);
        byte[] imageData = createTrashRequestDto.getImage();
        // 이미지 메타데이터 설정
        String imageUrl = uploadImageAndGetUrl(fileName, imageData);
        // 플라스크로 url 보내서 종류 받아오기
        // 일단 보류 일단 랜덤
        TrashType[] trashTypes = {TrashType.NORMAL, TrashType.PLASTIC, TrashType.CAN, TrashType.GLASS};
        Random random = new Random();
        int randomIndex = random.nextInt(trashTypes.length);
        TrashType trashType = trashTypes[randomIndex];
        // 쓰레기 저장
        // Coordinate 객체를 사용하여 Point 생성
        GeometryFactory geometryFactory = new GeometryFactory();
        Coordinate coord = new Coordinate(createTrashRequestDto.getLongitude(), createTrashRequestDto.getLatitude());
        Point point = geometryFactory.createPoint(coord);
        Trash trash = Trash.builder()
                .plogging(plogging)
                .trashType(trashType)
                .location(point)
                .image(imageUrl)
                .build();
        trashRepository.save(trash);
        // 보상 정의 하기
        // 사람에게 경험치가 들어가야한다 조건과 상관없이 exp(일반 55,플라스틱 66,캔 111, 유리 199)
        // 펫 isActive = 재화(일반 100,플라스틱 110,캔 160, 유리 270)
        // notActive = pet exp(일반 50,플라스틱 60,캔 100, 유리 200)
        // 펫이 처치한 몬스터수 증가시키기
        boolean petActive = plogging.getMemberPet().isActive();
        MemberPet memberPet = plogging.getMemberPet();
        Long memberId = plogging.getMember().getId();
        int exp = 0, value = 0;
        switch (trashType) {
            case NORMAL -> {
                exp = 55 ;
                value=petActive ? 100 : 50;memberPet.addNormal();
                updateMemberAchievement(memberId, 4L);
                updateMemberQuest(memberId,3L);}
            case PLASTIC -> {
                exp = 66;
                value=petActive ? 110 : 60;memberPet.addPlastic();
                updateMemberAchievement(memberId, 5L);
                updateMemberQuest(memberId,2L);}
            case CAN -> {
                exp = 111;
                value=petActive ? 160 : 100;memberPet.addCan();
                updateMemberAchievement(memberId, 6L);
                updateMemberQuest(memberId,5L);}
            case GLASS -> {
                exp = 199;
                value =petActive ? 270 : 200;memberPet.addGlass();
                updateMemberAchievement(memberId, 7L);
                updateMemberQuest(memberId,4L);}
        };

        int currency = petActive ? 0 : value;
        // notActive 일때 펫 경험치 주기
        if (!petActive) {
            plogging.getMemberPet().addExp(value);
        }
        // 새로운 회원정보 저장
        MemberInfo memberInfo = memberInfoRepository.findTopByMemberIdOrderByIdDesc(memberId);
        MemberInfo newMemberInfo = MemberInfo.builder()
                .member(plogging.getMember())
                .profilePetId(memberInfo.getProfilePetId())
                .exp(memberInfo.getExp()+exp)
                .currency(memberInfo.getCurrency() + currency)
                .build();
        memberInfoRepository.save(newMemberInfo);
        // pet 획득 여부 획득 확률 5%
        boolean result = Math.random() < 0.05;
        Member member = memberRepository.findById(memberId).orElseThrow(()
                -> new MemberException(MemberError.NOT_FOUND_MEMBER));
        if (result) {
            List<MemberPet> memberPets = memberPetRepository.findByMemberId(memberId);
            List<Pet> pets = petRepository.findByPetTypeIs(PetType.NORMAL);
            memberPetServiceImpl.createMemberPet(memberPets, pets, member);
        }

        return new CreateTrashResponseDto(
            trashType,
            value,
            petActive,
            result
            );
    }


    @Override
    public GetTrashResponseDto getTrashList(GetTrashRequestDto getTrashRequestDto) {
        List<Object[]> results = trashRepository.countTrashByTypeWithinDistance(
                getTrashRequestDto.getLatitude(),
                getTrashRequestDto.getLongitude(),
                getTrashRequestDto.getRadius());
        int normal=0,plastic = 0,can=0,glass=0;
        for (Object[] result : results) {
            int count = ((Number) result[1]).intValue();
            switch ((String) result[0]) {
                case "NORMAL" -> normal = count;
                case "PLASTIC" -> plastic = count;
                case "CAN" -> can = count;
                case "GLASS" -> glass = count;
            }
        }
        return new GetTrashResponseDto(
                normal,
                plastic,
                can,
                glass);
    }
}
