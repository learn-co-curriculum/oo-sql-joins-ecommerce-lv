class Product
  def self.create_table
    <<-SQL
      CREATE TABlE products(
        id INTEGER PRIMARY KEY,
        name STRING,
        price INTEGER
      )
    SQL
  end
end
