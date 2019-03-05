# frozen_string_literal: true

# Represents a user in the imi-map.
# Users can be Students, Professors, or IMI-Map Admins.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 5 }
  # validates :student, presence: true

  belongs_to :student
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :read_lists, dependent: :destroy
  has_many :finish_lists, dependent: :destroy

  def name
    if student.nil?
      email
    else
      "#{student.first_name} #{student.last_name}"
    end
  end

  EDITABLE_ATTRIBUTES = %i[email mailnotif publicmail student role].freeze
  EDITABLE_ATTRIBUTES_PW = %i[password password_confirmation].freeze
  EDITABLE_ATTRIBUTES_ALL = EDITABLE_ATTRIBUTES + EDITABLE_ATTRIBUTES_PW
  ROLES = %i[admin prof examination_office user].freeze
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  # note that student is not a role.
  def student?
    return true if student

    student_email?(email)
  end

  def enrolment_number
    return nil unless student?

    if student
      student.enrolment_number
    else
      User.enrolment_number_from(email: email)
    end
  end
  STUDENT_MAIL_REGEX = /s(\d{6})@htw-berlin.de/.freeze
  def student_email?(email1)
    !STUDENT_MAIL_REGEX.match(email1).nil?
  end

  def self.email_for(enrolment_number:)
    er = enrolment_number.rjust(6, '0')
    "s#{er}@htw-berlin.de"
  end

  def self.enrolment_number_from(email:)
    match = STUDENT_MAIL_REGEX.match(email)
    return nil unless match

    # remove leading 0
    match[1].sub(/^0+/, '')
  end

  def self.find_or_create(email:, password:)
    user = User.where(email: email).first
    if user
      old_pw = user.encrypted_password
      user.update_attributes(password: password) unless password == old_pw
    end
    user ||= User.create(email: email,
                         password: password,
                         password_confirmation: password)
    Student.find_or_create_for(user: user) if user.student_email?(email)
    user
  end

  def accessible_company_addresses
    CompanyAddress.joins(
      internships: { complete_internship: { student: :user } }
    )
                  .where('users.id' => id)
  end

  def accessible_internships
    Internship.joins(complete_internship: { student: :user })
              .where('users.id' => student.user.id)
              .where('users.id' => id)
  end
end
