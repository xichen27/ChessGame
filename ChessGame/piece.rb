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
  
  

end

class BlankPiece < Piece
                  
  def initialize(board, pos, color)
    super
  end
  
  def move
    "BlankPiece doesn't have a move method"
  end
  
  def inspect
    "_"
  end
  
end

class Pawn < Piece 

  def move
    moves = []
    if self.color == "w"
      moves << [@pos[0] + 1, @pos[1]]
    else
      moves << [@pos[0] - 1, @pos[1]]
    end 
    moves
  end
  
  def inspect
    "P"
  end

end

