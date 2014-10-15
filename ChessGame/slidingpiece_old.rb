require './piece'

class SlidingPiece < Piece
  HORIZONTAL_DIRS = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  DIAGONAL_DIRS = [1, 1].product([-1, -1])
  
  def move
  end
end

class Rook < SlidingPiece
  
  def initialize(args)
    @move_dirs = SlidingPiece::HORIZONTAL_DIRS
    super(args)
  end
  
  def move 
    vertical_moves+horizontal_moves
  end
  
  #let's find rows
  def horizontal_moves
    @move_dirs.each do |dir|
      
    end
    moves = []
    #this checks the top part
    i = 1 # TA: iterate!
    until pos[1] - i < 0 || !@board.is_blank?([pos[0], (pos[1] - i)])
      moves << [pos[0], (pos[1] - i)] 
      i += 1
    end
    
    #check lower part
    i = 1
    until pos[0] + i  > 7 || !@board.is_blank?([pos[0], (pos[1] + i)])
      moves << [pos[0], (pos[1] + i)]
      i += 1 
    end
    
    moves
  end
  
  def vertical_moves
    moves = [] 
    #this checks the top part
    i = 1
    until pos[0] - i < 0 || !@board.is_blank?([pos[0] - i, pos[1]])
      moves << [pos[0] - i, pos[1]]
      i += 1
    end
    
    #check lower part
    i = 1
    until pos[0] + i > 7 || !@board.is_blank?([pos[0] + i, pos[1]])
      moves << [pos[0] + i, pos[1]]
      i += 1 
    end
    
    moves
  end
  
  def inspect
    "R"
  end
  
end

class Bishop < SlidingPiece
  
  def inspect
    "B"
  end
end

class Queen < SlidingPiece
  def inspect
    "Q"
  end
end


