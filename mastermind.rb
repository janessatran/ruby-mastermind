# Command Line Mastermind Game
class Mastermind
  attr_reader :player_score, :master_score, :player_guess,
              :game_count, :board, :guess_count, :guess

  private

  attr_writer :master_code, :player_score, :master_score,
              :player_guess, :game_count, :board, :guess_count,
              :guess

  def initialize
    set_master_code
    reset_board
    reset_scores
    reset_guess_count
    display_rules
    start_game
  end

  def reset_guess_count
    @guess_count = 0
  end

  def set_master_code
    @master_code = Array.new(4) { rand(2...8) }
  end

  def reset_scores
    @player_score = 0
    @master_score = 0
  end

  def reset_board
    @board = Array.new(12) { Array.new(4) }
    @win = false
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

  def check_guess_valid?(guess)
    return true if (guess.is_a? Array) && (guess.length == 4) && (guess.count { |e| e.between?(2,8) } == 4)
  end

  def start_game
    update_game_count
    if check_ready?
      until game_over?
        prompt_guess
        if check_guess_valid?(guess)
          update_board
          analyze_input
          print_board
        else
          prompt_guess
        end
      end
      determine_winner
    end
  end

  def determine_winner
    if @win
      puts 'HOORAY! YOU CRACKED THE CODE'
      puts @master_code
      puts "in #{guess_count} tries!"
      @player_score += 1
    else
      puts 'Mastermind has out master-minded you... :('
      puts @master_code
      puts '... Better luck next time!'
      @master_score += 1
    end
    puts 'Player Score, Mastermind Score'
    puts "#{player_score}, #{master_score}"
  end

  def game_over?
    @win || guess_count == 12
  end

  def check_ready?
    puts 'Are you ready to play? (Y/N)'
    return true if gets.chomp == 'Y' || gets.chomp == 'yes' || gets.chomp == 'y'
  end

  def prompt_guess
    puts 'Please input a 4 digit code witn numbers that are between 2 and 7. (i.e. 4532)'
    @guess = gets.chomp.split('').map(&:to_i)
  end

  def print_board
    puts @board.map { |x| x.join(' ') }
  end

  def output_guesses_left
    @guess_count += 1
    guesses_left =  12 - @guess_count
    puts "You have #{guesses_left} guesses left"
  end

  def update_board
    board[@guess_count] = guess
    output_guesses_left
  end

  def analyze_input
    output = []
    puts 'The Mastermind is responding. . .'
    sleep 0.5
    @master_code.length.times do |idx|
      if @master_code[idx] == guess[idx]
        output << 1 # code and position correct
      elsif @master_code.include?(guess[idx]) && @guess.count(guess[idx]) == 1
        output << 0 # code correct, but not position
      end
    end
    if output.length == 4 && output.uniq == [1]
      @win = true
    end
    puts 'Each "1" indicates the correct code AND position'
    puts 'Each "0" indicates the correct code, but wrong position'
    puts 'The order of the "1"s and "0"s does not matter'
    print output.shuffle
    puts ''
  end
end