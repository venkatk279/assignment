class Tweet < ApplicationRecord
    belongs_to :user
    scope :following, ->(followers) { where user_id: followers }
end
