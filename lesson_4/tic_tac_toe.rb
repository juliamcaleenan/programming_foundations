INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
PLAYER_NAME = 'Player'.freeze
COMPUTER_NAME = 'Computer'.freeze
FIRST_PLAYER = 'Player'.freeze # 'Player', 'Computer' or 'Choose'
WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                        [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze
WINNING_SCORE = 5

def prompt(message)
  puts "=> #{message}"
end

def joinor(array, separator=', ', joining_word='or')
  array[-1] = "#{joining_word} #{array.last}" if array.size > 1
  array.join(separator)
end

def press_enter_to_continue
  prompt "-----------------------------------------------------"
  prompt "Press enter to continue..."
  gets
end

def initialize_board
  board = {}
  (1..9).each { |square| board[square] = INITIAL_MARKER }
  board
end

def display_board(board, player, computer)
  system('clear') || system('cls')
  puts "     Tic, Tac, Toe     "
  puts "-----------------------"
  puts "  #{player[:name]}: #{player[:marker]}; Score: #{player[:score]}"
  puts " #{computer[:name]}: #{computer[:marker]}; Score: #{computer[:score]}\n\n"
  puts "       |       |       "
  puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}    "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}    "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}    "
  puts "       |       |       \n\n"
end

def empty_squares(board)
  board.select { |_, status| status == INITIAL_MARKER }.keys
end

def choose_first_player(player, computer)
  case FIRST_PLAYER.downcase
  when player[:name].downcase
    player
  when computer[:name].downcase
    computer
  when 'choose'
    player_chooses_first_player == 'player' ? player : computer
  else
    computer
  end
end

def player_chooses_first_player
  choice = ''
  prompt "Choose who plays first (player or computer):"
  loop do
    choice = gets.chomp.downcase
    break if %w(player computer).include?(choice)
    prompt "Enter 'player' or 'computer' to determine who plays first."
  end
  choice
end

def player_marks_square(board)
  player_choice = ''
  prompt "Choose a square (#{joinor(empty_squares(board))}):"
  loop do
    player_choice = gets.chomp.to_i
    break if empty_squares(board).include?(player_choice)
    prompt "That is not a valid choice."
  end
  board[player_choice] = PLAYER_MARKER
end

def find_winning_square(board, marker)
  WINNING_COMBINATIONS.each do |squares|
    if (board.values_at(*squares).count(marker) == 2) &&
       (board.values_at(*squares).count(INITIAL_MARKER) == 1)
      winning_square = board.select do |position, status|
        squares.include?(position) && status == INITIAL_MARKER
      end
      return winning_square.keys.first
    end
  end
  nil
end

def choose_square_5_if_available(board)
  5 if empty_squares(board).include?(5)
end

def computer_marks_square(board)
  computer_choice = find_winning_square(board, COMPUTER_MARKER) ||
                    find_winning_square(board, PLAYER_MARKER) ||
                    choose_square_5_if_available(board) ||
                    empty_squares(board).sample
  board[computer_choice] = COMPUTER_MARKER
end

def mark_square(current_player, board)
  case current_player[:marker]
  when PLAYER_MARKER
    player_marks_square(board)
  when COMPUTER_MARKER
    computer_marks_square(board)
  end
end

def winner?(current_player, board)
  WINNING_COMBINATIONS.each do |squares|
    return true if board.values_at(*squares).count(current_player[:marker]) == 3
  end
  false
end

def board_full?(board)
  empty_squares(board).none?
end

def alternate_player(current_player, player, computer)
  current_player == player ? computer : player
end

loop do
  player = { name: PLAYER_NAME, marker: PLAYER_MARKER, score: 0 }
  computer = { name: COMPUTER_NAME, marker: COMPUTER_MARKER, score: 0 }
  current_player = {}

  system('clear') || system('cls')
  prompt "Welcome to Tic, Tac, Toe."
  prompt "The winner is the first to reach 5 points. Good luck!"
  press_enter_to_continue

  loop do
    board = initialize_board
    display_board(board, player, computer)

    current_player = choose_first_player(player, computer)

    loop do
      mark_square(current_player, board)
      display_board(board, player, computer)
      break if winner?(current_player, board) || board_full?(board)
      current_player = alternate_player(current_player, player, computer)
    end

    if winner?(current_player, board)
      prompt "#{current_player[:name]} won this round!"
      current_player[:score] += 1
    elsif board_full?(board)
      prompt "It's a tie!"
    end

    break if current_player[:score] == WINNING_SCORE
    press_enter_to_continue
  end

  prompt "-----------------------------------------------------"
  prompt "#{current_player[:name]} has #{WINNING_SCORE} points and has won!"
  prompt "-----------------------------------------------------"

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
