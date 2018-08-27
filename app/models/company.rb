# frozen_string_literal: true

# The Company where an Internship takes place.
class Company < ApplicationRecord
  # validates :street, presence: true, allow_blank: false
  # validates :zip, presence: true, allow_blank: false
  # validates :city, presence: true, allow_blank: false
  # validates :country, presence: true, allow_blank: false
  # #validates :main_language, presence: true, allow_blank: false
  # #validates :industry, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  # #validates :number_employees, presence: true, allow_blank: false
  # #validates :website, presence: true, allow_blank: false

  #geocoded_by :address
  # TBD: geocoding should only happen if necessary, see
  # https://github.com/alexreisner/geocoder#avoiding-unnecessary-api-requests
  #after_validation :geocode, if: :address_changed?
  # acts_as_gmappable :process_geocoding => false

  # associations
  has_many :internships
  has_many :company_addresses
  # CodeReviewSS17: delete?
  # accepts_nested_attributes_for :internships

  #def address
    #[street, zip, city, country].compact.join(', ')
  #end

  def enrolment_number
    internships.map { |x| x.student.enrolment_number }.join(', ')
  end

  def average_rating
    r = 0
    size = 0
    internships.select(&:completed).each do |x|
      if x.internship_rating.total_rating
        r += x.internship_rating.total_rating
        size += 1
      end
    end
    size ||= 1
    r.to_f / size
  end

  #def address_changed?
    #street_changed? || city_changed? || zip_changed? || country_changed?
  #end

  # TBD ST: needs refactoring - what does it do?
  # it produces a list for a company selection box in the view.
  # this and the map that follows in the view should be moved to a helper
  # method.
  def self.company_name_address
    i = 0
    a = []
    Company.all.each do |c|
      j=0
      c.company_addresses.each do |c_a|
        a[i]=[]
        a[i] << c_a.id
        a[i] << "#{c.name}, #{c_a.street}"
        i = i + 1
      end
    end
   a
  end

  def company_name
    self.try(:name)
  end

  def company_name=(name)
    self.company = Company.find_or_create_by_name(name) if name.present?
  end
end
