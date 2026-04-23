package com.example.website.models;

import com.example.website.enums.Sex;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.domain.EntityScan;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "rooms")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    Long id;
    @Column(name = "numberOfRoom")
    String numberOfRoom;
    @Column(name = "conditions")
    String conditions;
    @Column(name = "price")
    Integer price;
    @Column(name = "numberOfAvailableSeats")
    Integer numberOfAvailableSeats = 5;
    @Column(name = "type")
    Sex type;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "room")
    private List<User> users = new ArrayList<>();


}
