require 'json'
require 'ap'
require 'minitest'
require 'wrong'
require 'wrong/assert'
require 'wrong/helpers'
require 'minitest/autorun'

class Minitest::Test
  include Wrong::Assert
  include Wrong::Helpers

  def failure_class
    MiniTest::Assertion
  end

  def increment_assertion_count
    self.assertions += 1
  end
end
