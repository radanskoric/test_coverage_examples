require_relative 'test_helper'
require 'input_validator'

class ValidatorPathStageTest < Minitest::Test
  def valid_params(overrides = {})
    {
      email: 'user@example.com',
      password: 'very-secure-secret',
      age: 21,
      country: 'US',
      beta: false,
      ip_reputation: :low_risk
    }.merge(overrides)
  end

  def test_path_supported_country_without_risk
    assert_equal :allow, InputValidator.verdict(valid_params(country: 'US', beta: false, ip_reputation: :low_risk))
  end

  def test_path_supported_country_with_high_risk_ip
    assert_equal :manual_review, InputValidator.verdict(valid_params(country: 'US', beta: false, ip_reputation: :high_risk))
  end

  def test_path_beta_override_without_risk
    assert_equal :allow_beta, InputValidator.verdict(valid_params(country: 'FR', beta: true, ip_reputation: :low_risk))
  end

  def test_path_beta_override_with_high_risk_ip
    assert_equal :manual_review, InputValidator.verdict(valid_params(country: 'FR', beta: true, ip_reputation: :high_risk))
  end

  def test_path_unsupported_country_without_beta_and_without_risk
    assert_equal :reject_region, InputValidator.verdict(valid_params(country: 'FR', beta: false, ip_reputation: :low_risk))
  end

  def test_path_unsupported_country_without_beta_and_with_high_risk_ip
    assert_equal :reject_region, InputValidator.verdict(valid_params(country: 'FR', beta: false, ip_reputation: :high_risk))
  end

  def test_path_rejects_bad_email_before_region_logic
    assert_equal :reject_email, InputValidator.verdict(valid_params(email: 'invalid-email', country: 'FR', beta: true, ip_reputation: :high_risk))
  end

  def test_path_rejects_short_password_before_region_logic
    assert_equal :reject_password, InputValidator.verdict(valid_params(password: 'short', country: 'US', beta: false, ip_reputation: :high_risk))
  end

  def test_path_rejects_underage_user_before_region_logic
    assert_equal :reject_age, InputValidator.verdict(valid_params(age: 17, country: 'FR', beta: true, ip_reputation: :high_risk))
  end

  def test_path_allowed_wrapper_is_true_for_supported_country_success
    assert InputValidator.allowed?(valid_params(country: 'CA', beta: false, ip_reputation: :low_risk))
  end

  def test_path_allowed_wrapper_is_true_for_beta_success
    assert InputValidator.allowed?(valid_params(country: 'FR', beta: true, ip_reputation: :low_risk))
  end

  def test_path_manual_review_wrapper_is_true_for_high_risk_supported_country
    assert InputValidator.requires_manual_review?(valid_params(country: 'US', beta: false, ip_reputation: :high_risk))
  end

  def test_path_manual_review_wrapper_is_false_for_rejected_signup
    refute InputValidator.requires_manual_review?(valid_params(country: 'FR', beta: false, ip_reputation: :high_risk))
  end
end
