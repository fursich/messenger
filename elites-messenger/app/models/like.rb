class Like < ActiveRecord::Base

    belongs_to :timelines
    belongs_to :users

    validates   :reaction, presence: true
end
