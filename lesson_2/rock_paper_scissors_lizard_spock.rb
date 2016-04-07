VALID_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'l' => 'lizard', 'sp' => 'spock' }.freeze
WINNING_COMBINATIONS = [%w(r sc), %w(p r), %w(sc p), %w(r l), %w(l sp),
                        %w(sp sc), %w(sc l), %w(l p), %w(p sp), %w(sp r)].freeze
WINNING_SCORE = 5

def prompt(message)
  puts "=> #{message}"
end

def display_valid_choices
  VALID_CHOICES.each { |k, v| prompt "For #{v}, enter '#{k}'" }
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
  loop do
    system('clear') || system('cls')
    prompt "Welcome to Rock, Paper, Scissors, Lizard, Spock."
    prompt "The winner is the first to reach 5 points. Good luck!"
    prompt "-----------------------------------------------------"
    prompt "Current scores: You: #{player_score}; computer: #{computer_score}\n\n"

    player_choice = ''
    prompt "Make your choice:"
    display_valid_choices
    loop do
      player_choice = gets.chomp
      break if VALID_CHOICES.keys.include?(player_choice)
      prompt "Please enter a valid choice."
    end

    computer_choice = VALID_CHOICES.keys.sample

    prompt "You chose: #{VALID_CHOICES[player_choice]}; computer chose: #{VALID_CHOICES[computer_choice]}"

    display_result(player_choice, computer_choice)
    sleep 2

    player_score += 1 if win?(player_choice, computer_choice)
    computer_score += 1 if win?(computer_choice, player_choice)
    break if player_score == WINNING_SCORE || computer_score == WINNING_SCORE
  end

  prompt "-----------------------------------------------------"
  prompt "You have #{WINNING_SCORE} points and have won!" if player_score == WINNING_SCORE
  prompt "Computer has #{WINNING_SCORE} points and has won!" if computer_score == WINNING_SCORE

  prompt "-----------------------------------------------------"
  prompt "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Good bye!"
