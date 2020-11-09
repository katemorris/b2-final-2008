class Hospital < ApplicationRecord
  has_many :doctors

  def num_doctors
    doctors.count
  end

  def unique_universities
    doctors.pluck(:university).uniq
  end
end
