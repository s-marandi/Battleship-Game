require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
# TODO returning nil after 5 ships are not added
def read_ships_file(path)
  game_board = GameBoard.new 10, 10
  counter = 0
  file = path # Might need to convert path to string
  if read_file_lines(path) # Should return true or false
    File.readlines(file).each do |line| # Need to check line format later
      next unless line.match(/\((\d*),(\d*)\), (Right|Down|Left|Up), (\d*)/)
      break if counter == 5
      next unless counter < 5
      line =~ (/\((\d*),(\d*)\), (Right|Down|Left|Up), (\d*)/)
      position = Position.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i) # Create a new position
      ship = Ship.new(position, Regexp.last_match(3), Regexp.last_match(4).to_i) # Create a new ship
      counter += 1 if game_board.add_ship(ship)
    end
    if counter < 5
      return nil
    end
  end
  game_board
end
# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
  array_of_att = []
  file = path # Might need to convert path to string
  if read_file_lines(path)
    File.readlines(file).each do |line| # Need to check line format later (1,2)
      next unless line.match(/\((\d+),(\d+)\)/)
      line =~ (/\((\d+),(\d+)\)/)
      new_pos = Position.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i)
      array_of_att.push(new_pos)
    end
    return array_of_att
  end
  nil
end
# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
  return false unless File.exist? path

  if block_given?
    File.open(path).each do |line|
      yield line
    end
  end

  true
end