require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber_web) do |t|
  t.cucumber_opts = "--format pretty --strict --require features/"
  t.profile = 'web'
end

Cucumber::Rake::Task.new(:cucumber_rest) do |t|
  t.cucumber_opts = "--format pretty --strict --require features/"
  t.profile = 'rest'
end