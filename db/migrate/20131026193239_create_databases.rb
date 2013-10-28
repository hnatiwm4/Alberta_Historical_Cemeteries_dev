class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|

      t.timestamps
    end
  end
end
