# Question 3
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!("important", "urgent")
puts advice

# Question 5
num = 42
puts (10..100).include?(num)

# Question 6
famous_words = "seven years ago..."
puts "Four score and " + famous_words
puts "Four score and #{famous_words}"

# Question 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
flintstones.flatten!
p flintstones

# Question 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
p flintstones.to_a[2]
p flintstones.assoc("Barney")

# Question 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones.each_with_index { |name, index| flintstones_hash[name] = index }
p flintstones_hash