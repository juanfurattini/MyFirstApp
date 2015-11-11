module FourInLine
	module Game
		class Game
			include FourInLine::Game::Constants

			attr_accessor :current_player, :board
			DEFAULT_FIRST_PLAYER = PLAYER_1

			def initialize
				@current_player = DEFAULT_FIRST_PLAYER
				@board = new FourInLine::Game::Board.new
				notify_to_player_his_turn(@current_player)
			end

			private

			def notify_to_player_his_turn(player)
				#TO DO: Implement to notify via web
			end

			def notify_winner(player)
				puts "winner #{player}"
			end

			def insert_coin(column, player)
				@board.put_coin_in_column(column, player)
				winner = @board.winner
				if (winner > 0) begin
					notify_winner(player)
				end
				if (@current_player == PLAYER_1) then
					@current_player = PLAYER_2
				else
					@current_player = PLAYER_2
				end
				notify_to_player_his_turn(@current_player)
				rescue Exception => e
					puts e
				end
			rescue
			end
		end
	end
end
