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
end