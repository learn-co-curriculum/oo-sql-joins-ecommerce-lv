class Customer
  attr_accessor :id, :name

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS customers (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    SQL
    DB[:connection].execute(sql)
  end

  def self.find_by_product(product_id)
    sql = <<-SQL
      SELECT * FROM customers
      INNER JOIN carts ON carts.customer_id = customers.id
      INNER JOIN line_items ON line_items.cart_id = carts.id
      INNER JOIN products ON line_items.product_id = products.id
      WHERE products.id = ?
    SQL

    rows = DB[:connection].execute(sql, product_id)

    Customer.reify_from_rows(rows)
  end

  def self.reify_from_rows(rows)
    rows.collect{|r| reify_from_row(r)}
  end

  def self.reify_from_row(row)
    self.new.tap do |o|
      o.id = row[0]
      o.name = row[1]
    end
  end
end
