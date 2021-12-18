# frozen_string_literal: true

# Dir.glob("#{File.dirname(__FILE__)}/*.rb").sort.each do |file|
Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
