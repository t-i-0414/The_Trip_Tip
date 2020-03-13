# frozen_string_literal: true

def visit_edit_password
  mail = ActionMailer::Base.deliveries.last
  mail_body = mail.body.encoded

  edit_password_link = mail_body.match(%r{http[^"]+users\/password\/edit[^"]reset_password_token[^"]+})

  visit edit_password_link
end
