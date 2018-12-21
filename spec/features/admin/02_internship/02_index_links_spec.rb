# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin index internship' do
  before :each do
    sign_in create(:admin_user)
    @internship = create(:internship)
  end

  it 'has link to Student' do
    visit admin_internships_path
    click_on @internship.student.name
    expect(current_path).to eq admin_student_path(
      id: @internship.student,
      locale: I18n.locale
    )
  end
  it 'has link to Internship' do
    visit admin_internships_path
    click_on t('active_admin.view')
    expect(current_path).to eq admin_internship_path(
      id: @internship,
      locale: I18n.locale
    )
  end
end
