require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.new(first_name: 'Test_u', email: 'Test_u@mail.ru', role: 'custom', password: '123456')
  }
  

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid with valid attributes" do
    man = User.new(first_name: 'Test_u', email: 'Man_u@mail.ru', role: 'manager', password: '123456')
  
    expect(man).to be_valid
  end



  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "default user always admin" do
    expect(subject.role).to eq "custom"
  end

  it "default user can't be admin" do
    expect(subject.admin?).to eq false
  end

  it "created?" do
    1==User.count
    1==Customer.count
  end

end