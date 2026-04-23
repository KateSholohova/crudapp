package com.example.website.models;

import com.example.website.enums.Role;
import com.example.website.enums.Sex;
import com.example.website.enums.Specialization;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;

@Entity
@Table(name = "users")
@Data
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "email", unique = true)
    private String email;
    @Column(name = "active")
    private boolean active;
    @Column(name = "FIO")
    private String FIO;
    @Column(name = "sex")
    private Sex sex;
    @Column(name = "description")
    private String description;
    @Column(name = "isAnswer")
    private boolean isAnswer;
    @Column(name = "specialization")
    private Specialization specialization;
//    @OneToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "ressetlement_id", referencedColumnName = "id")
//    private ApplicationForResettlement applicationForResettlement;
//@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
//@JoinColumn
//private ApplicationForResettlement applicationForResettlement;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "user")
    private List<ApplicationForRepair> applicationForRepair = new ArrayList<>();
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn
    private ApplicationForResettlement applicationForResettlement;
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn
    private AnswerForResettlement answerForResettlement;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private Room room;
    @Column(name = "password")
    private String password;
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }

    public boolean isUserr() {
        return roles.contains(Role.ROLE_USER);
    }

    public boolean isWorker() {
        return roles.contains(Role.ROLE_WORKER);
    }

    @Override
    public String getUsername() {
        return email;
    }

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
        return active;
    }

}
