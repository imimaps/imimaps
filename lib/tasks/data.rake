# frozen_string_literal: true

namespace :imimap do
  desc 'set all internships to approved'
  task approve_all: :environment do
    Internship.all.each do |i|
      i.approved = true
      i.save
    end
  end
end
namespace :imimap do
  desc 'geocode all company addresses'
  task geocode_companies: :environment do
    CompanyAddress.find_each do |ca|
      if ca.latitude.nil?
        result = ca.geocode
        if result.present?
          puts "id: #{ca.id} RESULT: #{result}"
          ca.update(latitude: result[0], longitude: result[1])
        else
          puts "id: #{ca.id} couldn't geocode"
          puts "address: #{ca.address}"
          s = 'https://imi-map.f4.htw-berlin.de/'
          p = 'de/admin/company_addresses/'
          puts "#{s}#{p}#{ca.id}"
          puts
        end
      end
    end
  end
end
