package com.c206.backend.domain.member.repository;


import com.c206.backend.domain.member.entity.MemberInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberInfoRepository extends JpaRepository<MemberInfo, Long> {

    MemberInfo findTopByMemberIdOrderByIdDesc(Long memberId);

}
