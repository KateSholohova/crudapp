package com.example.website.repository;

import com.example.website.models.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.*;

public interface RoomRepository extends JpaRepository<Room, Long> {
    List<Room> findByPrice(Integer price);
    Room findByNumberOfRoom(String numberOfRoom);
    void deleteByNumberOfRoom(String numberOfRoom);


}
