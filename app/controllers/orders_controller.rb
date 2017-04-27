class OrdersController < ApplicationController

  def show
    p "params id: ", params[:id]
# params[:id] is the ORDER # in the params ( which will always be the new id for a new order)
    @order = Order.find(params[:id])
    # p "thisis variable order: ", @order
    p "this is ordder.line items:", @order.line_items
    @order_total = 0
    p "inject method: ", @order.line_items.each { |line_item| @order_total += line_item.total_price_cents  }
    # p "order total is: >>>", @order_total
# initial value goes im value like   array.reduce("here")
# sum saves the value in loop for the next iteration, adds next value to it
    p "The other orde total is >>>>>>>", @order.line_items.reduce(0) { |sum, line_item| sum + line_item.total_price_cents}
    # @order.line_items.reduce(@quantity_total) { |sum, quantity| @quantity_total = sum + quantity.quantity }

  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, error: order.errors.full_messages.first
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, error: e.message
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: current_user.email,
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end
    order.save!
    order
  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
