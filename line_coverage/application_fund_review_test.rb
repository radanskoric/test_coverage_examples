require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/docs/'
  coverage_dir File.expand_path('../docs/line_coverage', __dir__)
end

require_relative 'application_fund_review'
require 'minitest/autorun'

class ApplicationFundReviewTest < Minitest::Test
  def test_hustling_performative_founders_receive_four_million
    application = Application.new(true, :performative)
    assert_equal 4, millions_to_invest(application)
  end

  def test_hustling_real_grind_receives_three_million
    application = Application.new(true, :real)
    assert_equal 3, millions_to_invest(application)
  end
end
