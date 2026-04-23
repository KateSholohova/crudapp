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
public class AnswerFoResettlementService {

    private final UserRepository userRepository;
    private final ApplicationForResettlementRepository applicationFoResettlementRepository;
    private final RoomRepository roomRepository;
    private final AnswerForResettlementRepository answerForResettlementRepository;

    public void saveAnswerFoResettlement(Principal principal, AnswerForResettlement answer){

        //applicationFoResettlement.setUser(gerUserByPrincipal(principal));
        //log.info("Saving new {}", applicationFoResettlement);
        boolean isAgree = answer.isIfAgree();
        String reason = answer.getReason();
        gerUserByPrincipal(principal).getAnswerForResettlement().setReason(reason);
        gerUserByPrincipal(principal).getAnswerForResettlement().setIfAgree(isAgree);
        gerUserByPrincipal(principal).getAnswerForResettlement().setAnswered(true);
        AnswerForResettlement answerForResettlement = gerUserByPrincipal(principal).getAnswerForResettlement();
        answerForResettlementRepository.save(answerForResettlement);

    }

    public User gerUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());

    }

    public void createAnswerFoResettlement(Principal principal, AnswerForResettlement answer){

        //applicationFoResettlement.setUser(gerUserByPrincipal(principal));
        //log.info("Saving new {}", applicationFoResettlement);
        answerForResettlementRepository.save(answer);
    }

}
