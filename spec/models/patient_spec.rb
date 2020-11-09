require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
    it { should have_many :patient_doctors }
    it { should have_many(:doctors).through(:patient_doctors) }
  end

  describe "instance methods" do
    it '#find_patient_doctor()' do
      seattle = Hospital.create!(name: "Seattle Grace")
      mcdreamy = seattle.doctors.create!(
        name: "Derek 'McDreamy' Shepherd",
        speciality: 'Attending Surgeon',
        university: 'University of Pennsylvania'
      )
      meredith = seattle.doctors.create!(
        name: "Meredith Grey",
        speciality: 'General Surgery',
        university: 'Harvard University'
      )
      sara = seattle.doctors.create!(
        name: "Sara Hart",
        speciality: 'General Surgery',
        university: 'Johns Hopkins University'
      )

      zola = Patient.create!(name: 'Zola Shepherd', age: 2)
      pd = PatientDoctor.create!(patient: zola, doctor: mcdreamy)
      not_pd = PatientDoctor.create!(patient: zola, doctor: meredith)

      expect(zola.find_patient_doctor(mcdreamy)).to eq(pd)
      expect(zola.find_patient_doctor(mcdreamy)).to_not eq(not_pd)
      expect(zola.find_patient_doctor(sara)).to eq(nil)
    end
  end
end
