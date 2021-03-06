# frozen_string_literal: true

# View Helper Methods for all Controllers.
module ApplicationHelper
  def render_stars(rating, template)
    RatingRenderer.new(rating, template).render_star_fields
  end

  def path_to_complete_internship
    return no_complete_internship_path unless (cu = @current_user)
    return no_complete_internship_path unless (s = cu.student)
    return no_complete_internship_path unless (ci = s.complete_internship)

    complete_internship_path(ci)
  end

  def search_is_active_menu_item?
    controller.controller_name == 'searches'
  end

  def active_menu_item?(path)
    return @active_menu_item == path if @active_menu_item

    current_page?(path)
  end

  def flash_class(level)
    { notice: 'alert alert-info', success: 'alert alert-success',
      error: 'alert alert-danger', alert: 'alert alert-info' }[level]
  end

  def notifications
    Notification.where(user_id: current_user.try(:id)).order('created_at DESC')
  end

  def locale_picker
    I18n.available_locales.each do |loc|
      # permitted_params
      pp = %i[locale internship_id company_id cidcontext complete_internship]
      # CodeReviewSS17
      # this seems to be a necessary workaround because of the current
      # url structure, maybe adapt the routes/paths?
      locale_param = if request.path == root_path
                       root_path(locale: loc)
                     else
                       params.permit(pp).merge(locale: loc)
                     end
      concat content_tag(:li, (link_to_unless_current loc, locale_param),
                         class: "locale-#{loc}")
    end
  end

  # form helper that adds a label_class to the bootstrap_form field. see #402
  def required_application(form, field, options = {})
    required_application_impl(form, field, :label_class, options)
  end

  def required_application_impl(form, field, css_class, options = {})
    model = form.object.class
    if model.attributes_required_for_internship_application.include? field
      options.merge!(css_class => 'required_application')
    end
    options
  end

  # in bootstrap_forms the "required" css class is set by bootstrap;
  # this would only be needed in other (non-bootstrap) forms.
  def required_save_and_application(form, field, options = {})
    model = form.object.class
    options.merge!(class: 'required') \
      if model.attributes_required_for_save.include? field
    required_application_impl(form, field, :class, options)
  end

  def number_of_comments(resource_id, resource_type)
    ActiveAdmin::Comment.where(resource_id: resource_id,
                               resource_type: resource_type).count
  end
end
