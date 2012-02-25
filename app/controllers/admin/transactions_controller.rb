class Admin::TransactionsController < Admin::BaseController

  def index
    @transactions = current_user.transactions.not_paid_overdue.order(:start_date).page params[:page]
  end

  def paid
    @transactions = current_user.transactions.paid.order(:start_date).page params[:page]
  end

  def new
    @transaction = Transaction.new
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.user = current_user
    @transaction.status = :not_paid.to_s

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to request.referer, notice: 'Yeni Borc Kaydi olusturuldu' }
        format.json { render json: @transaction, status: :created }
      else
        format.js {
          render :template => "admin/shared/form_errors",
                 :locals => {
                     :item => @transaction,
                     :notice => 'Kayit Eklemede Hatalar Olustu'
                 } }
      end
    end
  end

  def update
    @transaction = current_user.transactions.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to request.referer, notice: 'Borc Kaydi guncellendi' }
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
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end


end
