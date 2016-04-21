SUITS = %w(Clubs Diamonds Hearts Spades).freeze
VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze
MAXIMUM_HAND = 21
DEALER_HIT_BELOW = 17
WINNING_SCORE = 5

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

def display_initial_hand(player_or_dealer, show_first_card=true)
  calculate_total(player_or_dealer)
  puts "\n#{player_or_dealer[:name]}'s hand"\
       "#{", total = #{player_or_dealer[:total]}" if show_first_card}:"
  puts "+--------+   +--------+"
  puts "|        |   |        |"
  puts "|#{show_first_card ? (player_or_dealer[:hand][0][0] + ' of').center(8) : ' ' * 8}|   "\
       "|#{(player_or_dealer[:hand][1][0] + ' of').center(8)}|"
  puts "|#{show_first_card ? (player_or_dealer[:hand][0][1]).center(8) : ' ' * 8}|   "\
       "|#{player_or_dealer[:hand][1][1].center(8)}|"
  puts "|        |   |        |"
  puts "+--------+   +--------+"
end

def display_dealt_cards(player_or_dealer)
  return nil if player_or_dealer[:hand].size == 2
  dealt_cards = player_or_dealer[:hand].select.with_index { |_, index| index > 1 }
  count = dealt_cards.size
  puts "+--------+#{'   +--------+' if count > 1}#{'   +--------+' if count > 2}#{'   +--------+' if count > 3}"
  puts "|        |#{'   |        |' if count > 1}#{'   |        |' if count > 2}#{'   |        |' if count > 3}"
  puts "|#{(dealt_cards[0][0] + ' of').center(8)}|   "\
       "#{"|#{(dealt_cards[1][0] + ' of').center(8)}|" if count > 1}   "\
       "#{"|#{(dealt_cards[2][0] + ' of').center(8)}|" if count > 2}   "\
       "#{"|#{(dealt_cards[3][0] + ' of').center(8)}|" if count > 3}"
  puts "|#{dealt_cards[0][1].center(8)}|   "\
       "#{"|#{dealt_cards[1][1].center(8)}|" if count > 1}   "\
       "#{"|#{dealt_cards[2][1].center(8)}|" if count > 2}   "\
       "#{"|#{dealt_cards[3][1].center(8)}|" if count > 3}"
  puts "|        |#{'   |        |' if count > 1}#{'   |        |' if count > 2}#{'   |        |' if count > 3}"
  puts "+--------+#{'   +--------+' if count > 1}#{'   +--------+' if count > 2}#{'   +--------+' if count > 3}"
  if count > 4
    dealt_cards.select.with_index { |_, index| index > 3 }.each do |card|
      puts "#{card[0]} of #{card[1]}"
    end
  end
end

def display_game(player, dealer, show_dealer_card=false)
  system('clear') || system('cls')
  puts "Twenty-One".center(40)
  puts '-' * 40
  puts "#{player[:name]}'s score: #{player[:score]}; "\
       "#{dealer[:name]}'s score: #{dealer[:score]}".center(40)
  display_initial_hand(player)
  display_dealt_cards(player)
  display_initial_hand(dealer, show_dealer_card)
  display_dealt_cards(dealer)
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
  if busted?(player) || ((dealer[:total] > player[:total]) && !busted?(dealer))
    dealer
  elsif busted?(dealer) || ((player[:total] > dealer[:total]) && !busted?(player))
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
  prompt "The winner is the first to reach 5 points. Good luck!"
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
