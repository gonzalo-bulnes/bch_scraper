require 'sinatra'
require 'sinatra/config_file'
require_relative 'banco_scraper'

config_file 'config/credentials.yml'

get '/' do
  @rut = settings.rut
  @password = settings.password
  @balance = BancoScraper.new(@rut, @password).balance
  erb :index
end
