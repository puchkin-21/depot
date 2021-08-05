# Preview all emails at http://localhost:3000/rails/mailers/order_nitifier_mailer
class OrderNitifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_nitifier_mailer/recevied
  def recevied
    OrderNitifierMailer.recevied
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_nitifier_mailer/shipped
  def shipped
    OrderNitifierMailer.shipped
  end

end
