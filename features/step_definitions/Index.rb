require 'rest-client'
require 'rspec'
require_relative 'steps_utils'
require_relative '../page_objects/index_page_object'
require 'selenium-webdriver'

Before do
  @utils = StepsUtils.new
  @utils.load_properties("/values.properties")
  @indexPageObject = IndexPageObject.new
end

After do
  if @url == @utils.properties["indexUrl"]
    @driver.quit
  end
end

Given(/^the page displays$/) do
  url = @utils.properties["url"]
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