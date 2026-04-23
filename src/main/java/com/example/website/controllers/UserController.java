package com.example.website.controllers;

import com.example.website.models.ApplicationForResettlement;
import com.example.website.models.User;
import com.example.website.services.ApplicationFoResettlementService;
import com.example.website.services.RoomService;
import com.example.website.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;



    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(User user) {
        userService.createUser(user);
        //roomService.changeNumberOfSeatsMore(user.getRoom().getId());
        return "redirect:/login";
    }

    @PostMapping("/onMainScreen")
    public String onMainScreen(User user) {
        //userService.createUser(user);
        //roomService.changeNumberOfSeatsMore(user.getRoom().getId());
        return "redirect:/";
    }
    @PostMapping("/dorm")
    public String dorm(User user) {
        //userService.createUser(user);
        //roomService.changeNumberOfSeatsMore(user.getRoom().getId());
        return "redirect:/dorm";
    }

    @GetMapping("/dorm")
    public String dorm() {
        //userService.createUser(user);
        //roomService.changeNumberOfSeatsMore(user.getRoom().getId());
        return "dorm";
    }







}

