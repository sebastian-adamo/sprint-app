package com.sprint.controller;

import com.sprint.domain.User;
import com.sprint.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

public class MainControllerTests {

    private MockMvc mockMvc;

    @InjectMocks
    private MainController mainController;

    @Mock
    private UserRepository userRepository;

    @BeforeEach
    private void setup() {
        MockitoAnnotations.initMocks(this);

        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        viewResolver.setOrder(2);

        mockMvc = MockMvcBuilders.standaloneSetup(mainController)
                .setViewResolvers(viewResolver)
                .build();
    }

    @Test
    public void test_index() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("index"));
    }

    @Test
    public void test_login() throws Exception {
        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"));
    }

    @Test
    public void test_register() throws Exception {
        mockMvc.perform(get("/register"))
                .andExpect(status().isOk())
                .andExpect(view().name("register"));
    }

    @Test
    public void test_recovery() throws Exception {
        mockMvc.perform(get("/recovery"))
                .andExpect(status().isOk())
                .andExpect(view().name("recovery"));
    }

    @Test
    public void test_dashboard() throws Exception {
        User user = new User("admin", "admin@sprint.com", "admin");

        when(userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())).thenReturn(user);
        verify(userRepository).findByUsername("admin");

        mockMvc.perform(get("/dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("dashboard"))
                .andExpect(model().attribute("user", user));
    }
}
