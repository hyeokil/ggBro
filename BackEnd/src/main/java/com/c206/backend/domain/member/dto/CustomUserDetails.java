package com.c206.backend.domain.member.dto;

import com.c206.backend.domain.member.entity.Member;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class CustomUserDetails implements UserDetails {

    private final Member member;

    public CustomUserDetails(Member member) {
        this.member = member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collection = new ArrayList<>();

        collection.add(new GrantedAuthority() {

            @Override
            public String getAuthority() {

//                return member.getRole();
                return "true";
            }
        });

        return collection;
    }


    private Long getMemberId(){ return member.getMemberId(); }

    @Override
    public String getUsername() {
        return "UserName hello";
    }
    @Override
    public String getPassword() {
        return member.getPassword();
    }

    public String getEmail() {
        return member.getEmail();
    }

    public String getNickname() { return member.getNickname(); }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
