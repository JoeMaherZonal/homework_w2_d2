require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'dice'
require_relative 'viewer'

class SnakeAndLadders

  def initialize(dice, viewer)
    @dice = dice
    @viewer = viewer

    positions = rand_snakes_and_ladders_and_auto_win()

    board = Board.new(27, positions)

    player_1_name = @viewer.get_player_name(1)
    player_2_name = @viewer.get_player_name(2)

    player1 = Player.new(player_1_name)
    player2 = Player.new(player_2_name)

    players = [player1,player2]
    @game = Game.new(players,board)
  end

  def rand_snakes_and_ladders_and_auto_win()
    positions = rand_snakes()
    positions = rand_ladders(positions)
    positions[10] = 16

    #auto-win if land of position 10
    return positions
  end

  def rand_ladders(positions)
    count = 4
    while count > 0
      positions[rand(2..15)] = rand(2..11)
      count -= 1
    end
    return positions
  end

  def rand_snakes()
    #snakes
    positions = {}
    count = 4
    while count > 0
      positions[rand(14..26)] = rand(-13..-3)
      count -= 1
    end
    return positions
  end

  def run()
    while(!@game.is_won?)
      @viewer.start(@game.current_player.name)
      @game.next_turn(@dice.roll)
      @viewer.show_update(@game.log.last)
    end

    @viewer.end(@game.winner.name)
  end

end

game = SnakeAndLadders.new(Dice.new, Viewer.new)
game.run()
