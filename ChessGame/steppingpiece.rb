require "./piece"

class SteppingPiece < Piece
  
  def move
    moves = []
    steps.each do |step|
      y = self.pos[0] + step[0]
      x = self.pos[1] + step[1]
      moves << [y, x]
    end
    moves
  end
end

class King < SteppingPiece
 STEPS = [
    [1, 0],
    [1, -1],
    [1, 1],
    [0, -1],
    [0, 1],
    [-1, -1],
    [-1, 0],
    [-1, -1]
  ]
  def steps
    STEPS
  end    
  
  def inspect
    "K"
  end       
end

class Knight < SteppingPiece

  STEPS = [
     [1, 2],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [2, 1],
     [2, -1],
     [-2, 1],
     [-2, -1]
   ]
   def steps
     STEPS
   end    
   
   def inspect
     "H"
   end       
 end