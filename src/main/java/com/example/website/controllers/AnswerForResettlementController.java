package com.example.website.controllers;

import com.example.website.models.AnswerForResettlement;
import com.example.website.services.AnswerFoResettlementService;
import com.example.website.services.ApplicationFoResettlementService;
import com.example.website.services.RoomService;
import com.example.website.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class AnswerForResettlementController {

    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;
    private final AnswerFoResettlementService answerFoResettlementService;

    @PostMapping("/answer/create")
        public String createAnswerForResettlement(AnswerForResettlement answerForResettlement, Principal principal){
            //answerForResettlement.getUsers().add(roomService.gerUserByPrincipal(principal));
            //applicationFoResettlement.setUser(roomService.gerUserByPrincipal(principal));
            //roomService.gerUserByPrincipal(principal).setAnswerForResettlement(answerForResettlement);
            answerFoResettlementService.saveAnswerFoResettlement(principal, answerForResettlement);

            return "redirect:/";
    }

}


