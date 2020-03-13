# frozen_string_literal: true

def visit_unlock_account
  mail = ActionMailer::Base.deliveries.last
  mail_body = mail.body.encoded

  edit_password_link = mail_body.match(%r{http[^"]+users\/unlock[^"]unlock_token[^"]+})

  visit edit_password_link
end
