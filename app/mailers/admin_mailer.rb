# frozen_string_literal: true

# TBD - still working?
class AdminMailer < ActionMailer::Base
  # This class appears to be unused. Thus: excluding from coverage
  # :nocov:

  default to: proc { Admin.pluck(:email) },
          from: 'notification@imi-maps.com'

  def receive(email)
    page = Page.find_by_address(email.to.first)
    page.emails.create(
      subject: email.subject,
      body: email.body
    )

    return unless email.has_attachments?

    email.attachments.each do |attachment|
      page.attachments.create(file: attachment, description: email.subject)
    end
  end

  # :nocov:
end
