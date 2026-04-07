package com.kkpartnerplatform.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Sample {

    @GetMapping("/getString")
    public String getString() {
        return "Hello KK Partner Platform...";
    }
}


