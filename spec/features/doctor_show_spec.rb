require "rails_helper"

RSpec.describe 'As a visitor', type: :feature do
  describe "When I vitis a doctor's show page" do
    before(:each) do
      @seattle = Hospital.create!(name: "Seattle Grace")
      @mcdreamy = @seattle.doctors.create!(
        name: "Derek 'McDreamy' Shepherd",
        speciality: 'Attending Surgeon',
        university: 'University of Pennsylvania'
      )
      @katie = @mcdreamy.patients.create!(name: 'Katie Bryce', age: 24)
      @denny = @mcdreamy.patients.create!(name: 'Denny Duquette', age: 39)
    end
    it "I see all of the doctor's information" do
      visit doctor_path(@mcdreamy)

      within('.doctor-data') do
        expect(page).to have_content(@mcdreamy.name)
        expect(page).to have_content(@mcdreamy.speciality)
        expect(page).to have_content(@mcdreamy.university)
        expect(page).to have_content(@seattle.name)
      end
    end

    it "I see the names of all the patients this doctor has" do
      visit doctor_path(@mcdreamy)

      within('.patients') do
        expect(page).to have_content(@katie.name)
        expect(page).to have_content(@denny.name)
      end
    end
  end
end
