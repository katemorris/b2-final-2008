require "rails_helper"

RSpec.describe 'As a visitor', type: :feature do
  describe "When I visit a doctor's show page" do
    before(:each) do
      @seattle = Hospital.create!(name: "Seattle Grace")
      @mcdreamy = @seattle.doctors.create!(
        name: "Derek 'McDreamy' Shepherd",
        speciality: 'Attending Surgeon',
        university: 'University of Pennsylvania'
      )
      @katie = @mcdreamy.patients.create!(name: 'Katie Bryce', age: 24)
      @denny = @mcdreamy.patients.create!(name: 'Denny Duquette', age: 39)
      @pope = @mcdreamy.patients.create!(name: 'Rebecca Pope', age: 32)
      @zola = @mcdreamy.patients.create!(name: 'Zola Shepherd', age: 2)

      visit doctor_path(@mcdreamy)
    end
    it "I see all of the doctor's information" do
      within('.doctor-data') do
        expect(page).to have_content(@mcdreamy.name)
        expect(page).to have_content(@mcdreamy.speciality)
        expect(page).to have_content(@mcdreamy.university)
        expect(page).to have_content(@seattle.name)
      end
    end

    it "I see the names of all the patients this doctor has" do
      within('.patients') do
        expect(page).to have_content(@katie.name)
        expect(page).to have_content(@denny.name)
        expect(page).to have_content(@zola.name)
        expect(page).to have_content(@pope.name)
      end
    end

    it "Next to each patient I see a button to remove that patient" do
      within('.patients') do
        expect(page).to have_button("Remove", count: 4)
      end
    end

    it "When clicked, the doctor's page no longer shows the patient" do
      within("#patient-#{@zola.id}") do
        click_on "Remove"
      end

      expect(current_path).to eq(doctor_path(@mcdreamy))

      within('.patients') do
        expect(page).to have_content(@katie.name)
        expect(page).to have_content(@denny.name)
        expect(page).to_not have_content(@zola.name)
        expect(page).to have_content(@pope.name)
      end
    end
  end
end
