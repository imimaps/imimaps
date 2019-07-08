# frozen_string_literal: true

require 'rails_helper'

describe 'Company Suggestion' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should tell me there was no match' do
          create(:semester)
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in('Name', with: 'Testfirma')
          click_on t('companies.continue')
          expect(page).not_to have_content(
            t('companies.suggestion')
          )
          expect(page).to have_content(
            t('companies.no_match1')
          )
        end

        it 'should show me only similar matches' do
          create(:semester)
          create(:company_1)
          create(:company_2)
          create(:company_is24)
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in('Name', with: 'CoMp')
          click_on t('companies.continue')
          expect(page).to have_content(
            t('companies.suggestion')
          )
          expect(page).to have_content(
            'Company 1'
          )
          expect(page).not_to have_content(
            t('companies.no_match1')
          )
          expect(page).not_to have_content(
            'Immobilienscout'
          )
        end

        it 'should not progress when no name was given' do
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in('Name', with: '')
          click_on t('companies.continue')
          expect(page).to have_content(
            t('companies.select.companyname')
          )
        end
        end
      end
    end
  end
end
