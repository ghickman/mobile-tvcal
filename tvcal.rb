require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'haml'

set :haml, {:format => :html5}
set :public, File.dirname(__FILE__)
set :views, File.dirname(__FILE__)+'/views'

get '/' do
  haml :index, :layout => false, :locals => {:shows => get_shows}
end

def get_shows()
  show_list = []
  xml = Nokogiri::XML(File.open('tv.xml', 'r')).root
  xml.xpath('//show').each do |show|
    a_show = [show.xpath('.//name').text]
    show.xpath('.//info').each do |info|
      a_show << info.text
    end
    show_list << a_show
  end
  show_list
end
