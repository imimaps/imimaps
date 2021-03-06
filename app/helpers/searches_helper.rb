# frozen_string_literal: true

# Searches Helper
module SearchesHelper
  def filter_paid_true(internships)
    internships.select do |i|
      # i.payment_state_id == 2 => "cash benefit" (6 in testing)
      i.payment_state_id == 2 || i.payment_state_id == 6
    end
  end

  def filter_paid_false(internships)
    internships.select do |i|
      i.payment_state_id != 2 && i.payment_state_id != 6
    end
  end

  def filter_paid(internships)
    return internships if @search.paid.nil?
    return internships unless internships

    case @search.paid
    when true
      internships = filter_paid_true(internships)
    when false
      internships = filter_paid_false(internships)
    end
    internships
  end

  def filter_location(internships)
    loc = @search.location
    return internships unless loc
    return internships if loc.empty?

    return internships unless internships

    internships.select do |i|
      city_matches = i.company_address.try(:city) == loc
      country_matches = i.company_address.try(:country_name) == loc
      city_matches || country_matches
    end
  end

  def filter_orientation_id(internships)
    return internships unless @search.orientation_id

    return internships unless internships

    internships.select do |i|
      i.orientation_id == @search.orientation_id
    end
  end

  def filter_pl(internships)
    return internships unless @search.programming_language_id

    return internships unless internships

    internships.select do |i|
      i.programming_language_ids.include?(@search.programming_language_id)
    end
  end

  def sort_results(internships)
    return internships unless internships

    internships = internships.sort_by do |i|
      if i.start_date.nil?
        Date.new(1990, 1, 1)
      else
        i.start_date
      end
    end
    internships.reverse
  end

  def pick_random_results(internships)
    return internships unless internships
    return internships if current_user.admin?

    internships = internships.sample(UserCanSeeInternship.limit)
    internships = internships.select do |i|
      UserCanSeeInternship.internship_search(internship_id: i.id,
                                             user: current_user)
    end
    internships = viewed_internships(internships)
    sort_results(internships)
  end

  def show_one_random_result(internship)
    return internship unless internship
    return internship if current_user.admin?

    internships = internship.sample(UserCanSeeInternship.limit)
    internships.select do |i|
      UserCanSeeInternship.internship_search(internship_id: i.id,
                                             user: current_user)
    end
  end

  def viewed_internships(internships)
    if internships.count < 12
      internships += Internship.where(id:
        UserCanSeeInternship
        .where(user: current_user).map(&:internship_id))
      internships = internships.uniq
      internships = filter(internships)
    end
    internships
  end

  def filter(internships)
    internships = filter_paid(internships)
    internships = filter_location(internships)
    internships = filter_orientation_id(internships)
    filter_pl(internships)
  end

  def collect_results
    internships = Internship.where('start_date < CURRENT_DATE')
    internships = filter(internships)
    sort_results(internships)
  end

  def pick_random_internship
    @search = Search.new
    internships = sort_by_age
    internships = internships.shuffle
    @results = Array.new(1, internships[0])
  end

  def sort_by_age
    internships = Internship.order(start_date: :desc)
    internships.where('start_date > ?', 2.years.ago)
  end
end
