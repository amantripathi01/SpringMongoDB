package com.telusko.joblisting.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class JoblistingApplication_api_24e94226d8_Test {

    private JoblistingApplication_api_24e94226d8 joblistingApplication_api_24e94226d8;

    @BeforeEach
    public void setUp() {
        joblistingApplication_api_24e94226d8 = new JoblistingApplication_api_24e94226d8();
    }

    @Test
    public void testSetDesc_Success() {
        String expectedDesc = "Software Developer";
        joblistingApplication_api_24e94226d8.setDesc(expectedDesc);
        assertEquals(expectedDesc, joblistingApplication_api_24e94226d8.getDesc());
    }

    @Test
    public void testSetDesc_Null() {
        joblistingApplication_api_24e94226d8.setDesc(null);
        assertEquals(null, joblistingApplication_api_24e94226d8.getDesc());
    }
}
