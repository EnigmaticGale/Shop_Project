require_relative('../db/sql_runner')
require_relative('supplier.rb')

class Product

  attr_accessor :name , :description , :stock , :price , :sell_price , :supplier_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @description = options['description']
    @stock = options['stock'].to_i
    @price = options['price'].to_f
    @sell_price = options['sell_price'].to_f
    @supplier_id = options['supplier_id'].to_i if options['supplier_id']
  end

  def supplier
    if @supplier_id != nil
      sql = "SELECT * FROM suppliers WHERE id = $1"
      values = [@supplier_id]
      result = SqlRunner.run(sql, values)
      supplier = Supplier.new(result.first)
      return supplier
    else
      empty_supplier = Supplier.new({
        'company_name' => 'N/A',
        'company_description' => 'N/A',
        'contact_number' => 'N/A'})
      return empty_supplier
    end
  end

  def save()
    sql = "INSERT INTO products(name,description,stock,price,sell_price,supplier_id)
    VALUES($1, $2, $3, $4, $5, $6)
    RETURNING id"
    values = [@name,@description,@stock,@price,@sell_price,@supplier_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def self.delete_all()
    sql = "DELETE FROM products"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE products
    SET(name,description,stock,price,sell_price,supplier_id) = ($1,$2,$3,$4,$5,$6)
    WHERE id = $7"
    values = [@name,@description,@stock,@price,@sell_price,@supplier_id,@id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM products
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def self.set_supplier_id_to_nil(id)
  #   sql = "UPDATE products
  #   SET(supplier_id) = ($1)
  #   WHERE id = $2"
  #   values = [nil,supplier_id]
  #   SqlRunner.run(sql, values)
  # end

  def self.find_by_id(id)
    sql = "SELECT * FROM products WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    product = self.new(result.first)
    return product
  end

  def self.view_all()
    sql = "SELECT * FROM products"
    products = SqlRunner.run( sql )
    result = products.map { |product_hash| Product.new(product_hash) }
    return result
  end


  def self.find_by_supplier_id(supplier_id)
    sql = "SELECT * FROM products
    WHERE supplier_id = $1"
    values = [supplier_id]
    products = SqlRunner.run(sql, values)
    result = products.map {|product| Product.new(product)}
    return result
  end

  def self.remove_supplier_id(supplier_id)
    product_array = Product.find_by_supplier_id(supplier_id)
    product_array.each {|product|
        product.supplier_id = nil
        product.update
      }
  end







end
