require 'spec_helper'
require 'four_in_line/game/board'
require 'four_in_line/game/constants'

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
	
  context "put_coin_in_column" do

    before :each do
      @board = FourInLine::Game::Board.new
    end

    it 'should allow to put a coin in everywhere with and empty board' do
      @board.put_coin_in_column(0, 1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 1][0]).to eq(1)
    end

    it 'should have 2 player 1 coins in first column when player 1 puts in those places' do
      @board.put_coin_in_column(0, 1)
      @board.put_coin_in_column(0, 1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 1][0]).to eq(1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 2][0]).to eq(1)
    end

    it 'should have 4 player 1 coins in first column when player 1 puts in those places and wins' do
      @board.put_coin_in_column(0, 1)
      @board.put_coin_in_column(0, 1)
      @board.put_coin_in_column(0, 1)
      @board.put_coin_in_column(0, 1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 1][0]).to eq(1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 2][0]).to eq(1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 3][0]).to eq(1)
      expect(@board.board_game[FourInLine::Game::Constants::FILE_COUNT - 4][0]).to eq(1)
      expect(@board.winner) == 1
    end

    it 'should have 4 player 1 coins in diagonal and wins' do
      @board.put_coin_in_column(0, 1)
      @board.put_coin_in_column(1, 2)
      @board.put_coin_in_column(2, 1)
      @board.put_coin_in_column(3, 2)
      @board.put_coin_in_column(1, 1)
      @board.put_coin_in_column(2, 2)
      @board.put_coin_in_column(2, 1)
      @board.put_coin_in_column(3, 2)
      @board.put_coin_in_column(3, 1)
      @board.put_coin_in_column(4, 2)
      @board.put_coin_in_column(3, 1)
      expect(@board.winner) == 1
    end

    it 'should have 4 player 1 coins in back diagonal and wins' do
      @board.put_coin_in_column(6, 1)
      @board.put_coin_in_column(5, 2)
      @board.put_coin_in_column(4, 1)
      @board.put_coin_in_column(3, 2)
      @board.put_coin_in_column(5, 1)
      @board.put_coin_in_column(4, 2)
      @board.put_coin_in_column(4, 1)
      @board.put_coin_in_column(3, 2)
      @board.put_coin_in_column(3, 1)
      @board.put_coin_in_column(2, 2)
      @board.put_coin_in_column(3, 1)
      expect(@board.winner) == 1
    end

  end

end