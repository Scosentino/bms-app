class GenerateContractsController < ApplicationController
  before_action :authenticate_user!
  layout false

  def policy
    @customer = User.find_by(id: params[:customer_id])
    if params[:type] == 'offer'
      @model = Offer.find_by(id: params[:id])
    elsif params[:type] == 'order'
      @model = Order.find_by(id: params[:id])
    end
    render pdf: 'policy',
           :margin => { :bottom => 10 },
           :footer => { :html => { :template => 'generate_contracts/footer.html.erb' } }
  end

  def merchant_agreement
    render pdf: 'merchant_agreement'#,
           # :margin => { :bottom => 10 },
           # :footer => { :html => { :template => 'generate_contracts/footer.html.erb' } }
  end
end