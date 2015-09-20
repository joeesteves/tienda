ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def encabezado
  	{'Accept': Mime::JSON}
  end
  def encabezado_con_contenido
  	{'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s}
  end

  def parse_json(resp)
  	JSON.parse(resp.body, symbolize_names: true)
  end

  # Add more helper methods to be used by all tests here...
end
