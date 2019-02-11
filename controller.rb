require('sinatra')
require('sinatra/contrib/all')
require_relative('models/product')
require_relative('models/supplier')
also_reload('./models/*')

get '/stock' do
  @stock = Product.view_all
  erb(:stock)
end

get '/suppliers' do
  @suppliers = Supplier.view_all
  erb(:suppliers)
end

get '/product/:id' do
  @product = Product.find_by_id(params[:id])
  erb(:product_details)
end

get '/product/supplier_of_product/:supplier_id' do
  @supplier = Supplier.find_by_id(params[:supplier_id])
  erb(:supplier_of_product)
end

get '/product/supplier_of_product/supplier_details/:id' do
  @supplier = Supplier.find_by_id(params[:id])
  erb(:supplier_details)
end

get '/edit_product/:id' do
  @supplier = supplier.view_all
  @product = Product.find_by_id(params[:id])
end

post '/new_product' do
  Product.new(params).save
  redirect to '/stock'
end

post '/new_supplier' do
  Product.new(params).save
  redirect to '/stock'
end
