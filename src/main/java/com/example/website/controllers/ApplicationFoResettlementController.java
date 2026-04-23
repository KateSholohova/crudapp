package com.example.website.controllers;

import com.example.website.enums.StatusOfApplication;
import com.example.website.models.ApplicationForResettlement;
import com.example.website.services.ApplicationFoResettlementService;
import com.example.website.services.RoomService;
import com.example.website.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ApplicationFoResettlementController {

    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;

    @GetMapping("/resettlement")
    public String resettlement(Principal principal, Model model){
        model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        return "resettlement";
    }
    @PostMapping("/resettlement/create")
    public String createApplicationForResettlement(ApplicationForResettlement applicationFoResettlement, Principal principal){
        applicationFoResettlement.getUsers().add(roomService.gerUserByPrincipal(principal));
        //applicationFoResettlement.setUser(roomService.gerUserByPrincipal(principal));
        applicationFoResettlement.setStatus(StatusOfApplication.IN_PROGRESS);
        roomService.gerUserByPrincipal(principal).setApplicationForResettlement(applicationFoResettlement);
        applicationFoResettlementService.saveApplicationFoResettlement(principal, applicationFoResettlement);
        roomService.createAnswerForResettlement(applicationFoResettlement.getNumberOfRoomForResettlement(), applicationFoResettlement, principal);
//        return "resettlement";
        return "redirect:/";
    }










}
