# Command Line Mastermind Game
class Mastermind
  attr_reader :player_score, :master_score, :player_guess,
              :game_count, :board, :guess_count, :guess

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
    @board = []
    # @board = Array.new(12) { Array.new(4) }
    @win = false
  end

  def display_rules
    puts %{
      Welcome to Mastermind!

      A 4 letter code has been set by the mastermind.
      You win if you can guess the 4 letter code in 12 turns.
      After each guess, the mastermind will return the numbers 0 or 1.
      Each "1" indicates that one of the guessed numbers is correct, but in the wrong place.
      Each "2" indicates that one of the guessed numbers is correct and in the correct place. 
      You may guess any value between 2 - 7 inclusive.
      Goodluck!!'
    }
  end

  def update_game_count
    @game_count.nil? ? @game_count = 1 : @game_count += 1
  end

  def check_guess_valid?
    (@guess.length == 4) && (@guess.count { |e| e.between?(2,8) } == 4)
  end

  def start_game
    update_game_count
    if check_ready?
      until game_over?
        prompt_guess
        next unless check_guess_valid?

        get_response
        update_board
        print_board
        check_win
      end
      determine_winner
    end
  end

  def determine_winner
    if @win
      print "HOORAY! You cracked the code in #{guess_count} guesses!"
      @player_score += 1
    else
      puts 'Mastermind has out master-minded you... ' \
            "The code was #{master_code}... Better luck next time!"
      @master_score += 1
    end
    puts "Player Score: #{player_score}"
    puts "Mastermind Score:  #{master_score}"
  end

  def check_win
    @win = @response.length == 4 && @response.uniq == [1]
  end

  def game_over?
    @win || @guess_count >= 12
  end

  def check_ready?
    puts 'Are you ready to play? (Y/N)'
    user_input = gets.chomp.downcase
    return true if user_input == 'y' || user_input == 'yes'
    return false
  end

  def prompt_guess
    puts 'Please input a 4 digit code with numbers that are between 2 and 7. (i.e. 4532)'
    @guess = gets.chomp.split('').map(&:to_i)
  end

  def get_response
    puts 'The Mastermind is responding. . .'
    sleep 0.5
    @response = analyze_input.shuffle
  end

  def print_board
    puts board
    print ''
  end

  def output_guesses_left
    @guess_count += 1
    guesses_left =  12 - @guess_count
    puts "You have #{guesses_left} guesses left"
  end

  def update_board
    @board << @guess.to_s + ' - ' + @response.to_s
    output_guesses_left
  end

  def analyze_input
    @response = []
    @master_code.each_with_index do |code, idx|
      if code == @guess[idx]
        @response << 1 # code and position correct
      elsif @master_code.include?(@guess[idx]) && @guess.count(@guess[idx]) == 1
        @response << 0 # code correct, but not position
      end
    end
    @response
  end
end
