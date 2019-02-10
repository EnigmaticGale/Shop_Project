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





end
