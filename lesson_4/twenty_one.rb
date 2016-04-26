SUITS = %w(Clubs Diamonds Hearts Spades).freeze
VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze
MAXIMUM_HAND = 21
DEALER_HIT_BELOW = 17
WINNING_SCORE = 5
CARD_WIDTH = 8

def prompt(message)
  puts "=> #{message}"
end

def press_enter_to_continue
  puts '-' * 40
  prompt "Press enter to continue..."
  gets
end

def initialize_deck
  VALUES.product(SUITS).shuffle
end

def deal_card(player_or_dealer, deck)
  player_or_dealer[:hand] << deck.pop
end

def initial_hand(player_or_dealer)
  player_or_dealer[:hand].slice(0, 2)
end

def dealt_cards(player_or_dealer)
  player_or_dealer[:hand].slice(2, player_or_dealer[:hand].size - 2)
end

def display_cards(cards, show_first_card=true)
  edges = ''
  middles = ''
  values = ''
  suits = ''

  cards.each do |card|
    edges << "+#{'-' * CARD_WIDTH}+   "
    middles << "|#{' ' * CARD_WIDTH}|   "
    if show_first_card || card != cards.first
      values << "|#{(card[0] + ' of').center(CARD_WIDTH)}|   "
      suits << "|#{card[1].center(CARD_WIDTH)}|   "
    else
      values << "|#{' ' * CARD_WIDTH}|   "
      suits << "|#{' ' * CARD_WIDTH}|   "
    end
  end

  puts edges
  puts middles
  puts values
  puts suits
  puts middles
  puts edges
end

def display_hand(player_or_dealer, show_first_card=true)
  calculate_total(player_or_dealer)
  puts "\n#{player_or_dealer[:name]}'s hand"\
       "#{", total = #{player_or_dealer[:total]}" if show_first_card}:"
  display_cards(initial_hand(player_or_dealer), show_first_card)
  display_cards(dealt_cards(player_or_dealer)) unless dealt_cards(player_or_dealer).none?
end

def display_game(player, dealer, show_dealer_card=false)
  system('clear') || system('cls')
  puts "Twenty-One".center(40)
  puts '-' * 40
  puts "#{player[:name]}'s score: #{player[:score]}; "\
       "#{dealer[:name]}'s score: #{dealer[:score]}".center(40)
  display_hand(player)
  display_hand(dealer, show_dealer_card)
  puts ""
end

def calculate_total(player_or_dealer)
  total = 0
  count_aces = 0

  player_or_dealer[:hand].each do |card|
    if card[0] == 'Ace'
      total += 11
      count_aces += 1
    elsif card[0].to_i == 0
      total += 10
    else
      total += card[0].to_i
    end
  end

  count_aces.times { total -= 10 if total > MAXIMUM_HAND }
  player_or_dealer[:total] = total
end

def busted?(player_or_dealer)
  calculate_total(player_or_dealer) > MAXIMUM_HAND
end

def find_winner(player, dealer)
  calculate_total(player)
  calculate_total(dealer)
  if busted?(player)
    dealer
  elsif busted?(dealer)
    player
  elsif dealer[:total] > player[:total]
    dealer
  elsif player[:total] > dealer[:total]
    player
  end
end

def display_result(player, dealer)
  puts '-' * 40
  if busted?(player)
    prompt "#{player[:name]} is bust."
  elsif busted?(dealer)
    prompt "#{dealer[:name]} is bust."
  end
  if find_winner(player, dealer)
    prompt "#{find_winner(player, dealer)[:name]} has won this round!"
  else
    prompt "It's a tie!"
  end
end

loop do
  player = { name: 'Player', score: 0 }
  dealer = { name: 'Dealer', score: 0 }

  system('clear') || system('cls')
  prompt "Welcome to Twenty-One."
  prompt "The winner is the first to reach #{WINNING_SCORE} points. Good luck!"
  press_enter_to_continue

  loop do
    player[:hand] = []
    dealer[:hand] = []
    deck = initialize_deck

    2.times do
      deal_card(player, deck)
      deal_card(dealer, deck)
    end

    display_game(player, dealer)

    loop do
      hit_or_stay = ''
      prompt "#{player[:name]}'s turn: hit (h) or stay (s)?"
      loop do
        hit_or_stay = gets.chomp.downcase
        break if %w(h s hit stay).include?(hit_or_stay)
        prompt "That is not a valid choice. Enter 'h' to hit or 's' to stay."
      end

      break if hit_or_stay == 's' || hit_or_stay == 'stay'
      deal_card(player, deck)
      display_game(player, dealer)

      break if busted?(player)
    end

    unless busted?(player)
      prompt "#{player[:name]} chose to stay. #{dealer[:name]}'s turn."
      press_enter_to_continue
      display_game(player, dealer, true)

      while calculate_total(dealer) < DEALER_HIT_BELOW
        prompt "#{dealer[:name]} has less than #{DEALER_HIT_BELOW} so will hit."
        press_enter_to_continue
        deal_card(dealer, deck)
        display_game(player, dealer, true)
      end
    end

    display_result(player, dealer)
    press_enter_to_continue
    if find_winner(player, dealer)
      find_winner(player, dealer)[:score] += 1
      break if find_winner(player, dealer)[:score] == WINNING_SCORE
    end
  end

  puts '-' * 40
  prompt "#{find_winner(player, dealer)[:name]} has #{WINNING_SCORE} points and has won!"
  puts '-' * 40

  play_again = ''
  prompt "Do you want to play again (y/n)?"
  loop do
    play_again = gets.chomp.downcase
    break if %w(y n yes no).include?(play_again)
    prompt "Enter 'y' to play again or 'n' to quit."
  end
  break unless play_again == 'y' || play_again == 'yes'
end

prompt "Thank you for playing Twenty-One. Good bye!"
