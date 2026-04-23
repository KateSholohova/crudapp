package com.example.website.services;

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
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApplicationFoResettlementService {
    private final UserRepository userRepository;
    private final ApplicationForResettlementRepository applicationFoResettlementRepository;
    private final RoomRepository roomRepository;
    private final AnswerForResettlementRepository answerForResettlementRepository;


    public void saveApplicationFoResettlement(Principal principal, ApplicationForResettlement applicationFoResettlement){

        //applicationFoResettlement.setUser(gerUserByPrincipal(principal));
        //log.info("Saving new {}", applicationFoResettlement);
        applicationFoResettlementRepository.save(applicationFoResettlement);

    }

    public User gerUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());

    }

    public void deleteResettlement(Long id){
        applicationFoResettlementRepository.deleteById(id);
    }

    public List<ApplicationForResettlement> list(){
        return applicationFoResettlementRepository.findAll();
    }

    public void deleteUserInResettlement(Long idUser, Long idApplication){
        ApplicationForResettlement applicationForResettlement = applicationFoResettlementRepository.findById(idApplication).get();
        List<User> usersInResettle = applicationForResettlement.getUsers();
        List<AnswerForResettlement> answers = applicationForResettlement.getAnswers();
        Room room = roomRepository.findByNumberOfRoom(applicationForResettlement.getNumberOfRoomForResettlement());
        List<User> usersInRoom = room.getUsers();
        User userToDel = new User();
        for (User user : usersInResettle) {
            if (Objects.equals(user.getId(), idUser)) {
                userToDel = user;
            }
        }
        usersInResettle.remove(userToDel);
        applicationForResettlement.setUsers(usersInResettle);
        applicationForResettlement.setAnswers(null);
        User user = userRepository.findById(idUser).get();
        user.setApplicationForResettlement(null);
        userRepository.deleteById(userRepository.findByApplicationForResettlement(applicationFoResettlementRepository.findById(idApplication).get()).getId());
        userRepository.save(user);
        for(User user1: usersInRoom){
            user1.setAnswerForResettlement(null);
            userRepository.save(user1);
        }
        for(AnswerForResettlement answer : answers){
            answer.setApplicationForResettlementWithAnswer(null);
            answerForResettlementRepository.deleteById(answer.getId());
        }
        applicationFoResettlementRepository.save(applicationForResettlement);

    }

    public void acceptUserInResettlement(Long idUser, Long idApplication) {
        ApplicationForResettlement applicationForResettlement = applicationFoResettlementRepository.findById(idApplication).get();
        List<User> usersInResettle = applicationForResettlement.getUsers();
        List<AnswerForResettlement> answers = applicationForResettlement.getAnswers();
        Room room1 = roomRepository.findByNumberOfRoom(applicationForResettlement.getNumberOfRoomForResettlement());
        List<User> usersInRoom = room1.getUsers();
        User userToDel = new User();
        for (User user : usersInResettle) {
            if (Objects.equals(user.getId(), idUser)) {
                userToDel = user;
            }

        }
        usersInResettle.remove(userToDel);
        applicationForResettlement.setUsers(usersInResettle);
        applicationForResettlement.setAnswers(null);
        User user = userRepository.findById(idUser).get();
        user.setApplicationForResettlement(null);
        Room roomBeforeResettle = roomRepository.findById(user.getRoom().getId()).get();
        roomBeforeResettle.setNumberOfAvailableSeats(roomBeforeResettle.getNumberOfAvailableSeats()+1);
        Room room = roomRepository.findByNumberOfRoom(applicationForResettlement.getNumberOfRoomForResettlement());
        room.setNumberOfAvailableSeats(room.getNumberOfAvailableSeats()-1);
        user.setRoom(room);
        //userRepository.deleteById(userRepository.findByApplicationForResettlement(applicationFoResettlementRepository.findById(idApplication).get()).getId());
        userRepository.save(user);
        for(User user1: usersInRoom){
            user1.setAnswerForResettlement(null);
            userRepository.save(user1);
        }
        for(AnswerForResettlement answer : answers){
            answer.setApplicationForResettlementWithAnswer(null);
            answerForResettlementRepository.deleteById(answer.getId());
        }
        roomRepository.save(room);
        roomRepository.save(roomBeforeResettle);

        applicationFoResettlementRepository.save(applicationForResettlement);

    }

//    public void rejectResettlement(Long id){
//        //applicationFoResettlementRepository.findById(id).
//        applicationFoResettlementRepository.deleteById(id);
//    }



}
