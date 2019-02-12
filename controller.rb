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

get '/suppliers/new' do
  @suppliers = Supplier.view_all
  erb(:new_supplier)
end

post '/suppliers/new' do
  @supplier = Supplier.new(params).save
  redirect to "/suppliers"
end

get '/stock/new' do
  @products = Product.view_all
  @suppliers = Supplier.view_all
  erb(:new_product)
end

post '/product/new' do
  @product = Product.new(params).save
  redirect to "/stock"
end

get '/product/:id' do
  @product = Product.find_by_id(params[:id])
  erb(:product_details)
end

get '/product/:id/edit' do
  @suppliers = Supplier.view_all
  @product = Product.find_by_id(params[:id])
  erb(:edit_product)
end

post '/product/:id/edit' do
  product = Product.new(params)
  product.update
  redirect to "/stock"
end

post '/product/:id/delete' do
  product = Product.find_by_id(params['id'])
  product.delete
  redirect to '/stock'
end

get '/product/supplier_of_product/:supplier_id' do
  @supplier = Supplier.find_by_id(params[:supplier_id])
  erb(:supplier_of_product)
end

get '/product/supplier_of_product/supplier_details/:id' do
  @supplier = Supplier.find_by_id(params[:id])
  erb(:supplier_details)
end

post '/supplier/:id/delete' do
  supplier = Supplier.find_by_id(params['id'])
  supplier.delete
  redirect to '/suppliers'
end
