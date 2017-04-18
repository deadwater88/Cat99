class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      #redirect_to cat_rental_requests_url(@cat_rental_request)
      render text: "sucess!"
    else
      render :new
    end
  end

  def update
    rental = CatRentalRequest.find_by(id: params[:id])
    if params[:status] == 'APPROVED'
      rental.approve!
    elsif params[:status] == 'DENIED'
      rental.deny!
    else
      fail
    end
    # render text: "Request #{params[:status]}!!!!"
    @cat = rental.cat
    redirect_to cat_url(@cat)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end

end
