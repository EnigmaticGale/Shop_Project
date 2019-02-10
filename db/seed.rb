require_relative('../models/product')
require_relative('../models/supplier')

Product.delete_all
Supplier.delete_all

supplier1 = Supplier.new({
  'company_name' => 'Fresh Metal',
  'company_description' => 'the freshest metals on the market',
  'contact_number' => '0131 534 095'
  })

supplier2 = Supplier.new({
  'company_name' => 'Mint',
  'company_description' => 'good smelling breath',
  'contact_number' => '0131 534 095'
  })

  supplier1.save
  supplier2.save

product1 = Product.new({
  'name' => '100g gold bar',
  'description' => 'shiny',
  'stock' => '5',
  'price' => '3430.50',
  'sell_price' => '3599.99',
  'supplier_id' => supplier2.id
  })

product2 = Product.new({
  'name' => '100g silver bar',
  'description' => 'nice',
  'stock' => '10',
  'price' => '72.05',
  'sell_price' => '89.99',
  'supplier_id' => supplier1.id
  })

product3 = Product.new({
  'name' => '100g platinum bar',
  'description' => 'fresh',
  'stock' => '16',
  'price' => '2247.33',
  'sell_price' => '2999.99',
  'supplier_id' => supplier1.id
  })

  product4 = Product.new({
    'name' => '10g gold bar',
    'description' => 'funky',
    'stock' => '40',
    'price' => '224.73',
    'sell_price' => '249.99'
    })

product1.save
product2.save
product3.save
product4.save

product1.description = 'not bad'
product1.update

product4.delete

supplier1.contact_number = '04329'
supplier1.update

supplier2.delete
supplier1.delete
