class CurrentInternshipsController < ApplicationController
before_filter :auth_PV #:authorize,

# CodeReviewSS17
# Why is this a special controller? It offers an index view on Internship.

	def index
		# CodeReviewSS17 this will select the randomly last created semester
		# in the database, maybe. Semester needs to be selectable, with the
		# current semester as default.
		@semester = Semester.last
		@internships = Internship.where(semester_id: @semester)
		# CodeReviewSS17 Not used in the view
		@companies = Company.all
		# CodeReviewSS17 Not used in the view
		@semesters = Semester.all

		respond_to do |format|
			format.html
			format.csv {send_data @internships.to_csv}
		end
	end

  # CodeReviewSS17
  # Redundant with redirect_PV in application_controller.rb
	def auth_PV
		if ((!current_user.superuser) && (!(current_user.email == Rails.configuration.x.pv_Email)))
			redirect_to overview_index_path
		end
	end

end
