class AddHomePageToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :home_page, :string
  end
end
