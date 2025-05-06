
  package com.telusko.api_tests;

  import com.intuit.karate.Results;
  import com.intuit.karate.Runner;
  // import com.intuit.karate.http.HttpServer;
  // import com.intuit.karate.http.ServerConfig;
  import org.junit.jupiter.api.Test;

  import static org.junit.jupiter.api.Assertions.assertEquals;

  class ResourcePoolManagement2Test {

      @Test
      void testAll() {
          String authtoken = System.getenv().getOrDefault("AUTH_TOKEN", "dummy_AUTH_TOKEN");
String urlbase = System.getenv().getOrDefault("url.base", "dummy_url.base");
          Results results = Runner.path("src/test/java/com/telusko/api_tests/ResourcePoolManagement2")
                  .systemProperty("AUTH_TOKEN", authtoken)
.systemProperty("url.base", urlbase)
                  .reportDir("testReport").parallel(1);
          assertEquals(0, results.getFailCount(), results.getErrorMessages());
      }

  }
