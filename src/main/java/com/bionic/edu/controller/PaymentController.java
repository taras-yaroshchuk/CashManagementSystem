package com.bionic.edu.controller;

import com.bionic.edu.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    PaymentService paymentService;

    @RequestMapping(value = "/paymentsList", method = RequestMethod.GET)
    public String getAllCustomers(Model model) {
        model.addAttribute("paymentsList", paymentService.findAll());
        return "paymentsList";
    }
}
