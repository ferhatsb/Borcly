class Admin::TransactionsController < Admin::BaseController

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

    respond_to do |format|
      if @transaction.save
        #format.html { redirect_to @transaction, notice: 'Yeni kayit olusturuldu' }
        format.json { render json: @transaction, status: :created }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, notice: 'Kayit guncellendi olusturuldu' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bubuos/1
  # DELETE /bubuos/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      #format.html { redirect_to bubuos_url }
      format.json { head :no_content }
    end
  end


end
