class ChangeTagsToAddOriginalColumn < ActiveRecord::Migration[5.1]
  def change
    change_table :tags do |t|
      t.boolean :original, default: false, nullable: false
    end
  end
end
