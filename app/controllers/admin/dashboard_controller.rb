class Admin::DashboardController < Admin::BaseController

  def index
     @transactions = Transaction.all
  end

end
