require 'rails_helper'

RSpec.describe Manager, type: :model do
  subject {
    User.create(id:1, first_name: 'Test_u', email: 'Test_u@mail.ru', role: 'manager', password: '123456')

    Customer.new( user_id: 1)
  }

  it "be valid" do
    expect(subject).to be_valid
  end

  it "not be valid" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

end
