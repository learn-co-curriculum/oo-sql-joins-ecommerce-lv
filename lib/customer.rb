class Customer
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS customers (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    SQL
    DB[:connection].execute(sql)
  end

end
