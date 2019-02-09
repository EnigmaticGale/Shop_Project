require_relative('../db/sql_runner')

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





end
