require 'squib'

data = Squib.csv(file: 'my_data.csv', strip: true, explode: 'Number')

num_cards = data['Number'].size 

Squib::Deck.new cards: num_cards, layout: 'formats/GameCards.yml' do
  background color: data['Color']
 # background color: "#FFFFFF".chomp
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
#  text str: data['Description'], layout: 'description'
  text str: data['Color'], layout: 'description'
  text str: data['Type'], layout: 'type'
  text str: data['Area'], layout: 'subtype'
  save_png prefix: 'combinedCard_'
#  save_sheet sprue: 'formats/sheet.yml', prefix: 'aaafinal_'
end
