require 'rubygems'
require 'mechanize'

agent = Mechanize.new

page = agent.get('http://pogdesign.co.uk/cat/')

form = page.forms.first
form.username = 'madnashua@gmail.com'
form.password = '0@3<S.q1U5*g'
page = agent.submit(form, form.buttons.first)

puts agent.cookies