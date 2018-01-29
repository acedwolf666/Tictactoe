WIN_CONDITION = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]}"
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]}"
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]}"
end

def play(board, turn)
  if player(turn) == "X"
    input = gets.chomp
    position = input.to_i-1
  else
    puts "NPC picked a position!"
    position = npc_bestplay(board)
  end

  if valide_move?(position, board)
    board[position] = player(turn)
    display(board)
  else
    play(board, turn)
  end
end

def round(board)
  turn = 1
  while turn <= 9 && !won?(board)
    puts "it's turn #{turn}, #{player(turn)}'s turn!"
    play(board, turn)
    turn += 1
  end
  if won?(board)
    puts "#{winner(board)} won!"
  else
    puts "Draw! Noboday won...."
  end
  puts "Game Over!"
end

def player(turn)
  if turn % 2 == 0
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_CONDITION.each do |win_combo|
    if(board[win_combo[0]]== "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X")|| (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      return win_combo
    end
  end
  return false
end

def winner(board)
  win_combo = won?(board)
  if win_combo
    winner = board[win_combo[0]]
    return winner
  end
end

def valide_move?(position, board)
  position >= 0 && position < 9 && board[position] == " "
end

def npc_play(board)
  empty_position(board).sample #empty_position[rand(empty_position.length)]
end

def empty_position(board)
  empty_position = Array.new
  board.each_with_index do |value, index|
    if value == " "
      empty_position << index
    end
  end
  empty_position
end
###############################################################################
def best?(board)
  WIN_CONDITION.each do |best_combo|
    if board[best_combo[0]]== "O" && board[best_combo[1]] == "O" && board[best_combo[2]] == " "|| board[best_combo[0]]== "X" && board[best_combo[1]] == "X" && board[best_combo[2]] == " "
      return best_combo[2]
    elsif board[best_combo[1]]== "O" && board[best_combo[2]] == "O" && board[best_combo[0]] == " "|| board[best_combo[1]]== "X" && board[best_combo[2]] == "X" && board[best_combo[0]] == " "
      return best_combo[0]
    elsif board[best_combo[0]]== "O" && board[best_combo[2]] == "O" && board[best_combo[1]] == " "|| board[best_combo[0]]== "X" && board[best_combo[2]] == "X" && board[best_combo[1]] == " "
      return best_combo[1]
    end
  end
  return false
end

def best_choice(board)
  best_choice = best?(board)
  if best?(board)
    return best_choice
  else
    npc_play(board)
  end
end

def npc_bestplay(board)
  best_choice(board)#empty_position[rand(empty_position.length)]
end
########################################################
puts "The game gets ready! Try to link up to win the game!"
puts "Please pick a number from 1 to 9."
display([1,2,3,4,5,6,7,8,9])
board = [" "," "," "," "," "," "," "," ", " "]
round(board)
