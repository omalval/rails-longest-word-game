require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 'A'.upto('Z').to_a
    @letters = @letters.sample(10)
  end

  def score
    @guess = params[:new].split("")
    if @guess.all? { |letter| params[:grid].split.include?(letter.upcase) }
      if english_word?(params[:new])
        @result = "Congratulation! #{params[:new].upcase} is a valid english word."
      else
        @result = "Sorry but #{params[:new]} does not seem to be an english word"
      end
    else
      @result = "Sorry but #{@guess} can't be build out of #{params[:grid]}"
    end
  end

  def english_word?(guess)
    response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    json['found']
  end
end
