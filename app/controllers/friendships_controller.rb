class FriendshipsController < ApplicationController
	before_action :checkLoggedIn

	def new
		@friendship = Friendship.new
	end

	def show
		@user = User.find_by(id: params[:id])
		render 'show'
		#unless session[:user_id] == @user.id
		#	flash[:notice] = "No"
		#	redirect_to uhome_path
		#	return
		#end
	end

	def create
		@user = User.find_by(email: params[:q])
		if !@user.present?
			flash[:notice] = "Unable to add friend."
	    	redirect_to uhome_path
	 	else
			if (current_user.id != @user.id)
		  		@friendship = current_user.friendships.build(:friend_id => @user.id)
			end
			if !@friendship.present?
				flash[:notice] = "Unable to add friend."
	    		redirect_to uhome_path
	 		else
				if @friendship.save
			    	flash[:notice] = "Added friend."
			    	redirect_to uhome_path
			  	else
			    	flash[:notice] = "Unable to add friend."
			    	redirect_to uhome_path
			 	end
			 end
		 end
	end

	def destroy
	  @friendship = current_user.friendships.find(params[:id])
	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to uhome_path
	end

end













