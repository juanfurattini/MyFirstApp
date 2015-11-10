require 'spec_helper'
require 'four_in_line/game/board'

describe FourInLine::Game::Board do

	context 'User puts coin on board' do

		it 'should allow to put a coin in every slot with an empty board' do

			@file_count = 6
			@column_count = 7
			#@board = FourInLine::Game::Board.new
			@board = Array.new(@file_count) { Array.new(@column_count) }
			@board[0][0] = 'X'
      expect(@board[0][0]).to eq("X")

		end

	end
	
end