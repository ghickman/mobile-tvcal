require 'rubygems'
require 'mechanize'
require 'nokogiri'

agent = Mechanize.new

page = agent.get('http://pogdesign.co.uk/cat/')

form = page.forms.first
form.username = 'madnashua@gmail.com'
form.password = '0@3<S.q1U5*g'
page = agent.submit(form, form.buttons.first)

# build the xml document from the results
output = Nokogiri::XML::Document.new
root = Nokogiri::XML::Node.new('root', output)
output << root

page.parser.xpath("//td[@class='today']/table/tr/td").map do |row|
  show = Nokogiri::XML::Node.new('show', output)

  name = Nokogiri::XML::Node.new('name', output)
  name.content = row.xpath(".//a").text
  show << name

  row.xpath(".//span").map do |info|
    node = Nokogiri::XML::Node.new('info', output)
    node.content = info.text
    show << node
  end

  root << show
  File.open('tv.xml', 'w') { |f| f.write(output.to_xml) }
end
