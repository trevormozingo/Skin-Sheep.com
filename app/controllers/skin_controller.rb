class SkinController < ApplicationController
  before_action :checkLoggedIn

  def index
    @skins = Skin.all
  end

  def new
    @skin = Skin.new
  end

  def create
    @skin = Skin.new(skin_params)
    if !@skin.present?
      render 'new'
    else
      if @skin.save
        redirect_to uhome_path
      else
        render 'new'
      end
    end
  end

  def edit
    @skin = current_user.skins.find_by(id: params[:id])
  end

  def update
     @skin = current_user.skins.find(params[:id])
      if @skin.update(skin_params)
        redirect_to uhome_path
      else
        render 'edit'
      end
  end

  def destroy
    @skin = current_user.skins.find(params[:id])
    @skin.destroy
    redirect_to uhome_path
  end

  def download
        @skin = Skin.find(params[:id])
        send_file("#{Rails.root}/public" + @skin.attachment.to_s,
              :disposition => 'attachment',
              :url_based_filename => false)
  end

  private
    def skin_params
    params.require(:skin).permit(:name, :description, :attachment, :user_id, :visibility)
  end
end
