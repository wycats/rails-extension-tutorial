class InfoController < ApplicationController
  #START:who_bought
  def who_bought
    @product = Product.find(params[:id])
    @orders  = @product.orders
    respond_to do |format|
      format.html
      format.xml { render :layout => false }
    end
  end
  #END:who_bought

protected

  def authorize
  end
end
