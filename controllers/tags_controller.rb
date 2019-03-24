require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/budget')
require_relative('../models/transaction')
require_relative('../models/tag')
require_relative('../models/merchant')
also_reload('../models/*')


get '/tags' do
  @tags = Tag.all
  erb(:"tags/index")
end

get '/tags/new' do
  @transactions = Transaction.all

  @tags = Tag.all

  erb(:"tags/new")
end

post '/tags' do
  Tag.new(params).save
  redirect to '/tags'
end


get '/tags/:id' do
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end
#
# get '/transactions/:id/edit' do
#   @transaction = Transaction.find(params[:id])
#   @transactions = Transaction.all
#   @merchants = Merchant.all
#   @tags = Tag.all
#   @budgets = Budget.all
#   erb(:edit)
# end
#
# post '/transactions/:id' do
#   transaction = Transaction.new(params)
#   transaction.update
#   redirect to "/transactions/#{params[:id]}"
# end
#
# post '/transactions/:id/delete' do
#   transaction = Transaction.find(params[:id])
#   transaction.delete
#   redirect to '/transactions'
# end