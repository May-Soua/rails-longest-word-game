require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = 10.times.map{('A'..'Z').to_a[rand(26)]}
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    # Je dois récupérer le mot de l'input et
    url = "https://dictionary.lewagon.com/#{@word}"
    output = URI.parse(url).read
    info = JSON.parse(output)
    @value = info["found"]
    @answer = ""
    is_valid = @word.chars.all? { |char| @letters.include?(char) }

    if @value == false
      @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word"
    elsif is_valid
      @answer = "Congratulations! #{@word.upcase} is a valid English word"
    else
      @answer = "Sorry but #{@word.upcase} can't be built out of #{@letters}"
    end

    # 2 si le mot est anglais
    # -> Je renvoie "Sorry but @word does not seem to be a valid English word"
    # 1 si le mot contient pas les lettres du tableau
    # -> Je renvoie "Sorry but @word can't be built out of @letters"
    # 3 si c'est correct
    # -> Je renvoie "Congratulations! @word is a valid English word"
  end

  def result
    redirect_to new_path
  end
end
