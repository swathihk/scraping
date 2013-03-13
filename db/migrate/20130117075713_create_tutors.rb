class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :site_id
      t.string :name
      t.text :location
      t.text :skills
      t.text :about_us
      t.integer :experience
      t.integer :rating
      t.timestamps
    end
  end
end
