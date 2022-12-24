require 'rails_helper'

RSpec.describe Animal, type: :model do

  subject {
    Animal.new(name: "FRog",
            breed: "dog")
  }

  it "is not valid without singer" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is  valid without an description" do
    subject.description = nil
    expect(subject).to be_valid
  end

  it "is not valid without a breed" do
    subject.breed = nil
    expect(subject).to_not be_valid
  end


end
