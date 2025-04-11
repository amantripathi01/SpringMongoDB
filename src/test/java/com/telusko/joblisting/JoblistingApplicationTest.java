package com.telusko.joblisting;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import org.junit.jupiter.api.Assertions;
import org.mockito.Mockito;
import org.junit.jupiter.api;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
import org.springframework.boot.test.context.SpringBootTest;

public class JoblistingApplicationTest {

@Tag("valid")
@Test
void docketConfigurationCheck() {
    when(joblistingApplicationUnderTest.api().getDocumentationType()).thenReturn(DocumentationType.SWAGGER_2);
    assertEquals(joblistingApplicationUnderTest.api().getDocumentationType(), DocumentationType.SWAGGER_2);
    when(joblistingApplicationUnderTest.api().getSelectors().getPathSelector()).thenReturn(PathSelectors.any());
    assertEquals(joblistingApplicationUnderTest.api().getSelectors().getPathSelector(), PathSelectors.any());
    when(joblistingApplicationUnderTest.api().isUsingDefaultResponseMessages()).thenReturn(false);
    assertEquals(joblistingApplicationUnderTest.api().isUsingDefaultResponseMessages(), false);
}

@Tag("integration")
@Test
void integrationWithApiInfoCheck() {
    when(joblistingApplicationUnderTest.api().getApiInfo()).thenReturn(apiInfo);
    assertEquals(joblistingApplicationUnderTest.api().getApiInfo(), apiInfo);
}

@Tag("valid")
@Test
void restControllerSelectionCheck() {
    when(joblistingApplicationUnderTest.api().getSelectors().getApiSelector()).thenReturn(RequestHandlerSelectors.withClassAnnotation(RestController.class));
    assertEquals(joblistingApplicationUnderTest.api().getSelectors().getApiSelector(), RequestHandlerSelectors.withClassAnnotation(RestController.class));
}

	@Test
	@Tag("ApiInfoNotNull")
	public void testApiInfoInstanceNotNull() {
		JoblistingApplication joblistingAppInstance = new JoblistingApplication();
		assertNotNull(joblistingAppInstance.apiInfo(), "apiInfo must not be null");
	}

	@Test
	@Tag("Valid")
	public void testApiInfoExecutesWithoutErrors() {
		JoblistingApplication joblistingAppInstance = new JoblistingApplication();

		assertDoesNotThrow(() -> joblistingAppInstance.apiInfo(), "apiInfo must execute without errors");
	}

	@Test
	@Tag("Boundary")
	public void testApiInfoPropertyValues() {
		JoblistingApplication joblistingAppInstance = new JoblistingApplication();
		var apiInfo = joblistingAppInstance.apiInfo();
		assertNull(apiInfo.getDescription(), "Description must be null");
		assertNull(apiInfo.getVersion(), "Version must be null");
		assertNull(apiInfo.getTermsOfServiceUrl(), "TermsOfServiceUrl must be null");
		assertNull(apiInfo.getContact(), "Contact must be null");
		assertNull(apiInfo.getLicense(), "License must be null");
		assertNull(apiInfo.getLicenseUrl(), "LicenseUrl must be null");
	}

}