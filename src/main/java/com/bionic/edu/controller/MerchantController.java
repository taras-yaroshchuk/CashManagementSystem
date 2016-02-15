package com.bionic.edu.controller;

import com.bionic.edu.service.MerchantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/merchant")
public class MerchantController {

    @Autowired
    MerchantService merchantService;

    @RequestMapping(value = "/merchantsList", method = RequestMethod.GET)
    public String getAllCustomers(Model model) {
        model.addAttribute("merchantsList", merchantService.findAll());
        return "merchantsList";
    }

}
