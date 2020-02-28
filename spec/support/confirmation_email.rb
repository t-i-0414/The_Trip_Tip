# frozen_string_literal: true

def confirmation_email
  mail = ActionMailer::Base.deliveries.last
  mail_body = mail.body.encoded

  confirmation_link = mail_body.match(%r{http[^"]+users\/confirmation[^"]+})

  visit confirmation_link
end
