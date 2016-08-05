require "sinatra"
require_relative "mastermind"
require "sinatra/reloader" if development?

$play = MasterMind.new

get "/" do
  erb :how_to_play
end

get "/play" do
  erb :play
end

post "/guess" do
  @guess_color = params["color1"], params["color2"], params["color3"], params["color4"]

  result = $play.guess(@guess_color)

  if $play.result_win?(result)
    redirect "/win"
    return
  end

  if $play.result_win?(@guess)
    redirect "/win"
    return
  end

  if $play.guess_count > 10
    redirect "/lose"
    return
  end

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
