require './board.rb'

describe Board do
  let(:board) { Board.new }

  it 'creates an empty board upon initalization' do
    current_board = board.instance_variable_get(:@board)
    expect(current_board).to eq([])
  end

  it 'updates the board with player guess and response' do
    player_guess = [2, 4, 5, 6]
    response = [1, 0]
    expectation = player_guess.to_s + ' - ' + response.to_s
    expect(board.update(player_guess, response)).to eq([expectation])
  end

end