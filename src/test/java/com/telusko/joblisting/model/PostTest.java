package com.telusko.joblisting.model;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Arrays;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Assertions.assertEquals;

public class PostTest {

	@Test
	@Tag("invalid")
	public void testGetProfileWhenProfileIsNull() {
		Post post = new Post();
		assertNull(post.getProfile(), "Profile should be null");
	}

	@Test
	@Tag("valid")
	public void testGetProfileWhenProfileIsNotNull() {
		Post post = new Post();
		post.setProfile("Java Developer");
		assertEquals("Java Developer", post.getProfile(), "Profile should be Java Developer");
	}

	@Test
	@Tag("boundary")
	public void testGetProfileWhenProfileIsEmpty() {
		Post post = new Post();
		post.setProfile("");
		assertEquals("", post.getProfile(), "Profile should be Empty");
	}

	@BeforeEach
	void setUp() {
		post = new Post();
	}

	@Test
	@Tag("invalid")
	void testGetDescWhenUnset() {
		assertNull(post.getDesc(), "Test failed: When description is not set, getDesc should return null");
	}

	@Test
	@Tag("valid")
	void testGetDescAfterSet() {
		String description = "This is a job post";
		post.setDesc(description);
		assertEquals(description, post.getDesc(), "Test failed: getDesc should return the description that was set");
	}

	@Test
	@Tag("boundary")
	void testGetDescWhenSetWithEmptyString() {
		post.setDesc("");
		assertEquals("", post.getDesc(),
				"Test failed: When description is set as empty, getDesc should return empty string");
	}

	@Test
	@Tag("valid")
	public void testGetExpOnNewObject() {

		Post post = new Post();

		int actualExp = post.getExp();

		Assertions.assertEquals(0, actualExp, "getExp should return 0 for a newly created Post object");
	}

	@Test
	@Tag("valid")
	public void testGetExpAfterSettingValue() {

		Post post = new Post();
		post.setExp(5);

		int actualExp = post.getExp();

		Assertions.assertEquals(5, actualExp, "getExp should return the correctly set value for a Post object");
	}

	@Test
	@Tag("boundary")
	public void testGetExpForBoundaryValue() {

		Post post = new Post();
		post.setExp(Integer.MAX_VALUE);

		int actualExp = post.getExp();

		Assertions.assertEquals(Integer.MAX_VALUE, actualExp, "getExp should correctly handle maximum integer values");
	}

	@Test
	@Tag("boundary")
	void testGetTechsWhenNotSet() {

		Post post = new Post();

		String[] technologies = post.getTechs();

		assertNull(technologies);
	}

	@Test
	@Tag("valid")
	void testGetTechsAfterSet() {

		String[] expectedTechs = { "Java", "JavaScript", "C++" };
		Post post = new Post();
		post.setTechs(expectedTechs);

		String[] actualTechs = post.getTechs();

		assertArrayEquals(expectedTechs, actualTechs);
	}

	@Test
	@Tag("invalid")
	void testGetTechsReturnReference() {

		String[] expectedTechs = { "Java", "JavaScript", "C++" };
		Post post = new Post();
		post.setTechs(expectedTechs);

		String[] actualTechs1 = post.getTechs();
		String[] actualTechs2 = post.getTechs();

		assertSame(actualTechs1, actualTechs2);
	}

	@Test
	@Tag("valid")
	public void testToStringWhenAllFieldsAreNull() {

		Post post = new Post();

		String result = post.toString();

		assertEquals("Post{profile='null', desc='null', exp=0, techs=null}", result,
				"Post object with null fields is not stringified correctly");
	}

	@Test
	@Tag("valid")
	public void testToStringWhenFieldsArePopulated() {

		Post post = new Post();
		post.setProfile("Software Engineer");
		post.setDesc("Job description here");
		post.setExp(5);
		post.setTechs(new String[] { "Java", "Python" });

		String result = post.toString();

		assertEquals("Post{profile='Software Engineer', desc='Job description here', exp=5, techs=[Java, Python]}",
				result, "Post object with populated fields is not stringified correctly");
	}

	@Test
	@Tag("boundary")
	public void testToStringWhenTechsArrayIsEmpty() {

		Post post = new Post();
		post.setProfile("Software Engineer");
		post.setDesc("Job description here");
		post.setExp(5);
		post.setTechs(new String[] {});

		String result = post.toString();

		assertEquals("Post{profile='Software Engineer', desc='Job description here', exp=5, techs=[]}", result,
				"Post object with empty techs array is not stringified correctly");
	}

	@Test
	@Tag("invalid")
	public void testToStringWhenExpIsNegative() {

		Post post = new Post();
		post.setProfile("Software Engineer");
		post.setDesc("Job description here");
		post.setExp(-5);
		post.setTechs(new String[] { "Java", "Python" });

		String result = post.toString();

		assertEquals("Post{profile='Software Engineer', desc='Job description here', exp=-5, techs=[Java, Python]}",
				result, "Post object with negative exp is not stringified correctly");
	}

}