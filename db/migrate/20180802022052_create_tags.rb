class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :job_tags do |t|
      t.references :tag
      t.references :job
      t.timestamps
    end
  end
end
