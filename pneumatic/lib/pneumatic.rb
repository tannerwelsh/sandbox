require 'socket'

Dir[File.expand_path('../pneumatic/*.rb', __FILE__)].each do |file|
  require file
end

module Pneumatic
end