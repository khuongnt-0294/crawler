class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :workplace
      t.string :business_category
      t.string :job_category
      t.text :content
      t.text :requirement
      t.text :work_time
      t.text :salary
      t.text :holiday
      t.text :treatment
      t.string :capture_path
      t.text :raw_html
      t.text :url

      t.references :company, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobs, :companies
  end
end
