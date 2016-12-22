class Like < ActiveRecord::Base

    belongs_to :timelines
    belongs_to :users

    validates   :reaction, presence: true
    validates   :timeline_id, presence: true
    validates   :user_id, presence: true
end
