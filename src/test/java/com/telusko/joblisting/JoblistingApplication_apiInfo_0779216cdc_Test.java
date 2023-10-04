package com.telusko.joblisting;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import springfox.documentation.service.ApiInfo;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

@ExtendWith(MockitoExtension.class)
@SpringBootTest
public class JoblistingApplication_apiInfo_0779216cdc_Test {

    @InjectMocks
    JoblistingApplication joblistingApplication;

    @Test
    public void testApiInfoNotNull() {
        ApiInfo apiInfo = joblistingApplication.apiInfo();
        assertNotNull(apiInfo);
    }

    @Test
    public void testApiInfoTitleIsNull() {
        ApiInfo apiInfo = joblistingApplication.apiInfo();
        assertNull(apiInfo.getTitle());
    }

    // TODO: Add more test cases as per your API documentation requirements
}
