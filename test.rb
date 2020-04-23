def anagram?(first_word, second_word)
    first_word.gsub(' ', '').downcase.each_char.sort == second_word.gsub(' ', '').downcase.each_char.sort
end


puts "enter first word: "
first_word =  gets


puts "enter second word: "
second_word = gets

anagram = anagram?(first_word, second_word) ? "Yes" : "No"
puts "2 words are anagram? #{anagram}"