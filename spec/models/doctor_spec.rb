require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe "relationships" do
    it { should belong_to :hospital }
    it { should have_many :patient_doctors }
    it { should have_many(:patients).through(:patient_doctors) }
  end
end
