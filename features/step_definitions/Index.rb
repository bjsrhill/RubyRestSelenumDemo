require 'rest-client'
require 'rspec'
require_relative 'steps_utils'
require 'selenium-webdriver'

Before do
  @utils = StepsUtils.new
  @utils.load_properties("/values.properties")
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
  @utils.get_index_page
end

Then(/^menu items are found$/) do
  expect(JSON.parse(@response)).to include(@utils.getExpectedIndexMenus)
end

Then("menu items are visible") do
  @menus = @utils.getLocateIndexMenus
  expect(@menus).to include(@utils.getExpectedIndexMenus)
end