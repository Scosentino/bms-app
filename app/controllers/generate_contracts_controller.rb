class GenerateContractsController < ApplicationController
  before_action :authenticate_user!

  def policy
    render pdf: 'policy',
           :margin => { :bottom => 10 },
           :footer => { :html => { :template => 'generate_contracts/footer.html.erb' } }
  end
end