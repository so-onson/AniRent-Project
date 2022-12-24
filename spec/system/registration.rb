require "rails_helper"

RSpec.describe "Registration", type: :system do
    scenario "Registration" do
        visit root_path

        find('#Signup').click
        fill_in :user_first_name, with: 'Cus'
        fill_in :user_email, with: 'user@example.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        find('#Signup1').click
        expect(page).to have_content('Was successfully created')

        visit root_path
        find('#Login').click
        
        fill_in :email, with: 'user@example.com'
        fill_in :password, with: 'password'
        find('#Login1').click


        expect(page).to have_content('You have successfuly logged in.')

        visit home_profile_path
        expect(current_path).to eq '/home/profile'

        find('#Orders').click

    end
end
   