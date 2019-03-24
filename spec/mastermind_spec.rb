require './mastermind.rb'

describe Mastermind do
  let(:game) { Mastermind.new }

  before do
    allow($stdout).to receive(:write)
  end

  describe '#initialize' do
    context 'after a new game is initialized' do
      it 'creates a random 4 unit code of colors' do
        expect(game.instance_variable_defined?(:@master_code)).to eq(true)
      end

      it 'creates an empty board' do
        expect(game.instance_variable_defined?(:@board)).to eq(true)
      end

      it 'sets the scores to 0' do
        expect(game.player_score).to eq(0)
        expect(game.master_score).to eq(0)
      end

      it 'starts a new game and updates game count' do
        expect(game.game_count).to eq(1)
      end
    end
  end

  describe '#start_game' do
      
    it 'prompts the user to enter yes if they are ready' do
      allow(game).to receive(:gets) { 'y' }
      expect(game.check_ready?).to eq(true)
    end

    it 'checks if the guess is valid' do
      allow(game).to receive(:gets) { '2345' }
      expect(game.prompt_guess).to eq([2, 3, 4, 5])
      expect(game.check_guess_valid?).to eq(true)
    end

    it 'returns the mastermind\'s response to a valid guess' do
      allow(game).to receive(:gets) { '5764' }
      expect(game.prompt_guess).to eq([5, 7, 6, 4])
      expect(game.get_response).to eq(nil).or include(1).or include(0)
    end

    it 'prompts the user for another answer if the guess is invalid' do
      allow(game).to receive(:gets) { '2' }
      expect(game.prompt_guess).to eq([2])
      expect(game.check_guess_valid?).to eq(false)
    end

    it 'is game over if the guess count exceeds 12' do
      game.instance_variable_set(:@guess_count, 12)
      game.prompt_guess
      expect(game.game_over?).to eq(true)
    end

    it 'is not game over if the guess count is less than 12' do
      game.instance_variable_set(:@guess_count, 1)
      game.prompt_guess
      expect(game.game_over?).to eq(false)
    end

    it 'outputs guesses left out of 12' do
      game.instance_variable_set(:@guess_count, 2)
      game.output_remaining_guesses
      expect(game.remaining_guesses).to eq(9)
    end

  end
end
