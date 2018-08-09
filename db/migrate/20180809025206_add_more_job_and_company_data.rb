class AddMoreJobAndCompanyData < ActiveRecord::Migration[5.1]
  def change
    change_table :jobs do |t|
      t.string :url
      t.boolean :highlight, default: false
    end
    change_table :companies do |t|
      t.string :url
      t.text :description
    end
    create_table :pictures do |t|
      t.string :name
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
