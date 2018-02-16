######PAIRING PROMPTS######

# ### Ping Pong Filter ####
# Imagine that we have a filter that goes through an array and removes every other
# element. When it reaches the final element it turns around and does the whole
# process again, this time going from the end to the start. It repeats this
# behavior until there is only one element left.
#
# For example:
# Given a starting array [1, 2, 3, 4, 5, 6, 7, 8]
# We start from the beginning and remove every other element (indicated with !)
# [!1, 2, !3, 4, !5, 6, !7, 8] = [2, 4, 6, 8]
# Next we start from the end and remove every other element
# [2, !4, 6, !8] = [2, 6]
# Now we start from the beginning again and remove every other element
# [!2, 6] = [6]
#
# Write a method that takes an array of elements. It should return the only
# element that would remain after filtering the array in the manner described
# above.
#
# Examples:
# ping_pong_filter([1, 2, 3, 4, 5, 6, 7, 8]) # => 6
# ping_pong_filter([1, 2, 3, 4]) # => 2
# ping_pong_filter([3, 5, 7, 8, 9, 2]) # => 8

def ping_pong_filter(arr)
  result = arr.dup
  while result.length > 1
    result = result.select.with_index do |el, idx|
      el if idx % 2 != 0
    end
    result = result.reverse
  end
  result
end

# p ping_pong_filter([3, 5, 7, 8, 9, 2])


### Rock Paper Scissors Bot ###

# 'Rock Paper Scissors' is a simple game for two people. Each player simultaneously
# selects either 'rock', 'paper', or 'scissors',
#
# The winner is determined according to the following rules:
# - 'rock' wins over 'scissors'
# - 'scissors' wins over 'paper'
# - 'paper' wins over 'rock'
#
# Rocky is a robot programmed to play 'Rock Paper Scissors'. He always follows
# the same strategy every time he plays. He keeps track of what move his opponent
# has been playing the most and plays the corresponding counter move. If his
# opponent has not favored any particular move over all other moves then Rocky
# will play a random move.

# Write a function that takes a string of moves. It should return a string of
# moves that Rocky would make in response. Represent a random move with an 'x'.
#
# rps_bot("rrrr") # => "xppp"
# rps_bot("srrr") # => "xrxp"
# rps_bot("rprs") # => "xpxp"
# rps_bot("srpsrp") # => "xrxxrx"
# rps_bot("rpsssprrr") # => "xpxxrrrrx"

def rps_bot(str)
  # probably scan the string and generate a counter hash
  player_moves_made = Hash.new(0)
  bot_move_response = "x"

  str.chars.each_with_index do |el, idx|
    player_moves_made[el] += 1
    bot_move_response += gen_bot_move(player_moves_made) unless idx == str.length - 1
  end
  # output string of same length as a response
  bot_move_response
end

def gen_bot_move(prev_player_moves)
  trending_move = nil
  trending_move_count = 0

  prev_player_moves.each do |k, v|
    trending_move = 'x' if trending_move.nil?
    if v > trending_move_count
      trending_move = k.to_s
      trending_move_count = v
    elsif v == trending_move_count
      trending_move = 'x'
    end
  end

  case trending_move
  when 'r'
    return 'p'
  when 's'
    return 'r'
  when 'p'
    return 's'
  when 'x'
    return 'x'
  end

end

p rps_bot("rpsssprrr")
# => "xpxxrrrrx"
     "xpxxrrrrxp"

# ### Pascal's Triangle ####
# This is an example of Pascal's Triangle:
#
#  depth
#    0   |      1
#    1   |     1 1
#    2   |    1 2 1
#    3   |   1 3 3 1
#    4   |  1 4 6 4 1
#
#
# Pascal's Triangle is a mathematical construct that follows a simple
# rule: each number in the triangle is the sum of the two numbers
# directly above-and-to-the-left and above-and-to-the-right of it.
#
# For example, to find the next row after [1,2,1]:
#
#         1       2       1
#
#     1       3       3       1
#     |       |       |       |
#  (0 + 1) (1 + 2) (2 + 1) (1 + 0)
#
#
# Write a function that will return Pascal's Triangle at the given
# depth. The triangle should be represented as an array of rows.
#
# pascals_triangle(0) => [[1]]
# pascals_triangle(2) => [[1], [1,1], [1,2,1]]
# pascals_triangle(4) => [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1]]


# ### Letter Reducer ####
# Write a method that takes a string that contains only 3 distinct
# characters - 'x', 'y', 'z' - and reduces it until it cannot be reduced
# any further.
#
# A string is reduced by replacing a pair of repeated characters with a
# single instance of the character that comes next in the limited
# alphabet:
#
# 'xx' is reduced to 'y'
# 'yy' is reduced to 'z'
# 'zz' is reduced to 'x'
#
# Reduce only one pair at a time. When there are multiple pairs that can
# be reduced, you should always reduce the left-most pair.
#
# Examples:
# letter_reducer('yxx') => 'yy' => 'z'
# letter_reducer('z') => 'z'
# letter_reducer('zzxxy') => 'xxxy' => 'yxy'
def letter_reducer(str)
  str_arr = str.split('')
  legend = {
    'xx' => 'y',
    'yy' => 'z',
    'zz' => 'x'
  }
  
  done = false 
    while done == false
      done = true 
      changed = false 
      idx = 0 
      # customize iteration to stay on the same scanned position if we do a swap
      while idx < str_arr.length - 1 #no need to check last element
        dbl_letter_chunk = legend[str_arr[idx] + str_arr[idx+1]]
        if dbl_letter_chunk
          str_arr[idx] = dbl_letter_chunk
          str_arr.delete_at(idx+1)
          done = false
        end 
        idx += 1
      end 
    end 
  str_arr
end
# p letter_reducer('zzxxy')

#### Math Eval ####
# Eval is a function that takes a string and executes it as code. This
# can be very complicated to implement, so you will only need to
# implement a small subset.
#
# Write a function math_eval that takes a string and evaluates single-digit
# numbers as well as the 4 basic arithmetic functions ( + - * / ). Do not worry about
# parentheses or order of operations. Just evaluate everything from left
# to right. You may also assume that you will be given syntactically
# correct statements with no spaces or extra characters.
#
# Constraint: You may not call eval or any similar function.
#
# Examples:
# math_eval('5') #=> 5
# math_eval('5+5') #=> 10
# math_eval('1+2*3') #=> 9
#
# Bonus: If you have extra time, support double-digit numbers.
# math_eval('10*2/5+16') => 20


#### Thrice Dice ####
# Thrice dice is a game played with five six-sided dice. Write a
# function thrice_dice that takes an array of five dice values and
# scores a throw according to these rules:
#
# Three 1's => 1000 points
# Three 6's =>  600 points
# Three 5's =>  500 points
# Three 4's =>  400 points
# Three 3's =>  300 points
# Three 2's =>  200 points
# One   1   =>  100 points
# One   5   =>   50 point
#
# The order of the dice is irrelevant, but a single die can only be
# counted once in each roll. If there are multiple ways to score the
# dice, return the one with the largest score.
#
# examples:
# thrice_dice([5, 1, 3, 4, 1]) #=> 50 + 100 + 100 = 250
# thrice_dice([1, 1, 1, 3, 1]) #=> 1000 + 100 = 1100
# thrice_dice([2, 4, 4, 5, 4]) #=> 400 + 50 = 450







######HARD SOLO PROMPTS######

#### Five Sort ####
# Write a function that receives an array of numbers as an argument.
# It should return the same array with the fives moved to the end.
# The ordering of the other elements should remain unchanged.
#
# For example:
# nums = [1, 5, 3, 5, 5, 2, 3]
# sorted = five_sort(nums)
# sorted #=> [1, 3, 2, 3, 5, 5, 5]
#
# Rules
# * You may not, at any time, create a new array.
# * You are only permitted to use a 'while' loop
# * You are not permitted to call any methods on the array. Only the
#    use of [], []=, and length are permitted.


#### Aliquot Sequence ####
# A number's aliquot sum is the sum of all of its factors excluding itself.
#
# For example, the aliquot sum of 10 is: 1 + 2 + 5 = 8
#
# We can use the aliquot sum to define a special sequence, called the
# aliquot sequence. The aliquot sequence of a number begins with the
# number itself. The second number in the sequence is the first number's
# aliquot sum, the third number is the second number's aliquot sum, and
# so on.
#
# For example, the first 4 numbers in the aliquot sequence of 10 are: 10, 8, 7, 1
#
# Write a function that takes in two numbers, base and n, and returns the
# aliquot sequence of length n starting with base.
#
#
# # Examples:
# aliquot_sequence(10, 4) # => [10, 8, 7, 1]
# aliquot_sequence(10, 2) # => [10, 8]
# aliquot_sequence(7, 4) # => [7, 1, 0, 0]


#### Next Prime ####
# Given an array of numbers, replace each prime number in the array with
# the next prime number, e.g. 7 is replaced by 11.
#
# Constraint: You may not use a library to find prime numbers.
#
# examples:
# next_prime([11,13,17]) #=> [13, 17, 19]
# next_prime([4,6,8,10]) #=> [4,6,8,10]
# next_prime([2,5,4,7]) #=> [3,7,4,11]


######MEDIUM SOLO PROMPTS######

#### Unique Items ####
# Write a function that takes in an array. It should return a new array
# containing only the elements that were unique in the original array.
#
# For example:
# ary = [1, 5, 5, 7, 16, 8, 1, 8]
# unique = unique_items(ary)
# unique # => [7, 16]


#### Pair Sum ####
# Write a function that accepts an array of numbers and a target.
# Find the pairs of indices whose elements sum to the target.
# No pair should appear twice in the result.
#
# Example 1:
# target = 10
# ary = [2, 4, 8]
# pairs = pair_sum(ary, target)
# pairs # => [[0, 2]]
#
# Example 2:
# target = 3
# ary = [1, 3, 0, 2, 1]
# pairs = pair_sum(ary, target)
# pairs # => [[0, 3], [1, 2], [3, 4]]


#### Decode ####
# You are given an encoded string. The code is defined as follows:
# * Each character in the encoded string is followed by a single-digit number.
# * The number represents how many times the character appears in a row.
#
# Write a function that takes in an encoded string and returns the original.
#
# Example:
# encoded_string = "m1i1s2i1s2i1p2i1"
# decoded_string = decode(encoded_string)
# decoded_string # => "mississippi"


#### HK Phone Number ####
# In Hong Kong, phone numbers are formatted as
# "xxxx xxxx" where "x" is any numerical digit (0-9). Write a function
# that determines whether a given string is a valid Hong Kong phone number.
#
# constraint: You may not use RegExp.

# examples:
# hk_phone_number?('1234 5678') #=> true
# hk_phone_number?('ar32 t19i') #=> false
# hk_phone_number?('123 45678') #=> false
# hk_phone_number?('12345678') #=> false
# hk_phone_number?('1234 567') #=> false
# hk_phone_number?('12345 12345') #=> false