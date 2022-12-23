class Manager < ApplicationRecord
    belongs_to :user, dependent: :destroy
end
