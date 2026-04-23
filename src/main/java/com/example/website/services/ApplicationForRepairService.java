package com.example.website.services;

import com.example.website.enums.StatusOfRepair;
import com.example.website.models.*;
import com.example.website.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApplicationForRepairService {
    private final UserRepository userRepository;
    private final ApplicationForResettlementRepository applicationFoResettlementRepository;
    private final RoomRepository roomRepository;
    private final AnswerForResettlementRepository answerForResettlementRepository;
    private final ApplicationForRepairRepository applicationForRepairRepository;

    public void saveApplicationFoRepair(Principal principal, ApplicationForRepair applicationForRepair){
        applicationForRepair.setFIO(gerUserByPrincipal(principal).getFIO());
        applicationForRepair.setNumberOfRoomForResettlement(gerUserByPrincipal(principal).getRoom().getNumberOfRoom());
        applicationForRepair.setUserDone(false);
        applicationForRepair.setWorkerDone(false);
        applicationForRepair.setStatus(StatusOfRepair.NEW);
        applicationForRepair.setActive(true);
        applicationForRepair.setUser(gerUserByPrincipal(principal));
        User user = gerUserByPrincipal(principal);
        user.getApplicationForRepair().add(applicationForRepair);
        userRepository.save(user);

    }
    public void changeStatusIntoAcceptInWork(Long idRepair){
        ApplicationForRepair applicationForRepair = applicationForRepairRepository.findById(idRepair).get();
        applicationForRepair.setStatus(StatusOfRepair.ACCEPT_IN_WORK);
        applicationForRepairRepository.save(applicationForRepair);

    }

    public List<ApplicationForRepair> list(){
        return applicationForRepairRepository.findAll();
    }

    public User gerUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public void applyRepairWorker(Long idRepair) {
        ApplicationForRepair applicationForRepair = applicationForRepairRepository.findById(idRepair).get();
        applicationForRepair.setWorkerDone(true);
        applicationForRepairRepository.save(applicationForRepair);
        List<User> users = roomRepository.findByNumberOfRoom(applicationForRepair.getNumberOfRoomForResettlement()).getUsers();
        if(applicationForRepair.isUserDone() && applicationForRepair.isWorkerDone()){
            for(User user : users){
                if(user.getApplicationForRepair().contains(applicationForRepair)){
                    user.getApplicationForRepair().remove(applicationForRepair);
                    userRepository.save(user);
                }
            }
            applicationForRepairRepository.deleteById(idRepair);
        }

    }
    public void applyRepairUser(Long idRepair) {
        ApplicationForRepair applicationForRepair = applicationForRepairRepository.findById(idRepair).get();
        applicationForRepair.setUserDone(true);
        applicationForRepairRepository.save(applicationForRepair);
        List<User> users = roomRepository.findByNumberOfRoom(applicationForRepair.getNumberOfRoomForResettlement()).getUsers();
        if(applicationForRepair.isUserDone() && applicationForRepair.isWorkerDone()){
            for(User user : users){
                if(user.getApplicationForRepair().contains(applicationForRepair)){
                    user.getApplicationForRepair().remove(applicationForRepair);
                    userRepository.save(user);
                }
            }
            applicationForRepairRepository.deleteById(idRepair);
        }

    }

    public void deleteRepair(Long idRepair) {
        ApplicationForRepair applicationForRepair = applicationForRepairRepository.findById(idRepair).get();
        List<User> users = roomRepository.findByNumberOfRoom(applicationForRepair.getNumberOfRoomForResettlement()).getUsers();
            for(User user : users){
                if(user.getApplicationForRepair().contains(applicationForRepair)){
                    user.getApplicationForRepair().remove(applicationForRepair);
                    userRepository.save(user);
                }
            }
            applicationForRepairRepository.deleteById(idRepair);
    }
}
