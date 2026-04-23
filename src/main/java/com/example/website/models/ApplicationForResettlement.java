package com.example.website.models;

import com.example.website.enums.StatusOfApplication;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "resettlement")
@Data
public class ApplicationForResettlement {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    Long id;
    @Column(name = "reason")
    String reason;
    @Column(name = "numberOfRoomForResettlement")
    String numberOfRoomForResettlement;
    @Column(name = "isApply")
    boolean isApply;
    @Column(name = "Status")
    StatusOfApplication Status;
    @OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, mappedBy = "applicationForResettlement")
    private List<User> users = new ArrayList<>();
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "applicationForResettlementWithAnswer")
    private List<AnswerForResettlement> answers = new ArrayList<>();

//    @OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
//    @JoinColumn(name = "user_id")
//    private User user;
//@OneToOne(cascade = CascadeType.REFRESH, mappedBy = "applicationForResettlement")
//private User user;

}
