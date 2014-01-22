require 'rubygems'
require 'mechanize'
require 'pp'
require 'net/http'
require 'uri'
require 'open-uri'
require 'twilio-ruby'

proxy_address = '60.55.55.142'
proxy_port = 80

# Twilio information
account_sid = 'AC864bbd53ef32316e4b948b6a633d17a9'
auth_token = ''
@client = Twilio::REST::Client.new account_sid, auth_token

# Set Proxy
Net::HTTP.new('http://hidemyass.com', nil, proxy_address, proxy_port)
	
	puts "Welcome to TraffickStop!"
	puts "Reading eros, phone numbers to be contacted will be shown below"
	puts ""

	agent = Mechanize.new 

	states = {'michigan' => ['detroit', 'ann_arbor'],  'alabama' => ['birmingham', 'huntsville', 'mobile', 'montgomery', 'tuscaloosa']}
	states.keys.each do |state|
		states[state].each do |city|
			page = agent.get('http://www.eros-' + state + '.com/sections/' + city + '_' + state + '_escorts.htm')
			list = page.root.css('frame[name="select"]')[0].attributes['src'].value

			listingURL = 'http://www.eros-' + state + '.com' + list

			page = agent.get(listingURL)

			listings = page.root.css('li.listing>div.listing-core>p.listing-name>a')
			links = listings.map { |link| link.attributes['href'].value }

			phones = []

			links.each do |link|
				page = agent.get(link)
				p = page.root.css('span.tel').children[0]
				if p
					phones << p.text.chop!
				end
			end

			counter = 0
			phones.each do |x| 
				phone_number = x.gsub(/[^0-9]/, "")
				phone_number = phone_number[0..9]
				phone_array = []
				phone_array.push(phone_number)
				puts phone_array[counter]

				#  INSERT TWILIO CODE

			end
		end
	end
			# ^^^ INSERT ABOVE ^^^
	message = @client.account.sms.messages.create(:body => "This is a demonstration of TraffickStop",
		:to => "+", 				# <= number contacting
		:from => "+16164332137")    # <= my twilio num 
	#puts message.sid
	puts "Now Exiting TraffickStop"


