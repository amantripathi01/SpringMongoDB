Feature: API Testing for Website Functionalities

Background:
  Given the API base URL 'http://localhost:3000'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: Verify Product Brochure Display
  Given the product brochure is uploaded to the website
  When I navigate to the website homepage
  And I locate the section where the product brochure is displayed
  Then the product brochure should be visible
  And all text should be clear and readable
  And there should be no formatting issues

Scenario: Verify Downloadable Files List on WordPress Site
  Given the downloadable files are uploaded and linked on the WordPress site
  When I navigate to the WordPress site
  And I locate the section where downloadable files are listed
  Then all files should be listed correctly
  And all links should be functional, allowing users to download files

Scenario: Test Website Performance Under Load
  Given load testing tools are set up and configured
  When I use a load testing tool to simulate multiple users accessing the website simultaneously
  Then the website's response time should be acceptable
  And the website should remain stable under high traffic conditions
  And there should be no performance degradation or errors

Scenario: Ensure Website Accessibility
  Given accessibility testing tools are available
  When I use accessibility testing tools to evaluate the website
  Then the website should comply with WCAG 2.1 standards
  And there should be no accessibility issues
  And the website should be usable by individuals with disabilities
