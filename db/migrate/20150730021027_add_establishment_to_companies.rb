class AddEstablishmentToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :establishment, :string
  end
end
