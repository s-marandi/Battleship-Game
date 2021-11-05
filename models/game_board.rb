
require 'set'

class GameBoard

  attr_reader :max_row, :max_column

  def initialize(max_row, max_column)
    @attacks_set = Set.new
    @max_row = max_row
    @ships_set = Set.new
    @max_column = max_column
  end

  def add_ship(ship)
    case_check = ship.orientation
    column = ship.start_position.column # the column in integer form
    row = ship.start_position.row # row
    size = ship.size.to_i # size of the ship

    case case_check
    when 'Right'
      first_check = column + size - 1
      return false if ((first_check) > @max_column) || row < 1 || row > @max_row || column < 1

      current_ship_positions = Set.new
      while size.positive?
        current_ship_positions.add("(#{row}, #{column})")
        column += 1
        size -= 1
      end
      # if there is an intersection, there is an overlap
      if current_ship_positions.intersect? @ships_set
        false
      else
        @ships_set = @ships_set.union current_ship_positions
        true
      end

    when "Left"
      return false if ((column - (size - 1)) < 1) || row < 1 || row > @max_row || column > @max_column

      current_ship_positions = Set.new
      while size.positive?
        current_ship_positions.add("(#{row}, #{column})")
        column -= 1
        size -= 1
      end
      # if there is an intersection, there is an overlap
      if current_ship_positions.intersect? @ships_set
        false
      else
        @ships_set = @ships_set.union current_ship_positions
        true
      end
    when "Up"
      if ((row - (size - 1)) < 1) || column < 1 || column > @max_column || row > @max_row
        return false
      end

      current_ship_positions = Set.new
      while size.positive?
        current_ship_positions.add("(#{row}, #{column})")
        row -= 1
        size -= 1
      end
      # if there is an intersection, there is an overlap
      if current_ship_positions.intersect? @ships_set
        false
      else
        @ships_set = @ships_set.union current_ship_positions
        true
      end
    when "Down"
      return false if ((row + (size - 1)) > @max_row) || column < 1 || column > @max_column || row < 1

      current_ship_positions = Set.new
      while size.positive?
        current_ship_positions.add("(#{row}, #{column})")
        row += 1
        size -= 1
      end
      # if there is an intersection, there is an overlap
      if current_ship_positions.intersect? @ships_set
        false
      else
        @ships_set = @ships_set.union current_ship_positions
        true
      end
    else
      false
    end
  end

  def attack_pos(position)
    row = position.row
    column = position.column
    return nil if row > @max_row || column < 1 || column > @max_column || row < 1

    new_position = position.to_s
    @attacks_set.add(new_position)

    @ships_set.include? new_position
  end

  def num_successful_attacks
    (@ships_set.intersection @attacks_set).size
  end

  def all_sunk?
    (@ships_set.intersection @attacks_set).size == @ships_set.size
  end

end

