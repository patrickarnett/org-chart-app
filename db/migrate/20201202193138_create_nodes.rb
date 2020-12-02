class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.references :parent
      t.text :job_title
      t.text :first_name
      t.text :last_name
      t.boolean :root
      t.timestamps
    end
  end
end
