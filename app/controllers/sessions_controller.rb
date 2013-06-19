class SessionsController < BaseController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/events", :flash => { :success => "Logged in!" }
    else
      flash[:error] = "Invalid email or password"
      render action: "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/events", :flash => { :success => "Logged out!" }
  end
end
