package com.example.website.controllers;

import com.example.website.enums.StatusOfApplication;
import com.example.website.models.ApplicationForRepair;
import com.example.website.models.ApplicationForResettlement;
import com.example.website.services.ApplicationFoResettlementService;
import com.example.website.services.ApplicationForRepairService;
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
public class ApplicationForRepairController {
    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;
    private final ApplicationForRepairService applicationForRepairService;

    @GetMapping("/repair")
    public String repair(Principal principal, Model model){
        model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        return "repair";
    }
    @PostMapping("/repair/create")
    public String createApplicationForRepair(ApplicationForRepair applicationForRepair, Principal principal){

        applicationForRepairService.saveApplicationFoRepair(principal, applicationForRepair);
        return "redirect:/repair/users";
    }
    @GetMapping("/repair/users")
    public String resettlementAll(Principal principal, Model model){
        model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        return "allUsersRepair";
    }

    @PostMapping("repair/users/{id}")
    public String applyRepairUser(@PathVariable Long id){
        //applicationFoResettlementService.deleteResettlement();
        //applicationFoResettlementService.deleteUserInResettlement(i);

        applicationForRepairService.applyRepairUser(id);
        return "redirect:/repair/users";
    }

    @PostMapping("repair/delete/{id}")
    public String deleteRepair(@PathVariable Long id){
        applicationForRepairService.deleteRepair(id);
        return "redirect:/repair/users";
    }
    @PostMapping("/applyRepairWorker/{id}")
    public String applyRepairWorker(@PathVariable Long id){
        //applicationFoResettlementService.deleteResettlement();
        //applicationFoResettlementService.deleteUserInResettlement(i);
        applicationForRepairService.applyRepairWorker(id);
        return "redirect:/";
    }

    @PostMapping("/changeToAccepted/{id}")
    public String changeToAccepted(@PathVariable Long id){
        applicationForRepairService.changeStatusIntoAcceptInWork(id);
        return "redirect:/";
    }
}
