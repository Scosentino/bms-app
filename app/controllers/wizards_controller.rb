class WizardsController < ApplicationController
  before_action :load_user_wizard, except: %i(validate_step)

  def validate_step
    current_step = params[:current_step]

    @user_wizard = wizard_user_for_step(current_step)
    @user_wizard.user.attributes = user_wizard_params
    session[:user_attributes] = @user_wizard.user.attributes

    if current_step == 'step1'
      @order_wizard = wizard_order
      @order_wizard.order.attributes = order_wizard_params
      session[:order_attributes] = @order_wizard.order.attributes
    end

    if current_step == 'step2'
      @order_wizard = wizard_order
      @order_wizard.order.attributes = order_wizard_params
      session[:order_attributes] = @order_wizard.order.attributes
    end

    if @order_wizard.valid?
      if @user_wizard.valid?
        next_step = wizard_user_next_step(current_step)
        create and return unless next_step

        redirect_to action: next_step
      else
        render current_step
      end
    else
      render current_step
    end
  end

  def create
    if @user_wizard.user.save
      session[:user_attributes] = nil
      redirect_to root_path, notice: 'User successfully created!'
    else
      redirect_to({ action: Wizard::User::STEPS.first }, alert: 'There were a problem when creating the user.')
    end
  end

  private

  def load_user_wizard
    @user_wizard = wizard_user_for_step(action_name)
  end

  def wizard_user_next_step(step)
    Wizard::User::STEPS[Wizard::User::STEPS.index(step) + 1]
  end

  def wizard_user_for_step(step)
    raise InvalidStep unless step.in?(Wizard::User::STEPS)

    "Wizard::User::#{step.camelize}".constantize.new(session[:user_attributes])
  end

  def wizard_order
    raise InvalidStep unless 'step1'.in?(Wizard::User::STEPS)

    Wizard::Order::Validate.new(session[:order_attributes])
  end

  def user_wizard_params
    params.require(:user_wizard).permit(
        :email, :first_name, :last_name, :password, :password_confirmation,
        :phone_number, :ssn, :provided_account_pin, order: [{documents: []}])
  end

  def order_wizard_params
    params[:user_wizard][:order].present? ? params[:user_wizard][:order].permit({documents: []}) : {}
  end

  class InvalidStep < StandardError; end
end