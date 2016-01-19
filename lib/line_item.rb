class LineItem

  def self.create_table
    <<-SQL
      CREATE TABlE lineitems(
        id INTEGER PRIMARY KEY,
        cart_id INTEGER,
        product_id INTEGER
      )
    SQL
  end
end
