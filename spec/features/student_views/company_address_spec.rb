# frozen_string_literal: true

require 'rails_helper'

describe 'Supply Company Details' do
  # I18n.available_locales.each do |locale|
  #  context "in locale #{locale}" do
  #      before :each do
  #        I18n.locale = locale
  #      end
  context 'with student user and now Company Information' do
    before :each do
      @user = create(:student_user_with_internship_company_wo_address)
      login_as(@user)
      create(:semester)
      @company_name = 'The Backend Company'
      @ca = build(:plain_company_address, country: 'sy')
    end

    it 'should create company' do
      visit my_internship_path
      click_on t('complete_internships.checklist.company_details')
      # fill_in :company_name_for_search, @company_name
      fill_in :name, with: @company_name
      click_on t('companies.continue2')
      expect(page).to have_link(
        @company_name
      )
      click_on @company_name
      expect(page).to have_content('Neue Firma Erstellen')
      click_on t('companies.continue_to_address')
      expect(page).to have_content('Erstelle eine neue Firmenaddresse')
      fields = CompanyAddress.attributes_required_for_save.dup
      fields.delete(:company)
      fields.delete(:country)
      select @ca.country_name, from: :company_address_country
      fields.each do |field|
        fill_in "company_address_#{field}", with: @ca.send(field)
      end
      click_button t('save')
      click_on ('Firmendetails')
      expect(page).to have_field('company_name', with: @company_name)
      click_on t('companies.continue_to_address')
      save_and_open_page
      fields.each do |field|
        expect(page).to(
          have_field("company_address_#{field}"),
         with: @ca.send(field)
       )
      end
    end
  end
  #    end
  #  end
end
