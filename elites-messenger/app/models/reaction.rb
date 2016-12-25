class Reaction < ActiveRecord::Base

    belongs_to :timelines
    belongs_to :users

    enum emotion: {like: 0, love: 1, laugh: 2, wonder: 3, weep: 4, anger: 5}
    validates   :emotion, presence: true
    validates   :timeline_id, presence: true
    validates   :user_id, presence: true


end

