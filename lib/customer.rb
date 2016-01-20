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

  def self.find_by_product_id(product_id)
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

  def self.most_valuable
    # Cart.all.sort_by{|c| c.total_price}.last
    sql = <<-SQL
      SELECT customers.*, SUM(products.price) as total_price
      FROM products
      INNER JOIN line_items ON products.id = line_items.product_id
      INNER JOIN carts ON carts.id = line_items.cart_id
      INNER JOIN customers ON customers.id = carts.customer_id
      GROUP BY customers.id
      ORDER BY total_price DESC
    SQL
    rows = DB[:connection].execute(sql)

    Customer.reify_from_row(rows.first)
  end

  def total_value
    products.collect{|p| p.price}.inject(:+)
  end

  def products
    Product.find_by_customer_id(self.id)
  end

  def self.find(id)
    sql = <<-SQL
      SELECT * FROM customers WHERE id = ?
    SQL

    rows = DB[:connection].execute(sql, id)

    Customer.reify_from_rows(rows)
  end
end
