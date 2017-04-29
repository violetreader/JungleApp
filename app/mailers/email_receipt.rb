class EmailReceipt < ApplicationMailer
	default from: 'no-reply@jungle.com'

	def mailer(order)
		@order = order
		@total = "$#{(@order.total_cents.to_f / 100).round(2).to_s}"
		mail(to: @order.email, 
			subject: "Welcome - #{@order.id}")
	end 
end
