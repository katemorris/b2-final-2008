require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
    it { should have_many :patient_doctors }
    it { should have_many(:doctors).through(:patient_doctors) }
  end

  describe "class methods" do
    it ".age_sort()" do
      seattle = Hospital.create!(name: "Seattle Grace")
      mcdreamy = seattle.doctors.create!(
        name: "Derek 'McDreamy' Shepherd",
        speciality: 'Attending Surgeon',
        university: 'University of Pennsylvania'
      )

      katie = mcdreamy.patients.create!(name: 'Katie Bryce', age: 24)
      denny = mcdreamy.patients.create!(name: 'Denny Duquette', age: 39)
      pope = mcdreamy.patients.create!(name: 'Rebecca Pope', age: 32)
      zola = mcdreamy.patients.create!(name: 'Zola Shepherd', age: 2)

      oldest_first = [denny, pope, katie, zola]
      youngest_first = [zola, katie, pope, denny]

      expect(Patient.age_sort('desc')).to eq(oldest_first)
      expect(Patient.age_sort('asc')).to eq(youngest_first)
      expect(Patient.age_sort()).to eq(youngest_first)
    end
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
