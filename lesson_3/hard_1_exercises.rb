# Question 4
def create_uuid
  characters = []
  ('0'..'9').each { |digit| characters << digit }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ''
  32.times { uuid << characters.sample }
  [20, 16, 12, 8].each { |index| uuid.insert(index, '-') }

  uuid
end

puts create_uuid

# Question 5
def is_a_number?(word)
  word.to_i.to_s == word
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4
  dot_separated_words.each { |word| return false unless is_a_number?(word) }
  true
end

puts dot_separated_ip_address?("10.4.5.11")
puts dot_separated_ip_address?("10.4.5")
puts dot_separated_ip_address?("10.4.5.11.12")
puts dot_separated_ip_address?("bb.4.5.aa")

