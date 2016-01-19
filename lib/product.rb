class Product
  def self.create_table
    sql = <<-SQL
      CREATE TABlE products(
        id INTEGER PRIMARY KEY,
        name STRING,
        price INTEGER
      )
    SQL
    DB[:connection].execute(sql)
  end
end
