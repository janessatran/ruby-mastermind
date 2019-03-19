# Command Line Mastermind Game
class Mastermind
  attr_reader :player_score, :computer_score, :player_guess,
              :game_count, :board, :turn_count

  private

  attr_writer :master_code, :player_score, :computer_score,
              :player_guess, :game_count, :board

  def initialize
    set_master_code
    reset_board
    reset_scores
    reset_turn_count
    display_rules
    start_game
  end

  def reset_turn_count
    @turn_count = 0
  end

  def set_master_code
    @master_code = Array.new(4) { rand(2...8) }
  end

  def reset_scores
    @player_score = 0
    @computer_score = 0
  end

  def reset_board
    @board = Array.new(12) { Array.new(4) }
  end

  def display_rules
    print 'Welcome to Mastermind! A 4 letter code has been set by the mastermind. ' \
          'You win if you can guess the 4 letter code in 12 turns. ' \
          'After each guess, the mastermind will return the numbers 0 or 1. ' \
          'Each "1" indicates that one of the guessed numbers is correct, but in the wrong place. ' \
          'Each "2" indicates that one of the guessed numbers is correct and in the correct place. ' \
          'You may guess any value between 2 - 7 inclusive. ' \
          'Goodluck!!'
  end

  def update_game_count
    @game_count.nil? ? @game_count = 1 : @game_count += 1
  end

  def check_guess_valid?(g)
    return true if (g.is_a? Array) && (g.length = 4) && ((2..8).to_a & g)
  end

  def start_game
    update_game_count
    prompt_guess if check_ready?
    update_board if check_guess_valid?(player_guess)
  end

  def check_ready?
    puts 'Are you ready to play? (Y/N)'
    return true if gets.chomp == 'Y' || gets.chomp == 'yes' || gets.chomp == 'y'
  end

  def prompt_guess
    puts 'Attempt to guess the mastercode. Enter an array of numbers 2 through 7. (i.e. [1,4,2,4]'
    @player_guess = gets.chomp
  end

  def update_board
    board[turn_count] = player_guess
    print_board
  end

  def print_board
    puts(board.map { |x| x.join(' ') })
  end

end
