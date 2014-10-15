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
    moves = []
    #moves << [@pos[0] - 1, @pos[1] ] if @board.is_blank?([@pos[0] - 1, @pos[1]])
    if self.color == "w"
      moves << [@pos[0] + 1, @pos[1] ] if @board.is_blank?([@pos[0] + 1, @pos[1]])
    elsif self.color == "b"
      moves << [@pos[0] - 1, @pos[1] ] if @board.is_blank?([@pos[0] - 1, @pos[1]])
    end
    moves+capture
  end
  
  def capture
    moves = []
    if @color == "w"
       moves << [@pos[0] + 1, @pos[1]- 1 ] if @board.is_enemy?([@pos[0] + 1, @pos[1]- 1 ], @color)
       moves << [@pos[0] + 1, @pos[1] + 1 ] if @board.is_enemy?([@pos[0] + 1, @pos[1] + 1 ], @color)
    else 
      moves << [@pos[0] - 1, @pos[1] - 1 ] if @board.is_enemy?([@pos[0] - 1, @pos[1] - 1 ], @color)
      moves << [@pos[0] - 1, @pos[1] + 1 ] if @board.is_enemy?([@pos[0] - 1, @pos[1] + 1 ], @color)
    end
    moves
  end
    
  
  def inspect
    "#{color}P"
  end

end

