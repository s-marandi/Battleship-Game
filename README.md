# Battleship-Game
This program processes text files containing Ship or attack strategy information, and will process that data to build a 10X10 GameBoard of ships and perform attacks on the opponent's GameBoard.

Game Logic:

calling read_ships_file will create a GameBoard for each player; then, call ing read_attacks_file to get an Array of Position objects which represent the attack strategy of each player. If no attack strategy file is provided, the game controller generates 35 random attack positions and uses them instead. Each player's GameBoard's attack_pos method is called alternately with the other player's attacks (i.e., the Position objects), one player's attack, then the other's. The game ends on one of these two cases:

All of the ships of a player are sunk (as determined by the GameBoard's all_sunk? method)
The winner is that player's opponent.
One of the players runs out of attack moves
Every time its the second player's turn, the game controller checks both the attack strategy Arrays to see if there is any valid attack position left. If there is nothing left for one of the two players, the game doesn't go to the next round of attacks. We do the following to determine the winner.
Each GameBoard's num_successful_attacks method is called to compare success of each player. The player that has more successfull attacks will win the game.
