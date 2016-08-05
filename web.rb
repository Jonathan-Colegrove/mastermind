require "sinatra"
require_relative "mastermind"
require "sinatra/reloader" if development?

$play = MasterMind.new

get "/" do
  erb :how_to_play
end

get "/play" do
  @guess_count = $play.guess_count

# DELETE BELOW
  @secret = $play.secret
# DELETE ABOVE

  if @guess_count > 10
    redirect "/lose"
  end

  if $play.result_win?(@guess)
    redirect "/win"
  end

  erb :play
end

post "/guess" do
  @guess_color = params["color1"], params["color2"], params["color3"], params["color4"]
  $play.guess(@guess_color)
  redirect "/play"
end

get "/win" do
  erb :win
end

get "/lose" do
  erb :lose
end

get "/give_up" do
  erb :give_up
end

post "/give_up" do
  $play = MasterMind.new
  redirect "/play"
end
