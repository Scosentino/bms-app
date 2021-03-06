class WizardsController < ApplicationController
  before_action :non_authorized_user!
  before_action :load_user_wizard, except: %i(validate_step)

  def validate_step
    current_step = params[:current_step]

    @user_wizard = wizard_user_for_step(current_step)
    @user_wizard.user.attributes = user_wizard_params
    session[:user_attributes] = @user_wizard.user.attributes

    case current_step
      when 'step1'
        step_validation_1(current_step)
      when 'step2'
        step_validation_2(current_step)
      when 'step3'
        step_validation_3(current_step)
      when 'step4'
        step_validation_4(current_step)
      when 'step5'
        step_validation_5(current_step)
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        if @user_wizard.user.save
          if @user_wizard.user.business.present?
            business = @user_wizard.user.business
          else
            business = Business.new(session[:business_attributes].compact.merge({customer_id: @user_wizard.user.id}))
          end
          if business.save
            if @user_wizard.user.payment_method.present?
              payment = @user_wizard.user.payment_method
            else
              payment = PaymentMethod.new(session[:payment_method_attributes].compact.merge({customer_id: @user_wizard.user.id}))
            end
            if payment.save
              if save_order(business.id)
                @user_wizard.user.update!(completed: true)
                sign_in(@user_wizard.user)
                session[:user_attributes] = nil
                session[:payment_method_attributes] = nil
                session[:business_attributes] = nil
                session[:order_attributes] = nil
                session[:order_attributes_image] = nil
              else
                raise('There were a problem when creating the order.')
              end
            else
              raise('There were a problem when creating the payment method.')
            end
          else
            raise('There were a problem when creating the business.')
          end
        else
          raise('There were a problem when creating the user.')
        end
      end
    rescue Exception => e
      flash[:alert] = e if e.to_s.scan(/reject/).blank?
      redirect_to action: Wizard::User::STEPS.first
    end
  end

  private

  def save_order business_id
    order = @user_wizard.user.orders.first
    order.business_id = business_id
    if order.update(session[:order_attributes].compact.merge(
        accepted_at: Time.now, customer_name: @user_wizard.user.full_name,
        completed: true))

      return true
    else
      false
    end
  end

  def step_validation_1 current_step
    @order_wizard = wizard_order
    @order_wizard.order.attributes = order_wizard_params
    session[:order_attributes] = @order_wizard.order.attributes

    check_user_validation(@order_wizard, current_step)
  end

  def step_validation_2 current_step
    @business_wizard = wizard_business
    @business_wizard.business.attributes = business_wizard_params
    session[:business_attributes] = @business_wizard.business.attributes

    check_user_validation(@business_wizard, current_step)
  end

  def step_validation_3 current_step
    if @user_wizard.user.save
      next_step = wizard_user_next_step(current_step)
      create and return unless next_step

      redirect_to action: next_step
    else
      render current_step
    end
  end

  def step_validation_4 current_step
    @payment_method_wizard = wizard_payment_method
    @payment_method_wizard.payment_method.attributes = payment_method_wizard_params
    session[:payment_method_attributes] = @payment_method_wizard.payment_method.attributes

    check_user_validation(@payment_method_wizard, current_step)
  end

  def check_user_validation model, current_step
    if model.valid?
      next_step = wizard_user_next_step(current_step)
      if current_step == 'step1'
        save_user_and_order(current_step, model, next_step)
      else
        create and return unless next_step

        redirect_to action: next_step
      end
    else
      render current_step
    end
  end

  def step_validation_5 current_step
    @order_wizard = wizard_order_acceptance
    @order_wizard.order.attributes = order_wizard_params
    session[:order_attributes] = @order_wizard.order.attributes

    check_user_validation(@order_wizard, current_step)
  end

  def save_user_and_order current_step, model, next_step
    begin
      ActiveRecord::Base.transaction do
        if @user_wizard.user.password.present? && @user_wizard.user.password_confirmation.present? &&
            @user_wizard.user.password == @user_wizard.user.password_confirmation
          if @user_wizard.user.save(validate: false)
            model.order.customer_id = @user_wizard.user.id
            if model.order.save
              redirect_to action: next_step
            else
              flash[:alert] = model.order.errors.full_messages.first
              render current_step
            end
          else
            render current_step
          end
        else
          flash[:alert] = 'Password should present'
          render current_step
        end
      end
    rescue Exception => e
      render current_step
    end
  end

  def load_user_wizard
    @user_wizard = wizard_user_for_step(action_name)
    @order_wizard = wizard_order
    @business_wizard = wizard_business
    @payment_method_wizard = wizard_payment_method
  end

  def wizard_user_next_step(step)
    Wizard::User::STEPS[Wizard::User::STEPS.index(step) + 1]
  end

  def wizard_user_for_step(step)
    raise InvalidStep unless step.in?(Wizard::User::STEPS)

    "Wizard::User::#{step.camelize}".constantize.new(session[:user_attributes])
  end

  def wizard_order
    Wizard::Order::Validate.new(session[:order_attributes])
  end

  def wizard_order_acceptance
    Wizard::Order::Acceptance.new(session[:order_attributes])
  end

  def wizard_business
    Wizard::Business::Validate.new(session[:business_attributes])
  end

  def wizard_payment_method
    Wizard::PaymentMethod::Validate.new(session[:payment_method_attributes])
  end

  def user_wizard_params
    params.require(:user_wizard).permit(
        :email, :first_name, :last_name, :password, :password_confirmation,
        :phone_number, :ssn, :job_title)
  end

  def order_wizard_params
    params[:user_wizard][:orders].present? ? params[:user_wizard][:orders].permit(:accepted_policy, {documents: []}) : {}
  end

  def business_wizard_params
    if params[:user_wizard][:business].present?
      params[:user_wizard][:business].permit(
          :legal_name, :address_line_1, :city, :state, :zipcode, :federal_tax_id, :name_of_credit_card_processor,
          :years_processor, :merchant_id_number, :dba, :address_line_2
      )
    else
      {}
    end
  end

  def payment_method_wizard_params
    if params[:user_wizard][:payment_method].present?
      params[:user_wizard][:payment_method].permit(
          :card_number, :security_code, :zipcode, :bank_account_number, :bank_account_routing_number, :payment_type,
          :bank_name, :year_ended, :month_ended
      )
    else
      {}
    end
  end

  class InvalidStep < StandardError; end
end