# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it 'orders semesters chronologically' do
    far_future = Semester.for_date(Date.today + 3.years)
    ['SS 13', 'WS 12/13', 'SS 12', 'WS 11/12', 'WS 14/15', 'SS 15',
     'WS 15/16', 'SS 16', 'WS 16/17', 'SS 17', 'WS 17/18', 'SS 18',
     'WS 18/19', 'SS 11', 'WS 10/11', 'SS 10', 'WS 09/10', 'SS 09',
     'WS 13/14', 'SS 14', 'WS 08/09', 'WS 07/08', 'SS 06', 'SS 08',
     'WS 06/07', 'SS 04', 'SS 07', 'SS 19'].shuffle.each do |name|
      Semester.create(name: name)
    end
    all = Semester.all
    expect(all.last.name).to eq 'SS 04'
    expect(all.first.name).to eq far_future.name
    index_ws15 = all.index { |s| s.name == 'WS 15/16' }
    index_ss16 = all.index { |s| s.name == 'SS 16' }
    expect(index_ss16).to be < index_ws15
  end
end
