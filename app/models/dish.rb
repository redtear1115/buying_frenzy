class Dish < ApplicationRecord
  belongs_to :restaurant

  include NameSearchable  
end
