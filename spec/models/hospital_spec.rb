require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe "relationships" do
    it { should have_many :doctors }
  end

  describe "instance methods" do
    before(:each) do
      @seattle = Hospital.create!(name: "Seattle Grace")
      @mcdreamy = @seattle.doctors.create!(
        name: "Derek 'McDreamy' Shepherd",
        speciality: 'Attending Surgeon',
        university: 'University of Pennsylvania'
      )
      @bailey = @seattle.doctors.create!(
        name: "Miranda Bailey",
        speciality: 'General Surgery',
        university: 'Stanford University'
      )
      @meredith = @seattle.doctors.create!(
        name: "Meredith Grey",
        speciality: 'General Surgery',
        university: 'Harvard University'
      )
      @susan = @seattle.doctors.create!(
        name: "Susan Bones",
        speciality: 'General Surgery',
        university: 'Harvard University'
      )
      @seaside = Hospital.create!(name: "Seaside Health & Wellness Center")
    end

    it '#num_doctors' do
      expect(@seattle.num_doctors).to eq(4)
      expect(@seaside.num_doctors).to eq(0)
    end

    it '#unique_universities' do
      expected = ['University of Pennsylvania', 'Stanford University', 'Harvard University']
      expect(@seattle.unique_universities.sort).to eq(expected.sort)
      expect(@seaside.unique_universities.sort).to eq([])
    end
  end
end
