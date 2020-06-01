package com.sprint.controller;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class MainControllerTests {

    private MainController mainController;

    @Before
    public void setup() {
        mainController = new MainController();
    }

    @Test
    public void testIndex() {
        String result = mainController.index();
        assertEquals(result, "index");
    }

    @Test
    public void testLogin() {
        String result = mainController.login();
        assertEquals(result, "login");
    }

}
