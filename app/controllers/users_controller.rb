class UsersController < ApplicationController
  before_action :checkLoggedIn, :except => [:create, :new]
  # Ensure that they are not trying to URL hack
  def new
    @user = User.new
  end

  def show
    # Find the user that is being searched for
    # But first, check to make sure we have permission
   @user = User.find_by_id(params[:id])
   if @user != nil
     if session[:user_id] == @user.id
        flash.now[:notice] = "You don't have access to that order!"
        redirect_to uhome_path
        return
      end
    end
    redirect_to uhome_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.authenticate(:password)
      session[:user_id] = @user.id
      redirect_to uhome_path
    else
      render 'new'
    end
  end

  def home
    @user = User.find(params[:id])
    @friend_user = @user
    @skins = Skin.all
    render 'show'
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to uhome_path
    else
      render 'edit'
    end
  end

  def download
     file_name = params[:feed_image_path].split('/').last
     @filename ="#{Rails.root}/public/uploads/skin/#{file_name}"
     send_file(@filename ,
      :type => 'application/pdf/docx/html/htm/doc',
      :disposition => 'attachment')
  end

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end






