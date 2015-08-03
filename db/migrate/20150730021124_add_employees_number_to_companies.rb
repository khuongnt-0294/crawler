class AddEmployeesNumberToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :employees_number, :string
  end
end
