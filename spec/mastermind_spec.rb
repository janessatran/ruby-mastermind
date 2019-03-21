require './mastermind.rb'

describe Mastermind do
  let(:game) { Mastermind.new }
  before do
    allow($stdout).to receive(:write)
  end

  context 'after a new game is initialized' do
    it 'creates a random 4 unit code of colors' do
      expect(game.instance_variable_defined?(:@master_code)).to eq(true)
    end
    it 'creates an empty 12x4 board' do
      expect(game.board.length).to eq(12)
      expect(game.board[0].length).to eq(4)
    end
    it 'sets the scores to 0' do
      expect(game.player_score).to eq(0)
      expect(game.computer_score).to eq(0)
    end
    it 'stats a new game and updates game count' do
      expect(game.game_count).to eq(1)
    end
  end
end
