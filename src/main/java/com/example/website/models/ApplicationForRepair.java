package com.example.website.models;

import com.example.website.enums.Role;
import com.example.website.enums.Specialization;
import com.example.website.enums.StatusOfApplication;
import com.example.website.enums.StatusOfRepair;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "applicationForRepair")
@Data
public class ApplicationForRepair {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    Long id;
    @Column(name = "description")
    String description;
    @Column(name = "numberOfRoomForResettlement")
    String numberOfRoomForResettlement;
    @Column(name = "FIO")
    String FIO;
    @Column(name = "active")
    boolean active;
    @Column(name = "specialization")
    private Specialization specialization;
    @Column(name = "status")
    private StatusOfRepair status;
    @Column(name = "WorkerDone")
    boolean WorkerDone;
    @Column(name = "UserDone")
    boolean UserDone;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;

    public boolean isWorkerDone() {
        return WorkerDone;
    }

    public boolean isUserDone() {
        return UserDone;
    }

}
