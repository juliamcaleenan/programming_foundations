# Question 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
p flintstones
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones

# Question 2
flintstones << "Dino"
p flintstones

# Question 3
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.insert(-1, "Dino", "Hoppy")
p flintstones

# Question 4
advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(0, advice.index('house'))
p advice

# Question 5
statement = "The Flintstones Rock!"
p statement.count('t')

# Question 6
title = "Flintstone Family Members"
p title.center(40)