class Product
  attr_accessor :id, :name, :price

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

  def self.find_by_customer_id(customer_id)
    sql = <<-SQL
      SELECT * FROM products
      INNER JOIN line_items ON line_items.product_id = products.id
      INNER JOIN carts ON line_items.cart_id = carts.id
      INNER JOIN customers ON carts.customer_id = customers.id
      WHERE customers.id = ?
    SQL

    rows = DB[:connection].execute(sql, customer_id)

    Product.reify_from_rows(rows)
  end

  # Has Many
  def customers
    Customer.find_by_product(self)
  end

  def self.find_by_cart_id(cart_id)
    sql = <<-SQL
      SELECT * FROM products
      INNER JOIN line_items ON line_items.product_id = products.id
      INNER JOIN carts ON line_items.cart_id = carts.id
      WHERE carts.id = ?
    SQL

    rows = DB[:connection].execute(sql, cart_id)

    Product.reify_from_rows(rows)
  end

  def self.reify_from_rows(rows)
    rows.collect{|r| reify_from_row(r)}
  end

  def self.reify_from_row(row)
    self.new.tap do |o|
      o.id = row[0]
      o.name = row[1]
      o.price = row[2]
    end
  end
end
