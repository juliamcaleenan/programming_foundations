require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(operator)
  case operator
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt MESSAGES['welcome']

name = ''
loop do
  name = gets.chomp
  break unless name.empty?
  prompt MESSAGES['valid_name']
end

prompt "Hi #{name}!"

loop do
  num1 = ''
  loop do
    prompt MESSAGES['first_number']
    num1 = gets.chomp
    break if valid_number?(num1)
    prompt MESSAGES['number_error']
  end

  num2 = ''
  loop do
    prompt MESSAGES['second_number']
    num2 = gets.chomp
    break if valid_number?(num2)
    prompt MESSAGES['number_error']
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt operator_prompt

  operator = ''
  loop do
    operator = gets.chomp
    break if %w(1 2 3 4).include?(operator)
    prompt MESSAGES['operator_error']
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result = case operator
           when '1'
             num1.to_i + num2.to_i
           when '2'
             num1.to_i - num2.to_i
           when '3'
             num1.to_i * num2.to_i
           when '4'
             num1.to_f / num2.to_f
           end

  prompt "The result is #{result}"

  prompt MESSAGES['another_calculation']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt MESSAGES['goodbye']
