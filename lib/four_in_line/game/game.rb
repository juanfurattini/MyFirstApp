module FourInLine
	module Game
		class Game
			include FourInLine::Game::Constants

			attr_accessor :current_player, :board
			DEFAULT_FIRST_PLAYER = PLAYER_1
			TRANSLATE = { EMPTY_BLOCK.to_s => "DRAW", PLAYER_1.to_s => "PLAYER 1", PLAYER_2.to_s => "PLAYER 2"}

			def initialize
				@current_player = DEFAULT_FIRST_PLAYER
				@board = new FourInLine::Game::Board.new
				notify_to_player_his_turn(@current_player)
			end

			private

			def notify_to_player_his_turn(player)
				puts "play next #{@current_player}"
			end

			def notify_winner
				puts "winner #{@current_player}"
			end

			def insert_coin(column)
				is_there_a_winner = @board.put_coin_in_column(column, @current_player)
				if (is_there_a_winner) begin
					notify_winner(player)
				else
					update_current_player()
					notify_to_player_his_turn(@current_player)
				end
				rescue Exception => e
					puts e
          notify_to_player_his_turn(@current_player)
				end
			end

			def update_current_player
				if (@current_player == PLAYER_1) then
					@current_player = PLAYER_2
				else
					@current_player = PLAYER_1
				end
			end

		end
	end
end
