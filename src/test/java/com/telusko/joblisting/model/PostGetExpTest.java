
// ********RoostGPT********
/*
Test generated by RoostGPT for test amanAzure12Feb using AI Type Azure Open AI and AI Model inference

ROOST_METHOD_HASH=getExp_a80bcda041
ROOST_METHOD_SIG_HASH=getExp_e90c52dc7e

Sure, here are the test scenarios for the `getExp` method in the `Post` class:

```java
Scenario 1: Verify the default value of exp when no value is set.

Details:
  TestName: defaultExpValue
  Description: This test checks if the default value of the exp field is 0 when no value is set.
Execution:
  Arrange: Create a Post object without setting the exp value.
  Act: Invoke the getExp method.
  Assert: Verify that the returned value is 0.
Validation:
  Clarify what the assertion aims to verify and the reason behind the expected result.
  Elaborate on the significance of the test in the context of application behavior or business logic.

Scenario 2: Verify the value of exp after setting a positive value.

Details:
  TestName: positiveExpValue
  Description: This test checks if the getExp method returns the correct value when a positive integer is set for exp.
Execution:
  Arrange: Create a Post object and set the exp value to a positive integer.
  Act: Invoke the getExp method.
  Assert: Verify that the returned value matches the set value.
Validation:
  Clarify what the assertion aims to verify and the reason behind the expected result.
  Elaborate on the significance of the test in the context of application behavior or business logic.

Scenario 3: Verify the value of exp after setting a zero value.

Details:
  TestName: zeroExpValue
  Description: This test checks if the getExp method returns 0 when the exp value is explicitly set to 0.
Execution:
  Arrange: Create a Post object and set the exp value to 0.
  Act: Invoke the getExp method.
  Assert: Verify that the returned value is 0.
Validation:
  Clarify what the assertion aims to verify and the reason behind the expected result.
  Elaborate on the significance of the test in the context of application behavior or business logic.

Scenario 4: Verify the value of exp after setting a negative value.

Details:
  TestName: negativeExpValue
  Description: This test checks if the getExp method returns the correct value when a negative integer is set for exp.
Execution:
  Arrange: Create a Post object and set the exp value to a negative integer.
  Act: Invoke the getExp method.
  Assert: Verify that the returned value matches the set value.
Validation:
  Clarify what the assertion aims to verify and the reason behind the expected result.
  Elaborate on the significance of the test in the context of application behavior or business logic.
```
*/

// ********RoostGPT********

package com.telusko.joblisting.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.*;

public class PostGetExpTest {

	private Post post;

	@BeforeEach
	public void setUp() {
		post = new Post();
	}

	@Test
	@Tag("valid")
	public void testDefaultExpValue() {
		assertEquals(0, post.getExp());
	}

	@Test
	@Tag("valid")
	public void testPositiveExpValue() {
		int expectedExp = 5;
		post.setExp(expectedExp);
		assertEquals(expectedExp, post.getExp());
	}

	@Test
	@Tag("valid")
	public void testZeroExpValue() {
		int expectedExp = 0;
		post.setExp(expectedExp);
		assertEquals(expectedExp, post.getExp());
	}

	@Test
	@Tag("valid")
	public void testNegativeExpValue() {
		int expectedExp = -3;
		post.setExp(expectedExp);
		assertEquals(expectedExp, post.getExp());
	}

}