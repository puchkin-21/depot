class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.order(:name)
    respond_to do |format|
      format.html  # index.html.erb
      format.json { render json: @user }
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "Пользователь #{@user.name} успешно создан." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(params[:user])
        format.html { redirect_to users_url, notice: "Сведения о пользователе #{@user.name} успешно обновлены." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "Пользователь #{@user.name}удалён"
    rescue Exception => e
      flash[:notice] = e.message  
    end
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password)
    end

end