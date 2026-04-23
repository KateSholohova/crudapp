
package com.example.website.controllers;

import com.example.website.models.ApplicationForResettlement;
import com.example.website.models.Room;
import com.example.website.repository.RoomRepository;
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
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class RoomController {
    private final ApplicationFoResettlementService applicationFoResettlementService;
    private final RoomService roomService;
    private final UserService userService;
    private final ApplicationForRepairService applicationForRepairService;
    private final RoomRepository roomRepository;


    @GetMapping("/")
    public String rooms(Principal principal, Model model){
        //model.addAttribute("rooms", roomService.getRooms());
        model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        model.addAttribute("repairs", applicationForRepairService.list());
        return "rooms";
    }

    @GetMapping("/allRooms")
    public String allRooms(Principal principal, Model model){
        model.addAttribute("rooms", roomService.getRooms());
        //model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        return "allRooms";
    }

    @GetMapping("/freeRooms")
    public String freeRooms(Principal principal, Model model){
        model.addAttribute("rooms", roomService.getRooms());
        model.addAttribute("user", roomService.gerUserByPrincipal(principal));

        //model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        //model.addAttribute("users", roomService.getRoomById(id).getUsers());
        return "freeRooms";
    }



//    @PostMapping("room/{numberOfRoom}")
//    public String roomInfo(@PathVariable String numberOfRoom, Model model){
//        model.addAttribute("room", roomService.getRoomByNumber(numberOfRoom));
//        return "room-info";
//    }

    @GetMapping("room/{id}")
    public String roomInfo(@PathVariable Long id, Model model){
        model.addAttribute("room", roomService.getRoomById(id));
        model.addAttribute("users", roomService.getRoomById(id).getUsers());
        return "room-info";
    }

    @PostMapping("/room/create")
    public String createRoom(Room room, Principal principal){
        if(roomRepository.findByNumberOfRoom(room.getNumberOfRoom()) == null){
            roomService.saveRoom(principal, room);
        }
            return "redirect:/createRoom";
    }

    @GetMapping("/createRoom")
    public String create(Principal principal, Model model){
        //model.addAttribute("user", roomService.gerUserByPrincipal(principal));

        return "createRoom";
    }



//    @PostMapping("/room/delete/{numberOfRoom}")
//    public String deleteRoom(@PathVariable String numberOfRoom){
//        roomService.deleteRoom(numberOfRoom);
//        return "redirect:/";
//    }

    @PostMapping("/room/delete/{id}")
    public String deleteRoom(@PathVariable Long id){
        roomService.deleteRoom(id);
        return "redirect:/";
    }

    @GetMapping("/freeRooms/{id}")
    public String freRoomsStudents(@PathVariable Long id, Model model){
        model.addAttribute("room", roomService.getRoomById(id));
        model.addAttribute("users", roomService.getRoomById(id).getUsers());
        //model.addAttribute("users", roomService.gerUsersByPrincipal(principal));

        //model.addAttribute("user", roomService.gerUserByPrincipal(principal));
        //model.addAttribute("users", roomService.getRoomById(id).getUsers());
        return "freeRoomsStudents";
    }

//    @PostMapping("/rooms/deleteResettlement/{id}")
//    public String deleteResettlement(@PathVariable Long id){
//        applicationFoResettlementService.deleteResettlement(id);
//        return "redirect:/rooms";
//    }

}
