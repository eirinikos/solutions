# codewars kata: don't eat the last cake!
# http://www.codewars.com/kata/5384df88aa6fc164bb000e7d/train/ruby


# codewars kata: josephus survivor
# http://www.codewars.com/kata/555624b601231dc7a400017a/train/ruby
# this solution is built on this solution:
# http://www.codewars.com/kata/reviews/55561d8f01231dce9a000156/groups/5556d6c40ce7853ff3000029
def josephus_survivor(n,k)
  # (1..n) people are put into the circle
  items = (1..n).to_a
  Array.new(n){items.rotate!(k-1).shift}.last
end


# codewars kata: validate sudoku with size n x n
# http://www.codewars.com/kata/validate-sudoku-with-size-nxn/train/ruby
# this solution is built on this solution:
# http://www.codewars.com/kata/reviews/5593733c289bb3285000000b/groups/56443537dd828c1c86000005
class Sudoku
  def initialize(board = [])
    @rows = board
    @size = @rows.size
    @root = Math.sqrt(@size)
  end

  def contains_all_n?(section)
    (1..@size).to_a.to_set == section.to_set
  end

  def is_valid
    # must contain n arrays, each of n length
    return false if !@rows.all?{|row| row.length == @size}
    blocks = @rows.map{|row| row.each_slice(@root).to_a}.transpose.flatten.each_slice(@size).to_a
    sudoku_sections = @rows + @rows.transpose + blocks
    sudoku_sections.all?{|section| contains_all_n?(section)}
  end
end


# codewars kata: sudoku solution validator
# http://www.codewars.com/kata/sudoku-solution-validator/train/ruby
def validSolution(board)
  array_of_boxes = Array.new
  box = Array.new
  i = 0

  add_box_array = lambda do
    3.times do
      3.times do
        row = board[i]
        box.push(row[0]).push(row[1]).push(row[2])
        i += 1
      end

      array_of_boxes << box
      box = Array.new
    end
  end

  reset_and_rotate = lambda do
    i = 0
    board.each{ |row| row.rotate!(3) }
  end

  add_reset_rotate = lambda do
    add_box_array.call
    reset_and_rotate.call
  end

  2.times {add_reset_rotate.call}
  add_box_array.call
  all_possible_arrays = (1..9).to_a.permutation.to_a

  # each row & each column is a unique permutation of base_array
  board.all?{ |row| all_possible_arrays.include?(row) } &&
  board.uniq.size == 9 &&
  board.transpose.all?{ |column| all_possible_arrays.include?(column) } &&
  board.transpose.uniq.size == 9 &&
  array_of_boxes.all? { |box| all_possible_arrays.include?(box) }
end


# codewars kata: josephus permutation
# http://www.codewars.com/kata/5550d638a99ddb113e0000a2/train/ruby
# for best solutions, see http://www.codewars.com/kata/5550d638a99ddb113e0000a2/solutions/ruby
def josephus(items,k)
  new_array = []
  while items.size > (k-1)
    new_array << items.delete_at(k-1)
    items.rotate!(k-1) 
  end
  while items.size > 0
    items.rotate!(k-1) 
    new_array << items.delete_at(0)
  end
  new_array
end


# codewars kata: word a9n (abbreviation)
# http://www.codewars.com/kata/word-a9n-abbreviation/train/ruby
class Abbreviator
  def self.abbreviate(string)
    string.split(%r{\b}).map{ |item|
     if %r([a-zA-Z]{4,}).match(item)
       item.replace("#{item[0]}#{item.size-2}#{item[-1]}")
     else
       item
     end
     }.join
  end
end


# codewars kata: format a string of names
# http://www.codewars.com/kata/format-a-string-of-names-like-bart-lisa-and-maggie/train/ruby
def list(names)
  array = names.map{|n| n.values}
  if array.size > 2
    array[0..-2].join(", ") + " & #{array[-1][0]}"
  else
    array.join(" & ")
  end
end

# refactored...
def list(names)
  array = names.map{|n| n.values}
  return array.join(" & ") if array.size < 2
  array[0..-2].join(", ") + " & #{array[-1][0]}"
end


# codewars kata: enigma machine (plugboard)
# http://www.codewars.com/kata/5523b97ac8f5025c45000900/train/ruby
class Plugboard
  def initialize(wires="")
    array = wires.split(%r{\s*})
    if array.none?{|i| !("A".."Z").include?(i)} && array.size.even? && (array.size/2)<11 && array==array.uniq
      # if array includes only char within "A".."Z" range
      # && if array is even and has 10 or less pairs of A..Z characters, all unique
      @wires = array
    else
      raise
    end
  end
  def process(wire)
    # @wires pairs char in even-odd index pairs: @wires[0] & @wires[1], and so on..
    if wire.size > 1
      "Please enter a single character."
    elsif !@wires.include?(wire)
      wire
    elsif @wires.index(wire).even?
      @wires[@wires.index(wire) + 1]
    else @wires.index(wire).odd?
      @wires[@wires.index(wire) - 1]
    end
  end
end

#refactored...
class Plugboard
  def initialize(wires="")
    @wires = wires
    raise if @wires.size.odd? || (@wires.size/2)>10 || @wires != @wires.chars.uniq.join
  end
  def process(wire)
    i = @wires.chars.index(wire)
    if wire.size > 1
      "Please enter a single character."
    elsif i.nil?
      wire
    elsif i.even?
      @wires[i+1]
    else i.odd?
      @wires[i-1]
    end
  end
end


# codewars kata: pentabonacci
# http://www.codewars.com/kata/55c9172ee4bb15af9000005d/train/ruby
def count_odd_pentaFib(n)
  array = [0,1,1,2,4,8]
  (5..n).each do |i|
    array[i] = array[i-5] + array[i-4] + array[i-3] + array[i-2] + array[i-1]
  end
  array.select{|i| i.odd?}.uniq!.count
end


# codewars kata: counting in the amazon
# http://www.codewars.com/kata/55b95c76e08bd5eef100001e/train/ruby
def count_arara(n)
  arara_array = []
  (n/2).times{ |i| arara_array << "adak" }
  (n%2).times{ |i| arara_array << "anane" }
  arara_array.join(" ")
end

#refactored...
def count_arara(n)
  (["adak"] * (n/2) + ["anane"] * (n%2)).join(" ")
end


# codewars kata: is a number prime?
# http://www.codewars.com/kata/is-a-number-prime
def isPrime(num)
# returns whether num is a prime number
  num > 1 && (2...num).none?{|n| num % n == 0}
end


# codewars kata: vasya and stairs
# http://www.codewars.com/kata/vasya-and-stairs/train/ruby
def numberOfSteps(steps, m)
  ((steps/2 + steps%2)..steps).find{ |n| n%m==0 } || -1
end


# codewars kata: sum of top-left to bottom-right diagonals
# http://www.codewars.com/kata/5497a3c181dd7291ce000700/train/ruby
def diagonalSum(matrix)
  (0...matrix.size).map { |i| matrix[i][i] }.reduce(&:+)
end


# codewars kata: musical pitch classes
# http://www.codewars.com/kata/musical-pitch-classes/solutions/ruby/me/best_practice
def pitch_class(note)
  array_with_sharps = [
  'B#', 'C#', 'D', 'D#', 'E', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  array_with_flats = [
  'C','Db', 'D', 'Eb', 'Fb', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'Cb']
  
    array_with_sharps.index(note) ||
    array_with_flats.index(note)
end