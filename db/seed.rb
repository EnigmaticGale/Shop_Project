require_relative('../models/product')
require_relative('../models/supplier')

Product.delete_all

product1 = Product.new({
  'name' => '100g gold bar',
  'description' => 'shiny',
  'stock' => '5',
  'price' => '3430.50',
  'sell_price' => '3599.99'
  })

product2 = Product.new({
  'name' => '100g silver bar',
  'description' => 'nice',
  'stock' => '10',
  'price' => '72.05',
  'sell_price' => '89.99'
  })

product3 = Product.new({
  'name' => '100g platinum bar',
  'description' => 'fresh',
  'stock' => '16',
  'price' => '2247.33',
  'sell_price' => '2999.99'
  })

product1.save
product2.save
product3.save
