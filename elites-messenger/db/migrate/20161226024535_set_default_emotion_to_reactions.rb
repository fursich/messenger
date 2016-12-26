class SetDefaultEmotionToReactions < ActiveRecord::Migration
  def change
    change_column_default :reactions, :emotion, 0
  end
end
