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
  expect(JSON.parse(@response)).to include(@utils.properties["indexMenus"]["Beverly S. Hill"] && @utils.properties["indexMenus"]["Professional Experience"] && @utils.properties["indexMenus"]["Other Experience"] && @utils.properties["indexMenus"]["Technical Skills"] && @utils.properties["indexMenus"]["Training"] && @utils.properties["indexMenus"]["Education"])
end

Then("menu items are visible") do
  @menus = @utils.driver.find_element(:xpath, @utils.properties["allIndexMenus"]).text
  expect(@menus).to include(@utils.properties["indexMenus"]["Beverly S. Hill"] && @utils.properties["indexMenus"]["Professional Experience"] && @utils.properties["indexMenus"]["Other Experience"] && @utils.properties["indexMenus"]["Technical Skills"] && @utils.properties["indexMenus"]["Training"] && @utils.properties["indexMenus"]["Education"])
end



