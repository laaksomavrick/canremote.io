class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email, index: true
    end
  
    change_table :jobs do |t|
      t.references :company
    end
  end
end
