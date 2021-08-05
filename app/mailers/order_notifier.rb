class OrderNotifier < ApplicationMailer
  default from: 'Store <noreply@store.com>'

  def recevied
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def recevied(order)
    @order = order
    mail to: order.email, subject: 'Access order in shop'
  end

end