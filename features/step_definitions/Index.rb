require 'rest-client'
require_relative 'steps_utils'
require_relative '../page_objects/index_page_object'
require 'selenium-webdriver'

Before do
  @indexPageObject = IndexPageObject.new
  @indexPageObject.get_properties
end

After do
  if @url == @indexPageObject.url
    @driver.quit
  end
end

Given(/^the page displays$/) do
  url = @indexPageObject.restUrl
  @response = RestClient.get(url)
  puts @response.body
end

Given("the home page displays") do
  @indexPageObject.get_index_page
end

Then(/^menu items are found$/) do
  expect(JSON.parse(@response)).to include(@indexPageObject.getExpectedIndexMenus)
end

Then("menu items are visible") do
  @menus = @indexPageObject.getLocateIndexMenus
  expect(@menus).to include(@indexPageObject.getExpectedIndexMenus)
end