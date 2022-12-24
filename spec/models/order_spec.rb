require 'rails_helper'

RSpec.describe Order, type: :model do

  subject {
    User.create(id:1, first_name: 'Test_u', email: 'Test_u@mail.ru', role: 'custom', password: '123456')
    Animal.create(id: 1, name: "FRog",
      breed: "dog")
    Customer.create(id: 1, user_id: 1)
    Order.new(end_date: "2022-12-21 23:11:00",
            animal_id: 1, customer_id: 1)
  }

  it "is to be valid " do
    subject.customer_id = 1
    expect(subject).to be_valid
  end

  it "not valid without cus" do
    subject.customer_id = nil
    expect(subject).to_not be_valid
  end

  it "is valid without an end_date" do
    subject.end_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a animal_id" do
    subject.animal_id = nil
    expect(subject).to_not be_valid
  end

end
