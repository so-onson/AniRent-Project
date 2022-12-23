class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy receive ]
  before_action :check_role
  before_action :check_owner, only: [ :show, :edit, :update ]
  before_action :check_custom, only: [ :new, :create ]

  # GET /orders
  def index
    if current_user.manager? || current_user.admin?
      @orders = Order.all
    elsif current_user.custom?
      @orders = Order.where(customer_id: current_cus.id)#.order(end_date: :desc) #Person.where(name: 'Spartacus', rating: 4)
      if @orders.nil?
        redirect_to root_path
      end
    else redirect_to root_path
    end
  end

  # GET /orders/1
  def show
    @time_left = @order.end_date.day - Time.now.day  
    
    if  @order.end_date.hour > Time.now.hour
      @hour_left = @order.end_date.hour - Time.now.hour
    else
      @hour_left = 24 - Time.now.hour + @order.end_date.hour
    end    
  end

  # GET /orders/new
  def new
    @animal_id = params[:animal_id]
    # if Order.find_by(animal_id: params[:animal_id]).nil?
    unless Animal.find_by(id: @animal_id).in_order
      @arr = []
      i = 0
      5.times do
        i += 1
        # @arr.push(Time.now.change(day:Time.now.day+i).to_formatted_s(:short)) 
        @arr.push(Time.now.change(day:Time.now.day+i).to_formatted_s(:short))
      end 
      @order = Order.new
    else
      redirect_to animals_path, notice: "#{t('flash.reserved')}"
    end
  end

  # GET /orders/1/edit
  def edit
    @arr = []
      i = 0
      5.times do
        i += 1
        @arr.push(Time.now.change(day:Time.now.day+i).to_formatted_s(:short)) 
      end
  end

  # POST /orders
  def create
      ani = params[:animal_id].to_i
      @animal = Animal.find_by(id: ani)
      @animal.update(in_order: true)
      @order = Order.create(customer_id: current_cus.id, animal_id: params[:animal_id], end_date: params[:end_date])

      respond_to do |format|
        if @order.save
          format.html { redirect_to order_url(@order), notice: "#{t('flash.success.create')}" }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    
  end

  def receive
    @ani = Animal.find_by(id: @order.animal_id)
    respond_to do |format|
      if @ani.update(in_order: false)
        format.html { redirect_to orders_index_path, notice: "#{t('flash.success.update')}" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    respond_to do |format|
      if @order.update(end_date: params[:end_date])
        format.html { redirect_to order_url(@order), notice: "#{t('flash.success.update')}" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    Animal.find_by(id: @order.animal_id).update(in_order: false)
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_index_path, notice: "#{t('flash.success.destroy')}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def check_owner
      return true if current_user.manager? || current_user.admin?
      unless current_cus.owner?(@order)
        redirect_to root_path, alert: "#{t('flash.owner')}"
      end
    end

    def check_custom
      # return true if current_user.admin?
      if current_user.manager?
        redirect_to animals_path, alert: "#{t('flash.permission')}"
      end
    end

end

