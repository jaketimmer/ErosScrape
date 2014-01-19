require 'rubygems'
require 'mechanize'
require 'pp'
require 'net/http'
require 'uri'
require 'open-uri'

proxy_address = '60.55.55.142'
proxy_port = 80
michigan_cities = ["detroit", "grand_rapids", "ann_arbor", "warren"]



Net::HTTP.new('http://hidemyass.com', nil, proxy_address, proxy_port)
	agent = Mechanize.new 
	# page = agent.get('http://eros.com') 
	# page = agent.get('http://www.eros-michigan.com/sections/detroit_michigan_escorts.htm')
		# Click Ann Arbor link
	states = {'michigan' => ['detroit', 'ann_arbor'],  'alabama' => ['birmingham', 'huntsville', 'mobile', 'montgomery', 'tuscaloosa']}
	states.keys.each do |state|
		states[state].each do |city|
			page = agent.get('http://www.eros-' + state + '.com/sections/' + city + '_' + state + '_escorts.htm')
			list = page.root.css('frame[name="select"]')[0].attributes['src'].value
			# pp list
			listingURL = 'http://www.eros-' + state + '.com' + list

			page = agent.get(listingURL)

			# michigan = page.link_with(:text => 'Detroit ').click
			# detroit = michigan.link_with(:text => '                        Detroit (37)')
			#puts link.text

			#michigan = @page.link_with(:text => 'Detroit ').clic
			# puts michigan.uri
			listings = page.root.css('li.listing>div.listing-core>p.listing-name>a')
			links = listings.map { |link| link.attributes['href'].value }
			# pp links

			phones = []

			links.each do |link|
				page = agent.get(link)
				p = page.root.css('span.tel').children[0]
				if p
					phones << p.text.chop!
				end
			end
			pp phones
		end
	end


	#detroit = michigan.link_with(:text => '').click
	


	#this = page.link_with(:class => 'Ann Arbor').click
		#initial_page = agent.click(page.link_with(:text => /Ann Arbor/))
		#doc = Nokogiri::HTML(open('http://eros.com'))    #<= parses document
		#puts this                                        #<= parses document
		
		#ann_arbor_page = initial_page.form_with(:name => '')
	

	#dc_page = page.click() 


	
#	pp page



#@agent ||= Mechanize.new.tap do |agent|
#	agent.set_proxy('60.55.55.142', 80) # <= setting the proxy
#end

