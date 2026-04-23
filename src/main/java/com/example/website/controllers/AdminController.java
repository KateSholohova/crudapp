package com.example.website.controllers;


import com.example.website.services.ApplicationFoResettlementService;
import com.example.website.services.RoomService;
import com.example.website.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {

    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;

    @GetMapping("/admin")
    public String admin(Model model, Principal principal) {
        model.addAttribute("users", userService.list());
       // model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "admin";
    }

    @PostMapping("/admin/{id}")
    public String deleteUser(@PathVariable Long id){
        //applicationFoResettlementService.deleteResettlement();
        //applicationFoResettlementService.deleteUserInResettlement(i);
        userService.deleteUser(id);
        return "redirect:/admin";
    }

    @GetMapping("/allResettlement")
    public String allResettlement(Model model, Principal principal) {
        //model.addAttribute("applications", applicationFoResettlementService.list());
        model.addAttribute("users", userService.list());
        // model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "allResettlement";
    }

    @PostMapping("/allResettlement/{id}/{idApp}")
    public String deleteUserInResettlement(@PathVariable Long id, @PathVariable Long idApp){
        applicationFoResettlementService.deleteUserInResettlement(id, idApp);
        return "redirect:/allResettlement";
    }

    @PostMapping("/allResettlement/accept/{id}/{idApp}")
    public String acceptUserInResettlement(@PathVariable Long id, @PathVariable Long idApp){
        applicationFoResettlementService.acceptUserInResettlement(id, idApp);
        return "redirect:/allResettlement";
    }




//    @PostMapping("/allResettlement/resettlement/accept/{id}")
//    public String acceptResettlement(@PathVariable Long id){
//        userService.deleteUser(id);
//        return "redirect:/admin";
//    }
}
