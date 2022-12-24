require "rails_helper"
require "spec_helper"

RSpec.describe 'Static content', type: :system do 
  before :each do
    User.create(first_name: 'Admin', email: 'admin@example.com',  password: 'password')
    User.last.admin!
  end
  context 'Animal admin' do
    before do
      visit root_path
    end

    scenario 'Create an user' do
      visit root_path

      find('#Signup').click
      fill_in :user_first_name, with: 'Cus'
      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      find('#Signup1').click
      expect(page).to have_content('Was successfully created')

    end
    scenario 'Create an animal if you are admin' do
      visit root_path
      find('#Login').click
      
      fill_in :email, with: 'admin@example.com'
      fill_in :password, with: 'password'
      find('#Login1').click

      expect(page).to have_content('You have successfuly logged in.')

      visit root_path
      visit new_animal_path
      fill_in :animal_name, with: 'Kalmar'
      fill_in :animal_breed, with: 'dog'
      click_button 'Save'
      expect(page).to have_content('Was successfully created')
    end

    scenario 'Delete an animal if you are admin' do

      find('#Login').click

      fill_in :email, with: 'admin@example.com'
      fill_in :password, with: 'password'
      find('#Login1').click
      expect(page).to have_content('You have successfuly logged in.')
      visit root_path

      # visit root_path
      visit new_animal_path
      fill_in :animal_name, with: 'Kalmar'
      fill_in :animal_breed, with: 'dog'
      click_button 'Save'
      expect(page).to have_content('Was successfully created')
      find('#Destr1').click
    end
#   end
  scenario 'Create an animal if you are not admin' do
    # visit user_session_path
    find('#Signup').click
      fill_in :user_first_name, with: 'Cus'
      fill_in :user_email, with: 'user@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
    find('#Signup1').click
    fill_in :email, with: 'user@example.com'
    fill_in :password, with: 'password'
    find('#Login1').click


    visit new_animal_path
    expect(current_path).to eq '/en'
  end

  scenario 'Visit users if you are not admin' do
    # visit user_session_path
    find('#Signup').click
      fill_in :user_first_name, with: 'Cus'
      fill_in :user_email, with: 'userq@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
    find('#Signup1').click
    fill_in :email, with: 'userq@example.com'
    fill_in :password, with: 'password'
    find('#Login1').click


    visit users_path
    expect(current_path).to eq '/en'
  end
end

    context 'Order cus' do
      before do
        User.create(first_name: 'Cus', email: 'cus@example.com',  password: 'password')
        User.last.custom!
        visit root_path
      end

      scenario 'Create an order if you are not admin' do
        find('#Login').click
        fill_in :email, with: 'cus@example.com'
        fill_in :password, with: 'password'
        find('#Login1').click

        expect(page).to have_content('You have successfuly logged in.')
    
    
        visit new_animal_path
        expect(page).to have_content("You don't have enough permissions.")
        expect(current_path).to eq '/en'


        visit root_path
        find('#Animals').click
        expect(current_path).to eq '/'
        visit animals_path
        expect(current_path).to eq '/animals'

        # find('#Search').click
      end

    end

    context "Search" do
      before do
        User.create(first_name: 'Admin', email: 'administr@example.com',  password: 'password')
        User.last.admin!
        Animal.create(name: 'kot', breed: 'dog')
        Animal.create(name: 'kat', breed: 'dog')
        Animal.create(name: 'doggy', breed: 'dog')
        Animal.create(name: 'kit', breed: 'kat')
        Animal.create(name: 'horse', breed: 'dog')
        visit root_path
      end

      scenario 'find animal one' do
        find('#Login').click
        fill_in :email, with: 'administr@example.com'
        fill_in :password, with: 'password'
        find('#Login1').click

        expect(page).to have_content('You have successfuly logged in.')

        visit animals_path

        fill_in :search_name, with: 'kot'


        find('#search').click   
        
        expect(page).to have_content('kot')

        expect(page).to_not have_content('kit')

        select "Filter by breed", :from => "filter"
        select "dog", :from => "filter_option"

        expect(page).to have_content('kot')

      end

      scenario 'find animal any' do
        find('#Login').click
        fill_in :email, with: 'administr@example.com'
        fill_in :password, with: 'password'
        find('#Login1').click

        expect(page).to have_content('You have successfuly logged in.')

        visit animals_path


        select "Filter by breed", :from => "filter"
        select "dog", :from => "filter_option"

        expect(page).to have_content('kot')
        expect(page).to have_content('kat')
        expect(page).to have_content('doggy')
        expect(page).to have_content('horse')

        expect(page).to_not have_content('kit')



      end
    end

end