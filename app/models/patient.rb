class Patient < ApplicationRecord
  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors

  def self.age_sort(order = 'asc')
    order(age: order.to_sym)
  end

  def find_patient_doctor(doctor)
    PatientDoctor.find_by("doctor_id = #{doctor.id} AND patient_id = #{self.id}")
  end
end
