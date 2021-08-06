class CollectionsController < ApplicationController

  def new
    render 'form'
  end

  def create
    resource_params = params[:collection].permit!
    resource_params[:invoice_id] = params[:id].to_i
    @collection = Collection.new(resource_params)
    respond_to do |format|   
      if @collection.valid?
        @collection.save
        flash.notice = 'Collection was successfully created.'
        format.html { redirect_to invoices_url }   
      else
        format.html { render :form }   
        format.json { render json: @collection.errors, status: :unprocessable_entity }   
      end   
    end
  end

end