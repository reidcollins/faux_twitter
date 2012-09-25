class UsersController < ApplicationController

  before_filter :signed_in_user

  def show
  	#raise params.inspect
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

    if @user.save
      sign_in @user
      #redirect_to user_path(@user)
      flash[:success] = 'Welcome to fauxtwitter!'
      redirect_to @user
    else
  	 render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])   
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def signed_in_user
      flash[:notice] = "Please sign in"
      redirect_to signin_path, :notice => "Please sign in." unless signed_in?
    end
end
