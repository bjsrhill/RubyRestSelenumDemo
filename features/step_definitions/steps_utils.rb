class StepsUtils

  attr_accessor :properties
  attr_accessor :driver

  def load_properties(properties_filename)
    File.open(File.dirname(__FILE__) + properties_filename, 'r') do |properties_file|
      @properties = {}
      properties_file.read.each_line do |line|
        line.strip!
        if (line[0] != ?# and line[0] != ?=)
          i = line.index('=')
          if (i)
            @properties[line[0..i - 1].strip] = line[i + 1..-1].strip
          else
            @properties[line] = ''
          end
        end
      end
      @properties
    end
  end

  def get_index_page
    @url = properties["indexUrl"]
    chromedriver_path = File.join(File.absolute_path('', File.dirname("chromedriver")), "features", "chromedriver")
    Selenium::WebDriver::Chrome.driver_path = chromedriver_path
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to @url
    form = wait.until {
      @element = @driver.find_element(:xpath, properties["allIndexMenus"])
      @element if @element.displayed?
    }
  end

  def getLocateIndexMenus
    @driver.find_element(:xpath, @properties["allIndexMenus"]).text
  end

  def getExpectedIndexMenus

    @properties["indexMenus"]["Beverly S. Hill"] && @properties["indexMenus"]["Professional Experience"] && @properties["indexMenus"]["Other Experience"] && @properties["indexMenus"]["Technical Skills"] && @properties["indexMenus"]["Training"] && @properties["indexMenus"]["Education"]
  end

end