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
    def number_of_reactions (emo_id)
        self.reactions.where(emotion: emo_id).count
    end
    def has_emotion?(u_id, emo_id)
        return false unless Reaction.exists?(timeline_id: self.id, user_id: u_id)
        ! self.reactions.where('user_id=? and emotion=?', u_id, emo_id).empty?
    end
end
