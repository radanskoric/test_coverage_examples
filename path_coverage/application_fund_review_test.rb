require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/docs/'
  coverage_dir File.expand_path('../docs/path_coverage', __dir__)
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

  def test_no_hustling_no_grind_receives_no_money
    application = Application.new(false, :none)
    assert_equal 0, millions_to_invest(application)
  end

  def test_no_hustling_real_grind_receives_one_million
    application = Application.new(false, :real)
    assert_equal 1, millions_to_invest(application)
  end

  def test_hustling_no_grind_receives_two_million
    application = Application.new(true, :none)
    assert_equal 2, millions_to_invest(application)
  end
end
