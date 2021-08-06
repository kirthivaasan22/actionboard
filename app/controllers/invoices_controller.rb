class InvoicesController < ApplicationController

  before_action do
    @model = params['controller'].classify.constantize
  end

  def index
    @q = @model.ransack(params[:q])
    @invoices = @q.result(distinct: true).page(params[:page] || 1)
    @invoices = @invoices.where("balance_due > ?", 0) if params[:constraints].eql?("pending_bills")
    @invoices = @invoices.where("balance_due = ?", 0) if params[:constraints].eql?("collected_bills")
  end

  def new
    render 'form'
  end

  def create   
    resource_params = params[:invoice].permit!
    resource_params[:balance_due] = resource_params[:amount]
    @invoice = Invoice.new(resource_params)
    respond_to do |format|   
      if @invoice.valid?
        @invoice.save
        flash.notice = 'Invoice was successfully created.'
        format.html { redirect_to invoices_url }   
      else
        format.html { render :form }   
        format.json { render json: @invoice.errors, status: :unprocessable_entity }   
      end   
    end   
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @collections = @invoice.collections
    render 'edit'
  end

end