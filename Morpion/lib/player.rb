# frozen_string_literal: true

require 'bundler'
Bundler.require

class Player
  attr_accessor :player_name, :player_symbol

  def initialize(name, symbol)
    @player_name = name
    @player_symbol = symbol
  end
end
