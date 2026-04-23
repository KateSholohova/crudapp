package com.example.website.services;

import com.example.website.enums.Role;
import com.example.website.enums.Specialization;
import com.example.website.models.AnswerForResettlement;
import com.example.website.models.ApplicationForResettlement;
import com.example.website.models.Room;
import com.example.website.models.User;
import com.example.website.repository.AnswerForResettlementRepository;
import com.example.website.repository.ApplicationForResettlementRepository;
import com.example.website.repository.RoomRepository;
import com.example.website.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RoomRepository roomRepository;
    private final ApplicationForResettlementRepository applicationFoResettlementRepository;
    private final AnswerForResettlementRepository answerForResettlementRepository;

    public boolean createUser(User user) {
        String email = user.getEmail();
        if(userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setAnswer(false);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        //user.setSpecialization(Specialization.Electrician);
        //log.info("Saving new user with email: {}", email);
        userRepository.save(user);
        User userAfterSave = userRepository.findByEmail(email);
        Room room = roomRepository.findById(userAfterSave.getRoom().getId()).get();
        room.setNumberOfAvailableSeats(room.getNumberOfAvailableSeats()-1);
        roomRepository.save(room);
        return true;
    }

    public List<User> list(){
        return userRepository.findAll();
    }

    public void deleteUser(Long id){
        //Long copyId = userRepository.findById(id).get().getApplicationForResettlement().getId();
        User user = userRepository.findById(id).get();
        if(user.getApplicationForResettlement() != null){
            System.out.println("hugrijoefpk");
            ApplicationForResettlement applicationForResettlement = applicationFoResettlementRepository.findById(user.getApplicationForResettlement().getId()).get();
            List<User> usersInResettle = applicationForResettlement.getUsers();
            List<AnswerForResettlement> answers = applicationForResettlement.getAnswers();
            Room room = roomRepository.findByNumberOfRoom(applicationForResettlement.getNumberOfRoomForResettlement());
            List<User> usersInRoom = room.getUsers();
            User userToDel = new User();
            for (User userWithResettlement : usersInResettle) {
                if (Objects.equals(userWithResettlement.getId(), id)) {
                    userToDel = userWithResettlement;
                }
            }
            usersInResettle.remove(userToDel);
            applicationForResettlement.setUsers(usersInResettle);
            applicationForResettlement.setAnswers(null);
            user.setApplicationForResettlement(null);
            //userRepository.deleteById(userRepository.findByApplicationForResettlement(applicationFoResettlementRepository.findById(user.getAnswerForResettlement().getId()).get()).getId());
            userRepository.save(user);
            for(User user1: usersInRoom){
                user1.setAnswerForResettlement(null);
                userRepository.save(user1);
            }
            for(AnswerForResettlement answer : answers){
                answer.setApplicationForResettlementWithAnswer(null);
                answerForResettlementRepository.save(answer);
            }
            applicationFoResettlementRepository.save(applicationForResettlement);
        }
        userRepository.deleteById(id);
        Room room = roomRepository.findById(user.getRoom().getId()).get();
        room.setNumberOfAvailableSeats(room.getNumberOfAvailableSeats()+1);
        roomRepository.save(room);
        //applicationFoResettlementRepository.deleteById(copyId);


    }
}

