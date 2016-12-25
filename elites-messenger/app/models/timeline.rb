class Timeline < ActiveRecord::Base

    belongs_to  :user
    has_many :reactions, dependent: :destroy
    
    has_many    :replies, class_name: 'Timeline', foreign_key: 'reply_id', dependent: :destroy
    validates   :message, presence: true, allow_blank: false, length: {maximum: 140}

    scope :user_filter, -> user_id do
        where(user_id: user_id) if user_id.present?
    end
    scope :not_reply, -> do
        where(reply_id: nil)
    end
    def number_of_reactions (emo)
        self.reactions.where(emotion: Reaction.emotions[emo]).count
    end
end
