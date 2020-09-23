require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'

before do
  Dotenv.load
  Cloudinary.config do |config|
      config.cloud_name = ENV['CLOUD_NAME']
      config.api_key    = ENV['CLOUDINARY_API_KEY']
      config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end
end

get '/' do
  @contents = Contribution.all.order('id desc')
  @categories = Category.all
  erb :index
end

get '/category/:id' do
  @contents   = Contribution.where(category_id:params[:id])
  @category       = Category.find(params[:id])
  @category_name  = @category.name
  @categories     = Category.all
  erb :index
end

post '/new' do
  img_url = ''
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload['url']
  end

  Contribution.create({
    name: params[:user_name],
    body: params[:body],
    good: 0,
    img: img_url,
    category_id: params[:category]
  })

  redirect '/'
end

post '/delete/:id' do
Contribution.find(params[:id]).destroy
redirect '/'
end

get '/edit/:id' do
@content = Contribution.find(params[:id])
erb :edit
end

post '/renew/:id' do
  content = Contribution.find(params[:id])
  content.update({
    name: params[:user_name],
    body: params[:body]
  })
  redirect '/'
end

post '/good/:id' do
  content = Contribution.find(params[:id])
  good = content.good
  content.update({
    good: good + 1
  })
  redirect '/'
end

post '/reply/done/:id' do
  @content = Contribution.find(params[:id])
  # reply = content.reply
  Reply.create({
    name: params[:user_name],
    body: params[:body],
    good: 0,
    contribution_id: params[:id]
  })
  redirect '/'
end

post '/reply/:id' do
  @content = Contribution.find(params[:id])
  erb :reply
end

post '/create' do
  Conteribution.create({
    　　title: params[:title],
    　　category_id: params[:contribution]
  })

  redirect '/'
end