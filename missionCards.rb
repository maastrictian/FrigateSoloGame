require 'squib'

data = Squib.xlsx(file: 'xlsData/Mission Cards.xlsx', sheet: 0, strip: true, explode: 'Number') do |header, value|
  case header
  when 'Cost'
    "$#{value}k" # e.g. "3" becomes "$3k"
  else
    value # always return the original value if you didn't do anything to it
  end
end

num_cards = data['Number'].size 


Squib::Deck.new cards: num_cards, layout: 'xlsData/Mission Cards.yml' do
  background color: '#ADD8E6'
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'title_box'
  text str: data['Title'], layout: 'title'
  text str: data['Description'], layout: 'description'
  save_png prefix: 'missionCard_'
end
