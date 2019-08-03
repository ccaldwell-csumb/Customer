class CustomerController < ApplicationController



  def create
    @customer = Customer.create(customer_params)
    @customer.lastOrder = 0
    @customer.lastOrder2 = 0
    @customer.lastOrder3 = 0
    @customer.award = 0

    if @customer.save
      render json: @customer, status: 201
    else
      render json: @customer.errors, status: 400
    end
  end






  def show
    
    key = 'id'
    if params.key?("email")
      key = 'email'
    end
    
    @customer = Customer.where("#{key} = '#{params[key]}'").first

    if @customer
      render json: @customer, status: 200
    else
      head 404
    end

  end






  def order
    unless params.key?('customerId') && params.key?('price')
      head 400
      return
    end

    @customer = Customer.find(params['customerId'])

    unless (@customer)
      head 400
      return
    end

    if !@customer.award.nil? && @customer.award > 0
      @customer.lastOrder = 0
      @customer.lastOrder2 = 0
      @customer.lastOrder3 = 0
      @customer.award = 0
    elsif !@customer.lastOrder
      @customer.lastOrder = params['price']
    elsif !@customer.lastOrder2
      @customer.lastOrder2 = params['price']
    elsif !@customer.lastOrder3
      @customer.lastOrder3 = params['price']
      @customer.award = (@customer.lastOrder + @customer.lastOrder2 + @customer.lastOrder3) / 3 * 0.1
    end

    @customer.save

    head 204
  end







  private

  def customer_params
    params.permit(:email, :firstName, :lastName)
  end

  def select_without(columns)
    select(column_names - columns.map(&:to_s))
  end

end
