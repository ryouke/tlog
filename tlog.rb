#!/usr/local/ruby/bin/ruby

print "Content-Type: text/html\n\n"

require 'rubygems'
require 'twitter'
require 'cgi'

cgi = CGI.new
user = cgi['user'] 

page = 1
loop_end = false
item_index = 0
while 1 do
	print "page :" + page.to_s + "<br/>\n"
	mode = "a"
	mode = "w" if page == 1
	items = Twitter.user_timeline(user, { "page" => page, "count" => 200 })
	if items.length == 0
		loop_end = true
	else
		items.each { |item|
			prev_item = item.to_str
			puts "----<br/>\n"
			puts item_index.to_s + "<br/>\n"
			puts item.id_str + " "
			puts item.created_at + " "
			puts item.source + " "
			puts "<br/>\n"
			puts item.text
			puts "<br/>\n"
			item_index += 1
		}
	end
	if loop_end
		break
	else
		page += 1
		sleep 30 # 150times/hの場合こんなかんじ
	end
end
