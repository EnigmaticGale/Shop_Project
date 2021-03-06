require_relative('../db/sql_runner')
require_relative('product.rb')

class Supplier

  attr_accessor :company_name , :company_description , :contact_number
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @company_name = options['company_name']
    @company_description = options['company_description']
    @contact_number = options['contact_number']
  end

  def save()
    sql = "INSERT INTO suppliers(company_name,company_description,contact_number)
    VALUES($1, $2, $3)
    RETURNING id"
    values = [@company_name,@company_description,@contact_number]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def self.delete_all()
    sql = "DELETE FROM suppliers"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE suppliers
    SET(company_name,company_description,contact_number) = ($1,$2,$3)
    WHERE id = $4"
    values = [@company_name,@company_description,@contact_number,@id]
    SqlRunner.run(sql, values)
  end

  def delete()
    Product.remove_supplier_id(@id)
    sql = "DELETE FROM suppliers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM suppliers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    supplier = self.new(result.first)
    return supplier
  end

  def self.view_all()
    sql = "SELECT * FROM suppliers"
    suppliers = SqlRunner.run(sql)
    result = suppliers.map { |supplier| Supplier.new(supplier) }
    return result
  end

  def assign_to_product(product)
    product.supplier_id = @id
    product.update
  end

  def view_products()
    sql = "SELECT * FROM products WHERE supplier_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    products_array = result.map {|product| Product.new(product)}
    return products_array
  end






end
