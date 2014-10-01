class UsersController < BaseController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :authorize_user, :except => [:new, :create]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to :root , flash: { success: "User was successfully created" }
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :root , :flash => { :success => "User was successfully updated" }
    else
      render action: "edit"
    end
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to :root , :flash => { :success => "User was successfully deleted" }
  # end

  private

  def authorize_user
    if not current_user == User.find(params[:id])
      redirect_to :root, :flash => { :error => "You do not have permissions to this action" }
    end
  end

  def user_params
    params.require(:user).permit(:email, :fullname, :password, :password_confirmation)
  end
end
