# frozen_string_literal: true

TEXT3 = <<DELIM
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
  nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
  eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
  sunt in culpa qui officia deserunt mollit anim id est laborum
DELIM

FactoryBot.define do
  factory :internship_offer do
    title { 'internship offer title' }
    body { TEXT3 }
    pdf { 'internship offer pdf' }
    city { 'London' }
    country { 'UK' }
  end
  factory :io2, class: InternshipOffer do
    title { 'internship offer title' }
    body { TEXT3 }
    pdf { 'internship offer pdf' }
    city { 'San Francisco' }
    country { 'USA' }
  end
  factory :io3, class: InternshipOffer do
    title { 'internship offer title' }
    body { TEXT3 }
    pdf { 'internship offer pdf' }
    city { 'Paris' }
    country { 'Frankreich' }
  end
end
