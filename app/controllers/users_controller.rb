class UsersController < ApplicationController
  def new
   @user = User.new
  end

 def create
  @user = User.new(params[:user])
  if !@user.avatar
   @user.avatar="/images/1.jpg"
  end
  if @user.save
    redirect_to log_in_url, :notice => "Signed up!"
  else
    render "new"
  end
 end
 
 def show
    @user = User.find(params[:id])
    @title = @user.email
 end
 
 def update
  @user=User.find(session[:user_id]) if session[:user_id]
  @user.update_attributes(params[:user])
  redirect_to user_path
 end
 
 def private_office
  @user=current_user
 end
 
 def destroy
   User.find(params[:id]).destroy
   flash[:success] = "User destroyed."
   session[:user_id] = nil
   redirect_to root_url
 end 

end
