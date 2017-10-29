require 'nokogiri'
require 'open-uri'
require 'mechanize'

agent = Mechanize.new
exit if ARGV[0].nil?
doc = Nokogiri::HTML(open ARGV[0])

title = doc.xpath('//title').to_s
newtitle = title[7, title.length - 15]

images = doc.xpath('//img').to_a.reject! do |img| 
#doc.xpath('//img[@class="chuongtruyen"]')??
  url      = img.attr('src')
  filename = File.basename(url)
  result = filename[0, filename.length - 12]
  begin
      newfile = agent.get(url)  
      newfile.save!("truyentranhonline/#{newtitle}/#{result}")
  rescue
  end
end
puts "Done!"# download-manga
