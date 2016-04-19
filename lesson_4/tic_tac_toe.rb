INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                        [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

def prompt(message)
  puts "=> #{message}"
end

def initialize_board
  board = {}
  (1..9).each { |square| board[square] = INITIAL_MARKER }
  board
end

def display_board(board)
  system('clear') || system('cls')
  puts "  Tic, Tac, Toe  "
  puts "    Player: #{PLAYER_MARKER}    "
  puts "   Computer: #{COMPUTER_MARKER}   \n\n"
  puts "     |     |     "
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}   "
  puts "     |     |     \n\n"
end

def empty_squares(board)
  board.select { |_, status| status == INITIAL_MARKER }.keys
end

def mark_square(choice, marker, board)
  board[choice] = marker
end

def winner?(marker, board)
  WINNING_COMBINATIONS.each do |combination|
    return true if board.values_at(*combination).count(marker) == 3
  end
  false
end

loop do
  board = initialize_board
  display_board(board)

  loop do
    player_choice = ''
    prompt "Choose a square (#{empty_squares(board).join(', ')}):"
    loop do
      player_choice = gets.chomp.to_i
      break if empty_squares(board).include?(player_choice)
      prompt "That is not a valid choice."
    end

    mark_square(player_choice, PLAYER_MARKER, board)
    display_board(board)

    if winner?(PLAYER_MARKER, board)
      prompt "You have won!"
      break
    end

    computer_choice = empty_squares(board).sample
    mark_square(computer_choice, COMPUTER_MARKER, board)
    display_board(board)

    if winner?(COMPUTER_MARKER, board)
      prompt "Computer has won!"
      break
    end

    if empty_squares(board).empty?
      prompt "It's a tie!"
      break
    end
  end

  answer = ''
  prompt "Do you want to play again (y/n)?"
  loop do
    answer = gets.chomp.downcase
    break if %w(y n yes no).include?(answer)
    prompt "Enter 'y' to play again or 'n' to quit."
  end
  break unless answer == 'y' || answer == 'yes'
end

prompt "Thank you for playing. Good bye!"
