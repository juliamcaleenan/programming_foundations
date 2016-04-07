def prompt(message)
  puts "=> #{message}"
end

prompt "Welcome to the mortgage calculator!"

loan_amount = ''
loop do
  prompt "What is the loan amount in £?"
  loan_amount = gets.chomp
  break if loan_amount.to_f > 0
  prompt "That is not a valid amount"
end

annual_rate = ''
loop do
  prompt "What is the annual interest rate?"
  prompt "Example: enter 5 for 5% or 3.5 for 3.5%"
  annual_rate = gets.chomp
  break if annual_rate.to_f > 0 && annual_rate.to_f < 100
  prompt "That is not a valid amount"
end

loan_duration = ''
loop do
  prompt "What is the loan duration in months?"
  loan_duration = gets.chomp
  break if loan_duration.to_i > 0
  prompt "That is not a valid amount"
end

monthly_rate = annual_rate.to_f / 100 / 12

monthly_payment = loan_amount.to_f *
                  (monthly_rate * (1 + monthly_rate)**loan_duration.to_i) /
                  ((1 + monthly_rate)**loan_duration.to_i - 1)

prompt "Your monthly payment amount is £#{format('%02.2f', monthly_payment)}"
