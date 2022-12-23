require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      first_name: "MyString",
      email: "MyString",
      role: 1,
      password: ""
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[role]"

      assert_select "input[name=?]", "user[password]"
    end
  end
end
