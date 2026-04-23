package com.example.website.enums;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_USER, ROLE_ADMIN, ROLE_WORKER;

    @Override
    public String getAuthority() {
        return name();
    }
}
