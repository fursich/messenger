class Reaction < ActiveRecord::Base

    belongs_to :timelines
    belongs_to :users

    enum emotion: {na: 0, like: 1, love: 2, laugh: 3, wonder: 4, weep: 5, anger: 6}
    validates   :emotion, presence: true
    validates   :timeline_id, presence: true
    validates   :user_id, presence: true

end

