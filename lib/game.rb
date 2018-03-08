class Game

  attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
                       [0,1,2],
                       [3,4,5],
                       [6,7,8],
                       [0,3,6],
                       [1,4,7],
                       [2,5,8],
                       [0,4,8],
                       [2,4,6]
                     ]

  def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new())
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    self.board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def over?
    self.board.cells.all? do |cell|
      cell != " "
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      self.board.cells[combo[0]] == self.board.cells[combo[1]] && self.board.cells[combo[1]] == self.board.cells[combo[2]] && self.board.cells[combo[2]] != " "
    end
  end

  def draw?
    self.over? && !self.won?
  end

  def winner
    self.won? == nil ? nil : self.board.cells[self.won?[0]]
  end

  def turn
    @current_player = self.current_player
    @move = current_player.move(self.board)
    if self.board.valid_move?(@move)
      self.board.update(@move)
      self.board.display
      current_player == self.player_1 ? current_player = self.player_2 : current_player = self.player_1
    else
      puts "Please input a valid move"
    end
  end

  def play
    # until self.over?
    #   self.turn
    # end
    #
    # if self.won?
    #   puts "Congratulations #{self.winner}!"
    # elsif self.draw?
    #   puts "Cat's Game!"
    # end
  end

end
