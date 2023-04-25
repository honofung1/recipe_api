class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :update]

  def index
    recipes = Recipe.order(id: :asc)
    render json: {recipes: recipes }
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { message: "Recipe successfully created!", recipe: [recipe] }
    else
      render json: { message: "Recipe creation failed!", required: "title, making_time, serves, ingredients, cost" }
    end
  end

  def show
    render json: { message: "Recipe details by id", recipe: [@recipe] }
  end

  def update
    if @recipe.update(recipe_params)
      render json: { message: "Recipe successfully updated!", recipe: [@recipe] }
    else
      render json: { message: "Recipe updated failed!", recipe: [@recipe] }
    end
  end

  def destroy
    begin
      recipe = Recipe.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { message: "No Recipe found"}
    end

    if recipe.destroy
      render json: { message: "Recipe successfully removed!"}
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :making_time, :serves, :ingredients, :cost)
  end
end
