module TimelinesHelper

    def mypost?(timeline)
        timeline.user.id == current_user.id
    end
    
    def reaction_count(timeline)
        timeline.reactions.count
    end
    
    def emotion_count(timeline, emotion)
        timeline.reactions.where("emotion = ?", Reaction.emotions[emotion]).count
    end
end
