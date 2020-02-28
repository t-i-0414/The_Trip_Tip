# frozen_string_literal: true

def confirmation_email(user)

  mail = ActionMailer::Base.deliveries.last

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    # body[/http[^"]/+]
  end
end
