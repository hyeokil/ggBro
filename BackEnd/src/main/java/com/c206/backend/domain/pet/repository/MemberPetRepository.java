package com.c206.backend.domain.pet.repository;

import com.c206.backend.domain.pet.entity.MemberPet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberPetRepository extends JpaRepository<MemberPet, Long> {

    List<MemberPet> findByMemberId(Long memberId);


}
