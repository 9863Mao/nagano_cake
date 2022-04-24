class AddUnsubscribeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_unsubscribe, :boolean, default:false
  end
end
