VALID_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'l' => 'lizard', 'sp' => 'spock' }.freeze
WINNING_COMBINATIONS = [%w(r sc), %w(p r), %w(sc p), %w(r l), %w(l sp),
                        %w(sp sc), %w(sc l), %w(l p), %w(p sp), %w(sp r)].freeze
WINNING_SCORE = 5

def prompt(message)
  puts "=> #{message}"
end

def press_enter_to_continue
  loop do
    prompt "-----------------------------------------------------"
    prompt "Press enter to continue..."
    break if gets.include?("\n")
  end
end

def display_valid_choices
  VALID_CHOICES.each { |key, choice| prompt "For #{choice}, enter '#{key}'" }
end

def win?(first, second)
  WINNING_COMBINATIONS.include?([first, second])
end

def display_result(player_choice, computer_choice)
  if win?(player_choice, computer_choice)
    prompt "You won this round!"
  elsif win?(computer_choice, player_choice)
    prompt "Computer won this round!"
  else
    prompt "It's a tie!"
  end
end

loop do
  player_score = 0
  computer_score = 0

  system('clear') || system('cls')
  prompt "Welcome to Rock, Paper, Scissors, Lizard, Spock."
  prompt "The winner is the first to reach 5 points. Good luck!"
  press_enter_to_continue

  loop do
    system('clear') || system('cls')
    prompt "Current scores: You: #{player_score}; computer: #{computer_score}"
    prompt "-----------------------------------------------------"

    player_choice = ''
    prompt "Make your choice:"
    display_valid_choices
    loop do
      player_choice = gets.chomp.downcase
      break if VALID_CHOICES.keys.include?(player_choice)
      prompt "Please enter a valid choice."
    end

    computer_choice = VALID_CHOICES.keys.sample

    prompt "You chose: #{VALID_CHOICES[player_choice]}; "\
           "computer chose: #{VALID_CHOICES[computer_choice]}"

    display_result(player_choice, computer_choice)

    player_score += 1 if win?(player_choice, computer_choice)
    computer_score += 1 if win?(computer_choice, player_choice)
    break if player_score == WINNING_SCORE || computer_score == WINNING_SCORE

    press_enter_to_continue
  end

  prompt "-----------------------------------------------------"
  if player_score == WINNING_SCORE
    prompt "You have #{WINNING_SCORE} points and have won!"
  elsif computer_score == WINNING_SCORE
    prompt "Computer has #{WINNING_SCORE} points and has won!"
  end
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
