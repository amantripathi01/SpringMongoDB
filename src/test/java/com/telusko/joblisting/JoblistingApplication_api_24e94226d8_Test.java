package com.telusko.joblisting;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootTest
@EnableSwagger2
public class JoblistingApplication_api_24e94226d8_Test {

    @InjectMocks
    JoblistingApplication_api_24e94226d8 joblistingApplication = new JoblistingApplication_api_24e94226d8();

    @Test
    public void testApi() {
        Docket docket = joblistingApplication.api();
        Assertions.assertNotNull(docket);
    }

    @Test
    public void testApiInfo() {
        ApiInfo apiInfo = Mockito.mock(ApiInfo.class);
        Mockito.when(joblistingApplication.apiInfo()).thenReturn(apiInfo);
        Assertions.assertEquals(apiInfo, joblistingApplication.apiInfo());
    }
}
