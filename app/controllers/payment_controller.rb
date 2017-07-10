require 'start'
class PaymentController < ApplicationController
  def create
    base_uri = 'https://helpiy-a9a85.firebaseio.com/orders/'
  firebase = Firebase::Client.new(base_uri)
                      Start.api_key = "test_sec_k_39a2906c4ac3c8eb2ada8"
                      token= params["token"]
                      order_id= params["order_id"]
                      status= "Order Placed"
                      total_amount= params["total_amount"]
                      currency= params["currency"]
                      email=params["email"]
                      ip= params["ip"]
                      description= params["description"]
                      begin
                        payment= Start::Charge.create(
                        :amount => total_amount,
                        :currency => currency,
                        :email => email,
                        :ip => 	ip,
                        :card => token,
                        :description => description
                      )
                        paymentid= payment["id"]
                        response= firebase.update('', {
                            "#{order_id}/status" => status,
                            "#{order_id}/payment/paymentId" => paymentid
                        })

                      render json: paymentid
#                        render json: "success"
                    rescue Start::BankingError => e
                      render json: e
                    rescue Start::RequestError => e
                      render json: e
                    rescue Start::AuthenticationError => e
                      render json: e
                    rescue Start::ProcessingError => e
                      render json: e
                    rescue Start::StartError => e
                      render json: e
                    rescue => e
                      render json: e
                    end

  end
end
