# frozen_string_literal: true

# Companies
FactoryBot.define do
  factory :company_address_htw, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Wilhelminenhofstr. 75 A' }
    zip { '12459' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    company
  end

  factory :company_address_is24, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Andreasstr. 10' }
    zip { '10243' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    company
  end

  factory :company_address_for_edit, class: CompanyAddress do
    city { 'Berkeley' }
    country { 'USA' }
    street { '2454 Telegraph Avenue' }
    zip { '94704' }
    phone { '+187345847' }
    fax { '+187345888' }
    company { create(:company_for_edit) }
  end

  factory :company_for_edit, class: Company do
    name { 'Cool Programming' }
    number_employees { 232 }
    industry { 'IT' }
    website { 'www.company.de' }
    main_language { 'English' }
    blacklisted { false }
    import_id { 2 }
  end

#github
  factory :company_address_1, class: CompanyAddress do
    city { 'San Francisco' }
    country { 'USA' }
    street { '88 Colin P Kelly Jr St' }
    zip { '94107' }
    phone { '+187345847' }
    fax { '+187345888' }
    company { create(:company_1) }
  end
# amazon locker lasse
  factory :company_address_2, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Karl-Marx-Straße 267' }
    zip { '12057' }
    phone { '+187345847' }
    fax { '+187345888' }
    company { create(:company_2) }
  end
end