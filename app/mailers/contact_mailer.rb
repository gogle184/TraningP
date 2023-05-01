class ContactMailer < ApplicationMailer

  def send_mail(contact)
    @contact = contact
    mail(to: contact.email , from: ENV['SMTP_USERNAME'], subject: '【お問い合わせ(自動送信)】')
  end
end
