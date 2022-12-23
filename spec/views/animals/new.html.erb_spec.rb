require 'rails_helper'

RSpec.describe "animals/new", type: :view do
  before(:each) do
    assign(:animal, Animal.new(
      name: "MyString",
      breed: "MyString",
      description: "MyText"
    ))
  end

  it "renders new animal form" do
    render

    assert_select "form[action=?][method=?]", animals_path, "post" do

      assert_select "input[name=?]", "animal[name]"

      assert_select "input[name=?]", "animal[breed]"

      assert_select "textarea[name=?]", "animal[description]"
    end
  end
end
