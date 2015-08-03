class AddInexperienceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :inexperience, :tinyint
  end
end
