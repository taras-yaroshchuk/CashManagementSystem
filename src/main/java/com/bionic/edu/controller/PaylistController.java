package com.bionic.edu.controller;

import com.bionic.edu.service.PayListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/paylist")
public class PaylistController {

    @Autowired
    PayListService payListService;

    @RequestMapping(value = "/paylistList", method = RequestMethod.GET)
    public String getAllCustomers(Model model) {
        model.addAttribute("paylistList", payListService.findAll());
        return "showPayLists";
    }
}
