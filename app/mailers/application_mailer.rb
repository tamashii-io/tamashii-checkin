# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'tamashii@5xruby.tw'
  layout 'mailer'
end
