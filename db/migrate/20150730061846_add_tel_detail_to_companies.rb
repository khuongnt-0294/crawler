class AddTelDetailToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tel_detail, :text
  end
end
