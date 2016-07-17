# frozen_string_literal: true
class Person < ApplicationRecord
  has_many :employments
  has_many :incomes
  belongs_to :grant

  accepts_nested_attributes_for(:incomes, reject_if: :all_blank, allow_destroy: true)

  FULL_TIME_STUDENT = "Full-Time".freeze
  PART_TIME_STUDENT = "Part-Time".freeze
  STUDENT_STATUSES = [PART_TIME_STUDENT, FULL_TIME_STUDENT].freeze

  def current_earned_income
    incomes.select(&:current).reject(&:disabled).map(&:monthly_income).sum
  end

  def current_income
    incomes.select(&:current).map(&:monthly_income).sum
  end

  def current_unearned_income
    incomes.select(&:current).select(&:disabled).map(&:monthly_income).sum
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end
end
