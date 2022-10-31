package io.github.parj.hello;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
public class MakeItFailControllerTest {
    @Autowired
    private MockMvc mvc;

    @Test
    public void testFailure() throws Exception {
        mvc.perform(MockMvcRequestBuilders.post("/letitgo").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().is5xxServerError());
    }
}
