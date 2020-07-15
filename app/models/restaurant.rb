class Restaurant < ApplicationRecord
  has_many :dishes
  has_many :opening_hours

  include NameSearchable
end
