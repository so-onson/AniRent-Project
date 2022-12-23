class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_owner, only: [ :show, :edit, :update ]
  before_action :check_admin, only: [ :index, :destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to session_login_path, notice: "#{t('flash.success.create')}" }
        format.json { render :show, status: :created, location: @user }


        if @user.role == 'custom'
          @custom = Customer.create(user_id: @user.id)

        elsif @user.role == 'manager'
          @manager = Manager.create(user_id: @user.id)
        end
        
      else
        format.html { redirect_to new_user_path, alert: "#{t('flash.error.create')}" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if current_user.admin?
          # unless params[:role].nil?
            if @user.role == 'custom' && Customer.find_by(user_id: @user.id ).nil?
              unless Manager.find_by(user_id: @user.id ).nil?
                Manager.find_by(user_id: @user.id ).destroy
              end
              @custom = Customer.create(user_id: @user.id)

            elsif @user.role == 'manager' && Manager.find_by(user_id: @user.id ).nil?
              unless Customer.find_by(user_id: @user.id ).nil?
                Customer.find_by(user_id: @user.id ).destroy
              end
              @manager = Manager.create(user_id: @user.id)
            end
          # end
          
          format.html { redirect_to users_url(@user), notice: "#{t('flash.success.update')}" }
          
        else
          format.html { redirect_to pages_profile_path, notice: "#{t('flash.success.update')}" }
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    Customer.find_by(user_id:  params[:id]).destroy if (@user.role == 'customer')
    Manager.find_by(user_id:  params[:id]).destroy if (@user.role == 'manager')
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{t('flash.success.destroy')}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :email, :role, :password, :password_confirmation)
    end

   
    def check_owner
      return true if current_user.admin?
      unless current_user.id == @user.id
      # unless current_user.owner?(@custom)
        redirect_to root_path, alert: "#{t('flash.permission')}"
      end
    end

    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "#{t('flash.permission')}"
      end
    end
end
