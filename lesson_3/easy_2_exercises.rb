# Question 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.include?("Spot")
p ages.has_key?("Spot")
p ages.member?("Spot")

# Question 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
sum = 0
ages.each { |name, age| sum += age }
puts sum

puts ages.values.inject(:+)

# Question 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.select! { |name, age| age < 100 }
p ages

# Question 4
munsters_description = "The Munsters are creepy in a good way."

puts munsters_description.capitalize
puts munsters_description.swapcase
puts munsters_description.downcase
puts munsters_description.upcase

# Question 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)
p ages

# Question 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts ages.values.min

# Question 7
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.match("Dino")
p advice.match("dino")
p advice["Dino"]
p advice["dino"]

# Question 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.index { |name| name.start_with?("Be") }

# Questions 9 and 10
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0, 3] }
p flintstones