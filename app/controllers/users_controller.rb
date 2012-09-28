class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    #will_paginate introduces additional method to ActiveRecord
    #takes a number that passed around inside a hash
    # select "users".* FROM "users" LIMIT 30 OFFSET 60
    @users = User.paginate(:page => params[:page])
  end

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
      flash[:success] = 'Welcome to fauxtwitter!'
      redirect_to @user
    else
  	 render 'new'
    end
  end

  def edit
    #now finding user with correct_user method
    #@user = User.find(params[:id])   
  end

  def update
    #now finding user with correct_user method
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private
    def signed_in_user
      #raise signed_in?.inspect
      unless signed_in?
        store_location
        redirect_to signin_path, :notice => "Please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
