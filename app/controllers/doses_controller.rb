class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.ingredient = Ingredient.find(dose_params["ingredient_id"].to_i)
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    if @dose.save
      redirect_to Cocktail.find(params[:cocktail_id])
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private
  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end
