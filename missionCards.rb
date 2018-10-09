require 'squib'
require 'open-uri'

# Mission Cards  
buffer = open("https://docs.google.com/spreadsheets/d/1XnzOHjy5nis4R9Oes4dEJUuuCuq6cRq9RvQAAvNYV0c/export?format=csv&gid=0").read
numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
File.open("my_data.csv", 'wb') do |file|
    file << buffer
end

missiondata = Squib.csv(file: 'my_data.csv', strip: true, explode: 'Number') do |header, value|
  case header
  when 'Cost'
    "$#{value}k" # e.g. "3" becomes "$3k"
  else
    value # always return the original value if you didn't do anything to it
  end
end

num_cards = missiondata['Number'].size 


Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: '#ff69b4'
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: missiondata['Title'], layout: 'title'
  text str: missiondata['Description'], layout: 'description'
  text str: 'Mission', layout: 'type'
  save_png prefix: 'missionCard_'
end

# Weather Cards  
buffer = open("https://docs.google.com/spreadsheets/d/1crQ35nYeLrl5EukgnZ58TKrB_YCth4eEvFc-DyE1fK8/export?format=csv&gid=0").read
numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
File.open("my_data.csv", 'wb') do |file|
    file << buffer
end

weatherdata = Squib.csv(file: 'my_data.csv', strip: true, explode: 'Number') do |header, value|
  case header
  when 'Cost'
    "$#{value}k" # e.g. "3" becomes "$3k"
  else
    value # always return the original value if you didn't do anything to it
  end
end

num_cards = weatherdata['Number'].size 

Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: '#99D8E6'
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: weatherdata['Title'], layout: 'title'
  text str: weatherdata['Description'], layout: 'description'
  text str: 'Weather', layout: 'type'
  save_png prefix: 'weatherCard_'
end

data = missiondata

num_cards = data['Number'].size 
num_cards = (18-(num_cards%18)) + num_cards

Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: '#FFFFFF'
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
  text str: data['Description'], layout: 'description'
  text str: 'Weather', layout: 'type'
  save_png prefix: 'combinedCard_'
  save_sheet sprue: 'formats/sheet.yml', prefix: 'aaafinal_'
end



# Coastal Raiding Events General
backgroundColor = '#99F099'

sheetIDs = ['2078396274','870396774','1449022118']

# Coastal Raiding Events - Sheet Loop
sheetIDs.each do |sheetID|

buffer = open("https://docs.google.com/spreadsheets/d/1pULEeEm4ZWrd5UFRt6UDcUxDT_HwkAMLysPvrWGW9zs/export?format=csv&gid=#{sheetID}").read
numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
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
  save_png prefix: 'raiding_' + data['Area'][0] + '_'
end

end

# Patrol Events General
backgroundColor = '#ADD8E6'

sheetIDs = ['806677367']

# Patrol Events - No Seasons
sheetIDs.each do |sheetID|

buffer = open("https://docs.google.com/spreadsheets/d/1WNg1cdciCMwPENsZ2pCgi9yAbj60scBiORGz-YhYB3E/export?format=csv&gid=#{sheetID}").read
numCards = CSV.parse(buffer).length - 1 #CSV counts the header row; we only want the number of cards.
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

data = Squib.csv(file: 'my_data.csv', strip: true, explode: season) do |header, value|
  case header
  when 'Cost'
    "$#{value}k" # e.g. "3" becomes "$3k"
  else
    value # always return the original value if you didn't do anything to it
  end
end

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
