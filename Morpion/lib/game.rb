# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'board'
require_relative 'boardcase'
require_relative 'game'
require_relative 'player'

class Game
  attr_accessor :player1, :player2, :board

  def initialize
    @players = []
    @board = Board.new
  end

  def creat_players
    # Joueur 1
    system 'clear'
    puts "-" * 30
    puts "Insère le nom du premier joueur, tu aura l'équipe X"
    puts '> '
    player1_name_input = gets.chomp.to_s
    @players << Player.new(player1_name_input, 'X')
    # Joueur 2
    puts "Inserer le nom du deuxième joueur, tu aura l'équipe O"
    puts '> '
    player2_name_input = gets.chomp.to_s
    @players << Player.new(player2_name_input, 'O')
    system 'clear'
    puts "Bienvenue dans ce morpion #{player1_name_input} et #{player2_name_input}"
    puts "-" * 30
  end

  # Fonction qui fait jouer les joueurs un par un
  def select_player
    @players.each { |item| choose_case(item) } while @board.game_state_variable == false
  end

  # Selon le cas, l'utilisateur veut jouer et retourner le symbole dans le cas dans le cas sélectionné
  def choose_case(player)
    # Si le joueur gagne
    if @board.game_state_variable == true
      puts "#{player.player_name}, Bravo tu as gagné".colorize(:blue)
    # Si le jeux est match nul
    elsif @board.game_nil_variable == true
      puts 'Le match est null'
    # Sinon continue le jeux
    else
      puts "#{player.player_name} avec le symbole #{player.player_symbol} à toi de jouer. Entre la case que tu veux."
      puts'>'
      @board.write_on_case(gets.chomp.to_s, player.player_symbol)
      @board.show_board
      @board.game_state
#system "clear"
    end
  end

  # Demander si l'utilisateur veut jouer à un autre jeu
  def ask_new_game
    puts "Si tu veux rejouer entre 'Y' ou pour sortir n'importe quelle touche"
    print '> '
    new_game = gets.chomp.to_s

    if new_game == 'Y'
      Game.new.perform
    #  @board.array_cases.map! { item | item.content = ' ' }
      perform
    end
  end

  def perform
    creat_players
    puts "Le nom du joueur 1 est #{@players[0].player_name} et son symbole est #{@players[0].player_symbol}"
    puts "Le nom du joueur 2 est #{@players[1].player_name} et son symbole est #{@players[1].player_symbol}"
    puts "-" * 30
    # Afficher le plateau vide avant de jouer
    @board.show_board
    select_player
    ask_new_game
  end
end
