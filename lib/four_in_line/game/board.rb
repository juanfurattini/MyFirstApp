require 'four_in_line/game/constants'

module FourInLine
  module Game
    class Board
      include FourInLine::Game::Constants

      attr_reader :winner, :board_game

      FILE_COUNT = 6
      COLUMN_COUNT = 7

      def initialize
        @board_game = Array.new(FILE_COUNT) { Array.new(COLUMN_COUNT) }
        @winner = EMPTY_BLOCK
        initialize_game_board()
      end

      def put_coin_in_column(column, player)
          return insert_coin_and_evaluate_winner(column, player)
      end

      private

      def insert_coin_and_evaluate_winner(column, player)
        unless (column_has_any_available_block?(column)) then
          raise "Column not empty"
        end
        _last_free_block = get_last_free_block_in_column(column)
        #puts "_last_free_block returned #{_last_free_block}"
        @board_game[_last_free_block][column] = player
        puts "updating board_game"
        print_board()
        return is_winner?(_last_free_block, column, player)
      end

      def is_winner?(file, column, player)
        #file
        are_there_four_in_file = has_array_four_in_line?(extract_file(file), player)
        puts "are_there_four_in_file #{are_there_four_in_file}"
        are_there_four_in_column = has_array_four_in_line?(extract_column(column), player)
        puts "are_there_four_in_column #{are_there_four_in_column}"
        are_there_four_in_diagonal = has_array_four_in_line?(extract_diagonal(file, column), player)
        puts "are_there_four_in_diagonal #{are_there_four_in_diagonal}"
        are_there_four_in_back_diagonal = has_array_four_in_line?(extract_back_diagonal(file, column), player)
        puts "are_there_four_in_back_diagonal #{are_there_four_in_back_diagonal}"
        return (are_there_four_in_file || are_there_four_in_column || are_there_four_in_diagonal || are_there_four_in_back_diagonal)
      end

      def extract_file(file)
        file_array = @board_game[file]
        puts "FILE ARRAY :: FILE #{file} - ARRAY #{file_array}"
        return file_array
      end

      def extract_column(column)
        column_array = Array.new(FILE_COUNT)
        i = 0
        @board_game.each do |file|
          column_array[i] = file[column]
          i += 1
        end
        puts "COLUMN ARRAY :: COLUMN #{column} - ARRAY #{column_array}"
        return column_array
      end

      def extract_diagonal(file, column)
        _diagonal_array = []
        _current_index_file = file
        _current_index_column = column
        while (_current_index_file > 0 && _current_index_column < (COLUMN_COUNT - 1)) do
          _current_index_file -= 1
          _current_index_column += 1
        end
        j = _current_index_column
        for i in _current_index_file..(FILE_COUNT - 1) do
          _diagonal_array.push(@board_game[i][j])
          if ((j - 1) < 0) then
            puts "DIAGONAL ARRAY :: FILE #{file} - COLUMN #{column} - ARRAY #{_diagonal_array}"
            return _diagonal_array
          end
          j -= 1
        end
        puts "DIAGONAL ARRAY :: FILE #{file} - COLUMN #{column} - ARRAY #{_diagonal_array}"
        return _diagonal_array
      end

      def extract_back_diagonal(file, column)
        _back_diagonal_array = []
        _current_index_file = file
        _current_index_column = column
        while (_current_index_file > 0 && _current_index_column > 0) do
          _current_index_file -= 1
          _current_index_column -= 1
        end
        j = _current_index_column
        for i in _current_index_file..(FILE_COUNT - 1) do
          _back_diagonal_array.push(@board_game[i][j])
          if ((j + 1) >= COLUMN_COUNT) then
            puts "BACK DIAGONAL ARRAY :: FILE #{file} - COLUMN #{column} - ARRAY #{_back_diagonal_array}"
            return _back_diagonal_array
          end
          j += 1
        end
        puts "BACK DIAGONAL ARRAY :: FILE #{file} - COLUMN #{column} - ARRAY #{_back_diagonal_array}"
        return _back_diagonal_array
      end

      def has_array_four_in_line?(array, player)
        _is_player_winner = false
        if (array.size() >= 4) then
          for i in 0..(array.size() - 4) do
            _is_player_winner = true;
            for j in i..(i + 3) do
              if (array[j] != player) then
                _is_player_winner = false
              end
            end
            if (_is_player_winner) then
              return true
            end
          end
        end
        return _is_player_winner
      end

      def get_last_free_block_in_column(column)
        _last_free_block = -1
        @board_game.each do |block|
          if (is_block_empty?(block[column])) then
            #puts "Free block"
            _last_free_block += 1
          end
        end
        #puts "_last_free_block #{_last_free_block}"
        return _last_free_block
      end

      def column_has_any_available_block?(column)
        _has_free_block = false
        @board_game.each do |block|
          #puts "before _has_free_block #{_has_free_block}"
          _has_free_block = true if is_block_empty?(block[column])
          #puts "after _has_free_block #{_has_free_block}"
        end
        #puts "return _has_free_block #{_has_free_block}"
        return _has_free_block
      end

      def initialize_game_board
        for i in 0..(FILE_COUNT - 1) do
          for j in 0..(COLUMN_COUNT - 1) do
            @board_game[i][j] = EMPTY_BLOCK
          end
        end
        #puts "board_game"
        print_board()
      end

      def is_block_empty?(block)
        #puts "block #{block}"
        return (block == EMPTY_BLOCK)
      end

      def print_board
        file_limit = (FILE_COUNT - 1)
        #puts "file_limit #{file_limit}"
        column_limit = (COLUMN_COUNT - 1)
        #puts "column_limit #{column_limit}"
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