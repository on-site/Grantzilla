class Agency < ActiveRecord::Base
  has_many :users

  def self.find_hif
    find_by_name("HIF")
  end

  def self.ordered_agencies
    all.order(:name)
  end

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
end
