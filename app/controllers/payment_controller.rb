require 'start'
class PaymentController < ApplicationController
  def create
    render json: "Payment Create Function"
  end
end
