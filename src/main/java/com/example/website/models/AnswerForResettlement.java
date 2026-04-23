package com.example.website.models;

import com.example.website.enums.StatusOfApplication;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "answerForResettlement")
@Data
public class AnswerForResettlement {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    Long id;
    @Column(name = "reason")
    String reason;
    @Column(name = "whoWant")
    String whoWant;
    @Column(name = "description")
    String description;
    @Column(name = "ifAgree")
    boolean ifAgree;
    @Column(name = "isAnswered")
    boolean isAnswered;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private ApplicationForResettlement applicationForResettlementWithAnswer;
    @OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER, mappedBy = "answerForResettlement")
    private List<User> users = new ArrayList<>();
}
