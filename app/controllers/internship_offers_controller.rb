# frozen_string_literal: true

# :nocov:
# Offers for Internship Positions
class InternshipOffersController < ApplicationResourceController
  def index
    @offers = InternshipOffer.where(active: true)
  end

  def show
    @offer = InternshipOffer.find(params[:id])
  end

  # TBD there is no update, but an edit.
  def edit
    @offer = InternshipOffer.find(params[:id])
  end

  def new
    @offer_new = InternshipOffer.new
  end

  def create
    @offer = InternshipOffer.new(internship_offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer }
      #    format.json { render json: @offer,
      #      status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        #    format.json { render json: @offer.errors,
        #      status: :unprocessable_entity }
      end
    end
  end

  def internship_offer_params
    params.require(:internship_offer).permit(permitted_params)
  end

  def self.permitted_params
    %i[title body pdf city country active]
  end
end
# :nocov:
