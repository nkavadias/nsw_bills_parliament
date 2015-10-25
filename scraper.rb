# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

 require 'scraperwiki'
 require 'mechanize'
#
 agent = Mechanize.new
#
# # Read in a page
#
this_year = Date.today.year
#p this_year

(1997..this_year).each do |y|
#  p y
#end
puts "Doing year: #{y}"
  agent_url = "http://www.parliament.nsw.gov.au/prod/parlment/nswbills.nsf/V3BillsListAssented?open&vwCurr=V3AssentedByYear&vwCat=#{y}"
  #puts agent_url
  page = agent.get(agent_url)
  # # Find somehing on the page using css selectors
  page.at("table").search("tr")[1...-1].each do |r|
  #r = page.at("table").search("tr")[1]
    record = {
      name: r.search("td")[1].text,
      url:  "http://http://www.parliament.nsw.gov.au" + r.at("td a").attr('href'),
      house: r.search("td")[2].text
    }
    p record[:name]
    ScraperWiki.save_sqlite( [:name], record)
  end
end

  #r.search("td")[1].text
#
# # Write out to the sqlite database using scraperwiki library
#
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
