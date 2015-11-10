module FourInLine
	module Game
		class Board
      include FourInLine::Game::Constants

      attr_accessor :winner

      FILE_COUNT = 6
      COLUMN_COUNT = 7

      def initialize
        @board_game = Array.new(FILE_COUNT) { Array.new(COLUMN_COUNT) }
        @winner = EMPTY_BLOCK
        initialize_game_board()
			end

      def put_coin_in_column(column, player)
          insert_coin(column, player)
      end

      private

      def insert_coin(column, player)
        unless (column_has_any_available_block?(column)) begin
          raise "Column not empty"
        end
        _last_free_block = get_last_free_block_in_column(column)
        column[_last_free_block] = player
        check_winner(player)
      end

      def check_winner(player)
        return (check_winner_in_columns(player) || check_winner_in_files(player) || check_winner_in_diagonals(player))
      end

      def check_winner_in_diagonals(player)

      end

      def check_winner_in_files(player)
        
      end

      def check_winner_in_columns(player)
        @board_game.each do |file|
          _diff = COLUMN - 4
          for i in 0..(diff - 1))
            _player_sum = 0
            for j in i..(i + 3)
              if (file[j] == player) begin
                _player_sum += 1
              end
            end
            if (_player_sum == 4) begin
              return true
            end
          end
        end
      end

      def get_last_free_block_in_column(column)
        _last_free_block = -1
        column.each do |block|
          if (_is_block_empty?(block)) begin
            _last_free_block += 1
          end
        end
        return _last_free_block
      end

      def column_has_any_available_block?(column)
        _has_free_block_ = false
        column.each do |block|
          _has_free_block = true if _is_block_empty?(block)
        end
        return _has_free_block
      end

      def initialize_game_board
        @board_game.each do |file|
          file.each do |block|
            block = Status::EMPTY
          end
        end
      end

      def is_block_empty?(block)
        return (block eql EMPTY_BLOCK)
      end

		end
	end
end