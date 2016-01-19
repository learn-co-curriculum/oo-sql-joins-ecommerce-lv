class LineItem

  def self.create_table
    sql = <<-SQL
      CREATE TABlE lineitems(
        id INTEGER PRIMARY KEY,
        cart_id INTEGER,
        product_id INTEGER
      )
    SQL
    DB[:connection].execute(sql)
  end
end
