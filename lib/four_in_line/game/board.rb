require 'four_in_line/game/constants'

module FourInLine
	module Game
		class Board
      include FourInLine::Game::Constants

      attr_accessor :winner, :board_game

      FILE_COUNT = 6
      COLUMN_COUNT = 7
      TRANSLATE = { EMPTY_BLOCK.to_s => "DRAW", PLAYER_1.to_s => "PLAYER 1", PLAYER_2.to_s => "PLAYER 2"}


      def initialize
        @board_game = Array.new(FILE_COUNT) { Array.new(COLUMN_COUNT) }
        @winner = EMPTY_BLOCK
        initialize_game_board()
			end

      def put_coin_in_column(column, player)
          insert_coin(column, player)
          puts "updating board_game"
          print_board()
          _is_player_winner = is_player_winner?(player)
          puts "_is_player_winner returned #{_is_player_winner}"
          puts "winner before #{winner}"
          winner = player if _is_player_winner
          puts "winner after #{winner}"
          msg = TRANSLATE[winner.to_s]
          puts "AND THE WINNER IS #{msg}"
      end

      private

      def insert_coin(column, player)
        unless (column_has_any_available_block?(column)) then
          raise "Column not empty"
        end
        _last_free_block = get_last_free_block_in_column(column)
        puts "_last_free_block returned #{_last_free_block}"
        @board_game[_last_free_block][column] = player
      end

      def is_player_winner?(player)
        _is_player_winner  = (check_winner_in_columns(player) || check_winner_in_files(player) || check_winner_in_diagonals(player))
        puts "_is_player_winner #{_is_player_winner}"
        return _is_player_winner
      end

      def check_winner_in_diagonals(player)
        puts "in diagonals return true"
        return false
      end

      def check_winner_in_files(player)
        _limit = (COLUMN_COUNT - 1)
        for i in 0.._limit do
          _diff = (FILE_COUNT - 4)
          for j in 0.._diff do
            _player_sum = 0
            _diff_limit = (j + 3)
            for k in j.._diff_limit do
              if (@board_game[k][i] == player) then
                _player_sum += 1
              end
            end
            if (_player_sum == 4) then
              puts "in files return true"
              return true
            end
          end
        end
        puts "in files return false"
        return false
      end

      def check_winner_in_columns(player)
        @board_game.each do |file|
          _diff = (COLUMN_COUNT - 4)
          for i in 0.._diff do
            _player_sum = 0
            _diff_limit = (i + 3)
            for j in i.._diff_limit do
              if (file[j] == player) then
                _player_sum += 1
              end
            end
            if (_player_sum == 4) then
              puts "in column return true"
              return true
            end
          end
        end
        puts "in column return false"
        return false
      end

      def get_last_free_block_in_column(column)
        _last_free_block = -1
        @board_game.each do |block|
          if (is_block_empty?(block[column])) then
            puts "Free block"
            _last_free_block += 1
          end
        end
        puts "_last_free_block #{_last_free_block}"
        return _last_free_block
      end

      def column_has_any_available_block?(column)
        _has_free_block = false
        @board_game.each do |block|
          puts "before _has_free_block #{_has_free_block}"
          _has_free_block = true if is_block_empty?(block[column])
          puts "after _has_free_block #{_has_free_block}"
        end
        puts "return _has_free_block #{_has_free_block}"
        return _has_free_block
      end

      def initialize_game_board
        for i in 0..(FILE_COUNT - 1) do
          for j in 0..(COLUMN_COUNT - 1) do
            @board_game[i][j] = EMPTY_BLOCK
          end
        end
        puts "board_game"
        print_board()
      end

      def is_block_empty?(block)
        puts "block #{block}"
        return (block == EMPTY_BLOCK)
      end

      def print_board
        file_limit = (FILE_COUNT - 1)
        puts "file_limit #{file_limit}"
        column_limit = (COLUMN_COUNT - 1)
        puts "column_limit #{column_limit}"
        for i in 0..file_limit do
          _line = ""
          for j in 0..column_limit do
            _line = _line + @board_game[i][j].to_s + " "
          end
          puts "line #{i} : #{_line}"
        end
      end

		end
	end
end