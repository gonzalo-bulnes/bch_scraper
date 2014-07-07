require 'sinatra'
require 'sinatra/config_file'
require_relative 'banco_scrapper'

config_file 'config/credentials.yml'

get '/' do
  @rut = settings.rut
  @password = settings.password
  @balance = BancoScrapper.new(@rut, @password).balance
  erb :index
end
