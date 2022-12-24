class Order < ApplicationRecord
    belongs_to :animal
    belongs_to :customer

    validates :end_date, presence: true
end
