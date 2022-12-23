class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy ]
  before_action :check_role, except: [ :index, :show, :clear ]
  before_action :check_permission, except: [ :index, :show, :clear ]
  before_action :initialize_search, only: :index

  # GET /animals or /animals.json
  def index
    @animals = Animal.all
    initialize_search
    handle_search_name
    handle_filters
  end

  def clear
    # clear_session(:search_name, :filter_name, :filter)
    session.delete(:search_name)
    session.delete(:filter_name)
    session.delete(:filter)
    redirect_to animals_path
  end

  # GET /animals/1 or /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals or /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to animal_url(@animal), notice: "#{t('flash.success.create')}" }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1 or /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to animal_url(@animal), notice: "#{t('flash.success.update')}" }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1 or /animals/1.json
  def destroy
    @animal.destroy

    respond_to do |format|
      format.html { redirect_to animals_url, notice: "#{t('flash.success.destroy')}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :breed, :description, :image)
    end

    def check_permission 
      if current_user.custom?
        redirect_to root_path, notice: "#{t('flash.permission')}"
      end
    end

    def initialize_search
      @breeds = Animal.select(:breed).distinct
      @animals = Animal.all
      session[:search_name] ||= params[:search_name]
      session[:filter] = params[:filter]
      params[:filter_option] = nil if params[:filter_option] == ""
      session[:filter_option] = params[:filter_option]
    end
    
    def handle_search_name
      if session[:search_name]
        @animals = Animal.where("name LIKE ?", "%#{session[:search_name].titleize}%").order(:name)
        @breeds = @breeds.where(breed: @animals.pluck(:breed))
      else
        @animals = Animal.all.order(:name)
      end
    end
  
    def handle_filters
      if session[:filter_option] && session[:filter] == "breed"
         @animals = @animals.where(breed: session[:filter_option])
      end
    end

end
