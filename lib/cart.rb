class Cart
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS carts (
        id INTEGER PRIMARY KEY,
        customer_id TEXT
      )
    SQL
    DB[:connection].execute(sql)
  end
end
