class User < ActiveRecord::Base
    
    has_many :pantry_ingredients
    has_many :ingredients, through: :pantry_ingredients
    has_many :favorite_recipes
    
    
    def self.find_user(user_name)
        User.all.find_by(name: user_name)
      end

    def pantry
      self.pantry_ingredients.map {|pantry_ingredient| pantry_ingredient.ingredient}      
    end

    def pantry_names
      pantry.map {|ing| ing.name}
    end

    def fav_recipe_names
      self.favorite_recipes.map {|fav| fav.name}
    end

    def fav_recipe_id
      self.favorite_recipes.map {|fav| fav.recipe_id}
    end


    def create_pantry_ingredients
      ing = ingredient_prompt
     found_ingredient = Ingredient.all.find {|i| i.name == ing}   
     if found_ingredient == nil
       new_ingredient = Ingredient.create(name: ing)
       PantryIngredient.create(ingredient_id: new_ingredient.id, user_id: self.id)
     else
       PantryIngredient.create(ingredient_id: found_ingredient.id, user_id: self.id)
     end  
     
    end

end