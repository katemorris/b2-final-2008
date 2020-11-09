require "rails_helper"

RSpec.describe 'As a visitor', type: :feature do
  describe "When I visit a patient index page" do
    it "I see all patients listed from oldest to youngest" do
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

      visit patients_path

      within('.patients') do
        expect(page.all('li')[0]).to have_content(denny.name)
        expect(page.all('li')[1]).to have_content(pope.name)
        expect(page.all('li')[2]).to have_content(katie.name)
        expect(page.all('li')[3]).to have_content(zola.name)
      end
    end
  end
end
