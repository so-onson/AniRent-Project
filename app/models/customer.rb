class Customer < ApplicationRecord
    belongs_to :user, dependent: :destroy
    has_many :orders


    def owner? object
        return true if id == object.customer_id
      end
end
