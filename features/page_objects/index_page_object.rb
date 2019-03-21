class IndexPageObject

  require_relative '../step_definitions/steps_utils'

  attr_accessor :driver
  attr_accessor :properties
  attr_accessor :url
  attr_accessor :restUrl

  def get_properties
    @utils = StepsUtils.new
    @stepsProperties = @utils.load_properties("/values.properties")
    @url = @stepsProperties["indexUrl"]
    @restUrl = @stepsProperties["url"]
  end

  def get_index_page
    chromedriver_path = File.join(File.absolute_path('', File.dirname("chromedriver")), "features/page_objects", "chromedriver")
    Selenium::WebDriver::Chrome.driver_path = chromedriver_path
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to @url
    form = wait.until {
      @element = @driver.find_element(:xpath, @stepsProperties["allIndexMenus"])
      @element if @element.displayed?
    }
  end

  def getLocateIndexMenus
    @driver.find_element(:xpath, @stepsProperties["allIndexMenus"]).text
  end

  def getExpectedIndexMenus
    @stepsProperties["indexMenus"]["Beverly S. Hill"] && @stepsProperties["indexMenus"]["Professional Experience"] && @stepsProperties["indexMenus"]["Other Experience"] && @stepsProperties["indexMenus"]["Technical Skills"] && @stepsProperties["indexMenus"]["Training"] && @stepsProperties["indexMenus"]["Education"]
  end

end