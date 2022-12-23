class Order < ApplicationRecord
    belongs_to :animal
    belongs_to :customer
end
