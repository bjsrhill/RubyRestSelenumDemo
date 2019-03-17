@index-menus
Feature: The beverlyshill.solutions has an index page

  @index-menusRest
  Scenario: Accessing beverlyshill.solutions/index as a REST endpoint displays menus for the index page
    Given the page displays
    Then menu items are found

  @index-menusSelenium
  Scenario: Accessing beverlyshill.solutions displays a web page with the menus for the index page
    Given the home page displays
    Then menu items are visible