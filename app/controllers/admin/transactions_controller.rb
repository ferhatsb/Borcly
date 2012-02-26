class Admin::TransactionsController < Admin::BaseController

  def index
    @transactions = current_user.transactions.not_paid.order(:start_date).page params[:page]
  end

  def paid
    @transactions = current_user.transactions.paid.order(:start_date).page params[:page]
  end

  def overdue
    @transactions = current_user.transactions.overdue.order(:start_date).page params[:page]
  end

  def new
    @transaction = Transaction.new
    respond_to do |format|
      format.html
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.user = current_user
    @transaction.status = :not_paid.to_s

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admin_transactions_url, notice: 'Yeni Borc Kaydi olusturuldu' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @transaction = current_user.transactions.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to [:admin, @transaction], notice: 'Borc Kaydi guncellendi' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to @transaction }
      format.json { head :no_content }
    end
  end


  def broadcast
    @transaction = current_user.transactions.find(params[:id])

    respond_to do |format|
      if @transaction.broadcast()
        format.html { redirect_to overdue_admin_transactions_url, notice: 'Sosyal aglarinizda borclu duyurusu yapildi' }
      else
        format.html { redirect_to overdue_admin_transactions_url, error: 'Sosyal baglantilarinizda sorun yasandi' }
      end
    end
  end

  #check user's debit history
  def check
    email = params[:email]
    result = !Transaction.user_credited_before_and_not_paid?(email).nil?
    render :text =>  result.to_s
  end

end
