class Animal < ApplicationRecord
    has_one :order
    has_one_attached :image
    validates :name, presence: true
    validates :breed, presence: true
end
