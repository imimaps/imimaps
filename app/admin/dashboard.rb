# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu parent: 'imimap', priority: 1,
       label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
      end
    end

    columns do
      column do
        panel 'Recent Postponements' do
          ul do
            Postponement.last(10).reverse.map do |pp|
              li link_to(
                format('%<name>s',
                       name: pp.student.name || pp.student.email),
                admin_postponement_path(pp)
              )
            end
          end
        end
      end

      column do
        panel 'Recent Internships' do
          ul do
            Internship.last(10).reverse.map do |internship|
              li link_to(
                format('%<student_name>s at %<company>s',
                       student_name: student_name(internship: internship),
                       company: internship.company_name),
                admin_internship_path(internship)
              )
            end
          end
        end
      end

      column do
        panel 'Recent Students' do
          ul do
            Student.last(10).reverse.map do |student|
              li link_to(student.name,
                         admin_student_path(student))
            end
          end
        end
      end
    end
  end
end
