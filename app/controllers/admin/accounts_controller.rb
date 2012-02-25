class Admin::AccountsController < Admin::BaseController

  def index
    @user = current_user
  end

  def update
    current_user.email = params[:email]
    current_user.first_time = false
    current_user.save!
    redirect_to admin_root_path, :notice => "Hesap Ayarlariniz Guncellendi" and return
  end
end
