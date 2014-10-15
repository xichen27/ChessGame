require './piece'
require './steppingpiece'
require './slidingpiece'

class Board
  attr_reader :board
  
  def initialize
    @board = generate_board
    populate
  end
  
  def generate_board
    @board = Array.new(8) { |y| Array.new(8) { |x| BlankPiece.new(self, [y, x], "_") }}
  end
  
  def populate
    #make sure to replace strings with objects
    #this should be black pieces
    @board[0][0] = Rook.new(self, [0, 0], "w")
    @board[0][1] = Knight.new(self, [0, 1], "w")
    @board[0][2] = Bishop.new(self, [0, 2], "w")
    @board[0][3] = Queen.new(self, [0, 3], "w")
    #@board[0][4] = King.new(self, [0, 4], "w")
    @board[0][5] = Bishop.new(self, [0, 5], "w")
    @board[0][6] = Knight.new(self, [0, 6], "w")
    @board[0][7] = Rook.new(self, [0,7], "w")
    #fill pawns
    (0..7).each do |i|
      @board[1][i] = Pawn.new(self, [1,i], "w")
    end
    
    #this should be white pieces
    @board[7][0] = Rook.new(self, [0, 0], "b")
    @board[7][1] = Knight.new(self, [0, 1], "b")
    @board[7][2] = Bishop.new(self, [0, 2], "b")
    @board[7][3] = Queen.new(self, [0, 3], "b")
    @board[7][4] = King.new(self, [0, 4], "b")
    @board[7][5] = Bishop.new(self, [0, 5], "b")
    @board[7][6] = Knight.new(self, [0, 6], "b")
    @board[7][7] = Rook.new(self, [0,7], "b")
    
    #fill pawns
    (0..7).each do |i|
      @board[6][i] = Pawn.new(self, [6,i], "b")
    end
    
    #testing stuffs
    @board[3][2] = Rook.new(self, [3,2], "b")
    @board[5][2] = King.new(self, [5,2], "w")
  end
  
  def display
    #watch out for object overload is 
    @board.each do |row|
      print row.to_s + "\n"
    end
    puts
  end
  
  def is_blank?(pos)
    @board[pos[0]][pos[1]].is_a?(BlankPiece)
  end
  
  def is_enemy?(pos,col)
    return false if @board[pos[0]][pos[1]].color == col or @board[pos[0]][pos[1]].color == '_'
    true
  end
  
  def in_range?(x)
     x.between?(0, 7)
  end
  
  def find_king_position(col)
    king_pos = []
    @board.each do |row|
      row.each do |piece|
        king_pos = piece.pos if piece.is_a?(King) && piece.color == col
      end
    end
    king_pos
  end
  
  def assemble_enemies(col)
    enemies = []
    @board.each do |row|
      row.each do |piece|
        enemies << piece if !piece.is_a?(BlankPiece) && piece.color != col
      end
    end
    enemies
  end
  
  def in_check?(col)
    enemies = []
    king_pos = []
    #find king's position
    king_pos = find_king_position(col)
    
    #assemble enemies
    enemies = assemble_enemies(col)
    
    #check if enemies moves includes king's position
    enemies.each do |enemy|
      return true if enemy.move.include?(king_pos)
    end
    
    false
  end
  
  def move(start, end_pos)
    y1, x1, y2, x2 = start[0], start[1], end_pos[0], end_pos[1]
    
    raise "No piece at start" if @board[y1][x1].is_a?(BlankPiece)
    raise "Not a valid move" unless @board[y1][x1].move.include?(end_pos)

    #update end position, then delete original position
    @board[y2][x2] = @board[y1][x1]
    @board[y1][x1] = BlankPiece.new(self, [y1, x1], "_")

  end
  
  def deep_dup
    
    dup = Board.new
    
    dup.board.each do |row|
      row.each do |piece|
        y, x = piece.pos
        dup.board[y][x].board = dup
        dup.board[y][x] = self.board[y][x].dup
        dup.board[y][x].pos = self.board[y][x].pos.dup
        # dup.board[y][x] = self.board[y][x].class.new(dup, piece.pos, piece.color )
      end
    end
    
    dup
  end
end

b = Board.new
#b.display 

# p b.board[1][3].move
# p b.board[5][2].pos
puts "original"
b.display

#b.move([1,3], [2,4])
c = b.deep_dup

c.board[1][1] = BlankPiece.new(c, [1, 1], "_")
b.display
c.display