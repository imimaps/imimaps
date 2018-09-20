# frozen_string_literal: true

ActiveAdmin.register Internship do
  permit_params InternshipsController.permitted_params
  filter :student_enrolment_number,
         as: :select,
         collection: proc { Student.all.map(&:enrolment_number).uniq },
         label: 'Matrikel'
  filter :reading_prof
  filter :semester
  filter :internship_state

  index do
    column :id do |i|
      link_to i.id, admin_internship_path(i.id)
    end
    column :student do |i|
      link_to i.student.name, admin_student_path(i.student_id)
    end
    column :company_v2
    column :semester
    column :internship_state
    column :report_state
    column :certificate_state
    column :certificate_to_prof
    column :certificate_signed_by_prof
    column :certificate_signed_by_internship_officer
    column :reading_prof
    actions
  end
end