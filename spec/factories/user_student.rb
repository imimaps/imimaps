# frozen_string_literal: true

# a user with role student
FactoryBot.define do
  factory :student_user, class: User do
    email { 's012345@htw-berlin.de' }
    password { 'geheim1234' }
    password_confirmation { 'geheim1234' }
    publicmail { true }
    mailnotif { true }
    role { :user }
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end

  factory :student_admin, class: User do
    email { 's012340@htw-berlin.de' }
    password { 'geheim1234' }
    password_confirmation { 'geheim1234' }
    publicmail { true }
    mailnotif { true }
    role { :admin }
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end

  factory :student_user_with_fresh_complete_internship, class: User do
    email { 's012399@htw-berlin.de' }
    password { 'geheim12' }
    password_confirmation { 'geheim12' }
    publicmail { false }
    mailnotif { true }
    role { :user }
    after(:create) do |user|
      student = user.student ||= FactoryBot.create(:student, user: user)
      student.complete_internship ||= FactoryBot.create(
        :complete_internship_w_fresh_internship,
        student: student
      )
    end
  end

  factory :student_with_internship, class: User do
    email { 's012348@htw-berlin.de' }
    password { 'geheim12' }
    password_confirmation { 'geheim12' }
    publicmail { true }
    mailnotif { true }
    role { :user }
    after(:create) do |user|
      student = user.student ||= FactoryBot.create(:student, user: user)
      student.complete_internship ||= FactoryBot.create(
        :complete_internship_with_internship,
        student: student
      )
    end
  end

  # a user with role student without internship
  FactoryBot.define do
    factory :student_user_wo_internship, class: User do
      email { 's012222@htw-berlin.de' }
      password { 'geheim1234' }
      password_confirmation { 'geheim1234' }
      publicmail { true }
      mailnotif { true }
      role { :user }
      after(:build) do |user|
        user.student ||= FactoryBot.build(:student, user: user)
      end
    end

    factory :student_user_with_internship_company_wo_address, class: User do
      email { 's012879@htw-berlin.de' }
      password { 'geheim17' }
      password_confirmation { 'geheim17' }
      publicmail { false }
      mailnotif { false }
      role { :user }
      after(:create) do |user|
        student = user.student ||= FactoryBot.create(:student, user: user)
        student.complete_internship ||= FactoryBot.create(
          :complete_internship_w_fresh_internship,
          student: student
        )
      end
    end
  end
end
