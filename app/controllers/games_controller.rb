# Games Controller
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    if include?
      if valid_word?
        @result = 'A palavra é válida!'
      else
        @result = 'A palavra não é válida!'
      end
    else
      @result = 'Possui letras erradas!'
    end
  end

  def include?
    @each_letter = params[:letter].split
    @word = params[:word].downcase
    @word.chars.all? do |letter|
      @word.count(letter) <= @each_letter.count(letter)
    end
  end

  def valid_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
