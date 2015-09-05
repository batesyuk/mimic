Feature: Checking requests were made
  In order to verify requests were made to mimic (like mock expectations)
  As a developer
  I want to be able to ask the Mimic API what requests were made
  @current
  Scenario: Configuring a request and verifying it was called
    Given that Mimic is running and accepting remote configuration on "/api"
    When I make an HTTP POST request to "http://localhost:11988/api/get" with the payload:
      """
        {"path": "/anything"}
      """
    Then I should receive an HTTP 201 response with a body containing:
      """
      {"stubs":["e3b717d5883a45ef9493d009741f7c64"]}
      """
    And I make an HTTP GET request to "http://localhost:11988/anything"
    And I make an HTTP GET request to "http://localhost:11988/api/requests"
    Then I should receive an HTTP 200 response with a body containing:
      """
      {"requests":["e3b717d5883a45ef9493d009741f7c64"]}
      """

  Scenario: Configuring a request and verifying it was not called
    Given that Mimic is running and accepting remote configuration on "/api"
    When I make an HTTP POST request to "http://localhost:11988/api/get" with the payload:
      """
        {"path": "/anything"}
      """
    Then I should receive an HTTP 201 response with a body containing:
      """
      {"stubs":["e3b717d5883a45ef9493d009741f7c64"]}
      """
    And I make an HTTP GET request to "http://localhost:11988/api/requests"
    Then I should receive an HTTP 200 response with a body containing:
      """
      {"requests":[]}
      """
