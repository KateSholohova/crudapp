
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
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomService {
    private final RoomRepository roomRepository;
    private final UserRepository userRepository;
    private final ApplicationForResettlementRepository applicationForResettlementRepository;
    private final AnswerForResettlementRepository answerForResettlementRepository;

    public List<Room> getRooms() {
        //if(price != null) return roomRepository.findByPrice(price);
        return roomRepository.findAll();
    }

    public void saveRoom(Principal principal, Room room){
        room.setUsers(gerUsersByPrincipal(principal));
        //log.info("Saving new {}", room);
        roomRepository.save(room);
    }

    public List<User> gerUsersByPrincipal(Principal principal) {
        List<User> users = new ArrayList<>();
        if (principal == null) return users;
        users.add(userRepository.findByEmail(principal.getName()));
        return users;
    }

    public User gerUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());

    }

    public void createAnswerForResettlement(String numberOfRoom, ApplicationForResettlement applicationFoResettlement, Principal principal) {
        Room room = roomRepository.findByNumberOfRoom(numberOfRoom);
        AnswerForResettlement answerForResettlement = new AnswerForResettlement();
        answerForResettlement.setWhoWant(gerUserByPrincipal(principal).getFIO());
        answerForResettlement.setAnswered(false);
        answerForResettlement.setDescription(gerUserByPrincipal(principal).getDescription());
        //applicationFoResettlement.getAnswers().add(answerForResettlement);
        //answerForResettlement.setApplicationForResettlementWithAnswer(applicationFoResettlement);
        //answerForResettlementRepository.save(answerForResettlement);
        List<User> users = room.getUsers();
        for (User user : users) {
            user.setAnswer(true);
            applicationFoResettlement.getAnswers().add(duplicateAnswerForResettlement(answerForResettlement));
            AnswerForResettlement answerWithApp = duplicateAnswerForResettlement(answerForResettlement);
            answerWithApp.setApplicationForResettlementWithAnswer(applicationFoResettlement);
            answerForResettlementRepository.save(answerWithApp);
            user.setAnswerForResettlement(answerWithApp);
        }
        room.setUsers(users);
        roomRepository.save(room);


    }



//    public void deleteRoom(String number){
//        roomRepository.deleteByNumberOfRoom(number);
//    }

    public void deleteRoom(Long id){
        roomRepository.deleteById(id);
    }

    public AnswerForResettlement duplicateAnswerForResettlement(AnswerForResettlement answerForResettlement){
        AnswerForResettlement answerForResettlement2 = new AnswerForResettlement();
        answerForResettlement2.setWhoWant(answerForResettlement.getWhoWant());
        answerForResettlement2.setAnswered(false);
        answerForResettlement2.setDescription(answerForResettlement.getDescription());
        return answerForResettlement2;
    }

//    public Room getRoomByNumber(String number){
//        if(roomRepository.findByNumberOfRoom(number) != null) return roomRepository.findByNumberOfRoom(number);
//        else return null;
//    }


    public Room getRoomById(Long id){
        return roomRepository.findById(id).orElse(null);
    }
}

