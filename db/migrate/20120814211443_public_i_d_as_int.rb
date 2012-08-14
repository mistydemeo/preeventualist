class PublicIDAsInt < ActiveRecord::Migration
  def up
    execute <<-EOSQL
    ALTER TABLE items
      ALTER COLUMN public_id
      TYPE int
      USING public_id::int
    EOSQL
  end

  def down
    execute <<-EOSQL
    ALTER TABLE items
      ALTER COLUMN public_id
      TYPE text
      USING public_id::char
    EOSQL
  end
end
