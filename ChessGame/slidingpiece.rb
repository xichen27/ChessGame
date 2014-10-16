require './piece'

class SlidingPiece < Piece
  HORIZONTAL_DIRS = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  DIAGONAL_DIRS = [-1, 1].product([1, -1])
  def move 
    moves = []
     @move_dirs.each do |dir|
       i = 1 # TA: iterate!
       y = pos[0]
       x = pos[1]
       
       until !@board.in_range?([x + dir[1]*i, y + dir[0]*i])
         dy, dx = x + dir[1]*i, y + dir[0]*i
         if @board.is_enemy?([dy, dx] , @color )
           moves << [dy, dx]
           break
         elsif !@board.is_blank?([dy, dx])
           break
         end
         moves << [dy, dx]
         i += 1 
       end
     end
    moves
  end
  
end

class Rook < SlidingPiece
  
  def initialize(*args)
    super(*args)
    @move_dirs = SlidingPiece::HORIZONTAL_DIRS
  end
  
  def inspect
    "#{color}R"
  end
  
end

class Bishop < SlidingPiece
  
  def initialize(*args)
    super(*args)
    @move_dirs = SlidingPiece::DIAGONAL_DIRS
  end
  
  def inspect
    "#{color}B"
  end
  
end

class Queen < SlidingPiece
  
  def initialize(*args)
    super(*args)
    @move_dirs = SlidingPiece::DIAGONAL_DIRS + SlidingPiece::HORIZONTAL_DIRS
  end
  
  def inspect
    "#{color}Q"
  end
  
end



