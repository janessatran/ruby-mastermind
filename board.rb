# Board for games
class Board
  def initialize
    @board = []
  end

  def print
    puts @board
  end

  def update(guess, response)
    @board << guess.to_s + ' - ' + response.to_s
  end
end