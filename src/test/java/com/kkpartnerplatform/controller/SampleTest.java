package com.kkpartnerplatform.controller;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class SampleTest {

    @Test
    void getString_shouldReturnExpectedMessage() {
        Sample sample = new Sample();
        String result = sample.getString();

        assertEquals("Hello KK Partner Platform...", result);
    }
}