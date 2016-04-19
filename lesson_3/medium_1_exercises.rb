# Question 1
text = "The Flintstones Rock!"
10.times { |num| puts (" " * num) + text }

# Question 2
statement = "The Flintstones Rock"

letter_frequency = {}
statement.delete(' ').chars.each do |letter|
  if letter_frequency.has_key?(letter)
    letter_frequency[letter] += 1
  else 
    letter_frequency[letter] = 1
  end
end

p letter_frequency

# Launch School solution
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

p result

# Question 3
# puts "the value of 40 + 2 is " + (40 + 2)
puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " + (40 + 2).to_s

# Question 5
def factors(number)
  dividends = (1..number)
  divisors = []
  dividends.each do |dividend|
    divisors << number / dividend if number % dividend == 0
  end
  divisors.sort!
end

p factors(20)
p factors(0)
p factors(-1)

# Question 7
def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

# Question 8
munsters_description = "The Munsters are creepy in a good way."

def titleize(text)
  text.split.map { |word| word.capitalize }.join(' ')
end

puts titleize(munsters_description)
puts munsters_description

# Question 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, values|
  case values["age"]
  when 0..17
    values["age_group"] = "kid"
  when 18..64
    values["age_group"] = "adult"
  else
    values["age_group"] = "senior"
  end
end

p munsters



