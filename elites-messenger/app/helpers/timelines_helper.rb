module TimelinesHelper

    def mypost?(timeline)
        timeline.user.id == current_user.id
    end
    
    def reaction_count(timeline)
        timeline.reactions.count
    end
    def class_by_emotion(emo)
        case emo
        when 'like'
            return "em em-thumbsup like-icon"
        when 'love'
            return "em em-heart love-icon"
        when 'laugh'
            return "em em-laughing laugh-icon"
        when 'wonder'
            return "em em-open_mouth wonder-icon"
        when 'weep'
            return "em em-cry weep-icon"
        when 'anger'
            return "em em-angry anger-icon"
        else
            return "na"
        end
    end

end
