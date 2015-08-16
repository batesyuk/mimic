Feature: Allow binding to all ip address not just localhost
  In order to use mimic from an IP address other than localhost
  As a developer
  I want to check that requests can be made from the machines ip address

  Scenario: Calling a POST request from the local IP not localhost to return a 201 response
    Given I have a mimic specification with:
      """
      Mimic.mimic(:port => 11988).post("/some/path").returning("Hello World", 201)
      """
    When I make an HTTP POST request to path "/some/path" from the local ip address
    Then I should receive an HTTP 201 response with a body matching "Hello World"
