class AddCulumnsToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :name, :string
    add_column :addresses, :postal_code, :string
    add_column :addresses, :address, :string
    add_column :addresses, :customer_id, :integer
  end
end
