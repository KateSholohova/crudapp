package com.example.website.repository;

import com.example.website.models.ApplicationForResettlement;
import com.example.website.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByApplicationForResettlement(ApplicationForResettlement applicationForResettlement);
}
