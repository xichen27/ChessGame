#require 'debugger'

class Piece
  attr_reader :pos, :p, :color
  attr_writer :pos, :board
  
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end
  
  def move
    puts "Make sure to make a move method"
  end
  
  def inspect
    "Whatever"
  end
  
  def move_into_check?(check_pos)
    test_board = @board.deep_dup 
    test_board.move!(@pos, check_pos)
    test_board.in_check?(@color)
  end
  
  def valid_moves
    #puts "here are the moves"

    move.select{ |m| !move_into_check?(m) }
  end

end

class BlankPiece < Piece
                  
  def initialize(board, pos, color)
    super
  end
  
  def move
    "BlankPiece doesn't have a move method"
  end
  
  def inspect
    "__"
  end
  
end

class Pawn < Piece 
  
  def move
    vert_hash = {"w" => [1, 0], "b" => [-1, 0]}
    moves = []
    
    vert = [@pos[0] + vert_hash[@color][0] , @pos[1] + vert_hash[@color][1]]
    moves << vert if @board.is_blank?(vert)
    
    moves + capture
  end
  
  def capture
    diag_hash = {"w" => [[1, -1], [1, 1]], "b" => [[-1, -1], [-1, 1]]}
    diag_moves = []
    
    diag_hash[@color].each do |delta|
      diag_pos = [@pos[0] + delta[0], @pos[1] + delta[1] ]
      diag_moves << diag_pos if @board.is_enemy?(diag_pos, @color)
      #debugger
    end
    diag_moves
  end
    
  
  def inspect
    "#{color}P"
  end

end

