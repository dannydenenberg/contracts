# Allow the use of UUIDs in the PostgreSQL Models.
class EnableUuid < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
  end
end
