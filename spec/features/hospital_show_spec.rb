require "rails_helper"

RSpec.describe 'As a visitor', type: :feature do
  describe "When I visit a hospital's show page" do
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
      @karev = @seaside.doctors.create!(
        name: "Alex Karev",
        speciality: 'Pediatric Surgery',
        university: 'Johns Hopkins University'
      )
      visit hospital_path(@seattle)
    end

    it "I see the hospital's name" do
      expect(page).to have_content(@seattle.name)
      expect(page).to_not have_content(@seaside.name)
    end

    it "I see the number of doctors that work at the hospital" do
      expect(page).to have_content("Doctors: 4")
      expect(page).to_not have_content("Doctors: 5")
    end

    it "I see a unique list of universities that the hospital doctors attended" do
      within('.universities') do
        expect(page).to have_content("Harvard University", count: 1)
        expect(page).to have_content("University of Pennsylvania", count: 1)
        expect(page).to have_content("Stanford University", count: 1)

        expect(page).to_not have_content("Johns Hopkins University")
      end
    end
  end
end
