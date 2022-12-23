require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      first_name: "MyString",
      email: "MyString",
      role: 1,
      password: ""
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[role]"

      assert_select "input[name=?]", "user[password]"
    end
  end
end
