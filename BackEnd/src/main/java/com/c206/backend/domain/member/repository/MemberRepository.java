package com.c206.backend.domain.member.repository;

import com.c206.backend.domain.member.dto.MemberDto;
import com.c206.backend.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Boolean existsByEmail(String email);
    Member findByEmail(String email);
}
