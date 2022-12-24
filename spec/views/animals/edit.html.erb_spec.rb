# require 'rails_helper'

# RSpec.describe "animals/edit", type: :view do
#   let(:animal) {
#     Animal.create!(
#       name: "MyString",
#       breed: "MyString",
#       description: "MyText"
#     )
#   }

#   before(:each) do
#     assign(:animal, animal)
#   end

#   it "renders the edit animal form" do
#     render

#     assert_select "form[action=?][method=?]", animal_path(animal), "post" do

#       assert_select "input[name=?]", "animal[name]"

#       assert_select "input[name=?]", "animal[breed]"

#       assert_select "textarea[name=?]", "animal[description]"
#     end
#   end
# end
