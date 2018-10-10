require 'squib'
require 'open-uri'


# Combined Cards
# Mission
buffer = open("https://docs.google.com/spreadsheets/d/1XnzOHjy5nis4R9Oes4dEJUuuCuq6cRq9RvQAAvNYV0c/export?format=csv&gid=0").read

# Weather
tempbuffer = open("https://docs.google.com/spreadsheets/d/1crQ35nYeLrl5EukgnZ58TKrB_YCth4eEvFc-DyE1fK8/export?format=csv&gid=0").read
bufstart = tempbuffer.index("\n")
bufend = tempbuffer.length - 1
#puts bufstart
#puts bufend
tempbuffer = tempbuffer[bufstart..bufend]
buffer = buffer + tempbuffer
#print buffer

# Raiding
sheetIDs = ['2078396274','870396774','1449022118']

# Coastal Raiding Events - Sheet Loop
sheetIDs.each do |sheetID|
tempbuffer = open("https://docs.google.com/spreadsheets/d/1pULEeEm4ZWrd5UFRt6UDcUxDT_HwkAMLysPvrWGW9zs/export?format=csv&gid=#{sheetID}").read
bufstart = tempbuffer.index("\n")
bufend = tempbuffer.length - 1
tempbuffer = tempbuffer[bufstart..bufend]
buffer = buffer + tempbuffer
end

#print buffer

#numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
File.open("my_data.csv", 'wb') do |file|
    file << buffer
end

data = Squib.csv(file: 'my_data.csv', strip: true, explode: 'Number')

num_cards = data['Number'].size 
#num_cards = (18-(num_cards%18)) + num_cards

Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: data['Color']
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
  text str: data['Description'], layout: 'description'
  text str: data['Type'], layout: 'type'
  text str: data['Area'], layout: 'subtype'
  save_png prefix: 'combinedCard_'
  save_sheet sprue: 'formats/sheet.yml', prefix: 'aaafinal_'
end




# Patrol Events General
backgroundColor = '#ADD8E6'

sheetIDs = ['806677367']

# Patrol Events - No Seasons
sheetIDs.each do |sheetID|

buffer = open("https://docs.google.com/spreadsheets/d/1WNg1cdciCMwPENsZ2pCgi9yAbj60scBiORGz-YhYB3E/export?format=csv&gid=#{sheetID}").read
#numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
File.open("my_data.csv", 'wb') do |file|
    file << buffer
end

data = Squib.csv(file: 'my_data.csv', strip: true, explode: 'Number') do |header, value|
  case header
  when 'Cost'
    "$#{value}k" # e.g. "3" becomes "$3k"
  else
    value # always return the original value if you didn't do anything to it
  end
end

num_cards = data['Number'].size 


Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: backgroundColor
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
  text str: data['Description'], layout: 'description'
  text str: data['Type'], layout: 'type'
  text str: data['Area'], layout: 'subtype'
  save_png prefix: 'patrol_' + data['Area'][0] + '_'
end

seasons = ['All Seasons','Spring','Summer','Autumn','Winter']
sheetIDs = ['0','2078396274','1678764129','870396774','1449022118','1552140278']

# Patrol Events - Seasons
sheetIDs.each do |sheetID|

buffer = open("https://docs.google.com/spreadsheets/d/1WNg1cdciCMwPENsZ2pCgi9yAbj60scBiORGz-YhYB3E/export?format=csv&gid=#{sheetID}").read
numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
File.open("my_data.csv", 'wb') do |file|
    file << buffer
end

seasons.each do |season|

data = Squib.csv(file: 'my_data.csv', strip: true, explode: season)

num_cards = data[season].size 


Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: backgroundColor
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
  text str: data['Description'], layout: 'description'
  text str: data['Type'], layout: 'type'
  text str: data['Area'], layout: 'subtype'
  save_png prefix: 'patrol_' + data['Area'][0] + '_' + season + '_'
end

end #seasons
end #sheetIDs
end
