require './board'

class ChessError < StandardError; end


class Game
  def initialize(p1,p2)
    @p1 = p1
    @p2 = p2
    @board = Board.new
    p1_color = "w"
    p2_color = "b"
    @turn = "w"
  end
  
  def play
  
    until @board.checkmate?(@turn)
      @board.display
      
      begin
        moves = (@turn == "w") ? @p1.play_turn : @p2.play_turn
        start,end_pos = moves[0],moves[1]
        
        raise ChessError.new("You can't control your opponent") unless @turn == @board.board[start[0]][start[1]].color
        @board.move(start,end_pos)
      rescue ChessError => e
        puts "wow such error"
        puts "#{e.message}"
        retry
      end
      @turn = (@turn == "w")? "b" : "w"
    end
    
    return "#{@p1.name} is the winner" if @turn == "w"
    return "#{@p2.name} is the winner" if @turn == "b"
    
    
  end 
end

class HumanPlayer
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def play_turn
    puts "#{@name}, please select a starting a position."
    start_pos = gets.chomp.split(',').map{|n| n.to_i}
    puts "#{@name},please select a end position."
    end_pos = gets.chomp.split(',').map{|n| n.to_i}
    
    [start_pos, end_pos]
  end
end

h1 = HumanPlayer.new("J")
h2 = HumanPlayer.new("X")
g = Game.new(h1,h2)
g.play