class AddSalesToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sales, :string
  end
end
