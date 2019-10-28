# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      def log_in_with_unknown_email
        visit root_path
        fill_in 'user_email', with: 's0987654@htw-berlin.de'
        fill_in 'user_password', with: 'geheim12'
        click_on('Log in')
      end
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: true)
        log_in_with_unknown_email
      end

      context 'first login' do
        it 'should proceed to log in and back to original page' do
          expect(page).to have_content I18n.t('devise.sessions.signed_in')
        end

        it 'should save internship without student data' do
          create(:semester)
          visit my_internship_path
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(t('complete_internships.semester'))
        end
      end
    end
  end
end