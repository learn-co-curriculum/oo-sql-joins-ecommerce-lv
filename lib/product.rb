class Product
  def self.create_table
    sql = <<-SQL
      CREATE TABlE IF NOT EXISTS products(
        id INTEGER PRIMARY KEY,
        name STRING,
        price INTEGER
      )
    SQL
    DB[:connection].execute(sql)
  end

  def customers
    Customer.find_by_product(self)
  end

end
