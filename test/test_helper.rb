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

  # def aver(valence, explanation = nil, depth = 0)
  #   increment_assertion_count
  #   super(valence, explanation, depth + 1) # apparently this passes along the default block
  # end
end
