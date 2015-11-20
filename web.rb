require 'sinatra'
require 'dotenv'
require_relative './lib/morse'

Dotenv.load
SLACK_TOKENS = [
  ENV['SLACK_TOKEN_ENTROLL'],
  ENV['SLACK_TOKEN_DETROLL']
]

helpers do
  def authorize!
    authorized = SLACK_TOKENS.include?(params[:token])
    halt 401, "Not authorized\n" unless authorized
  end
end

post '/' do
  authorize!

  command = params[:command]
  text    = params[:text]

  case command
  when '/detroll'
    Morse.from_troll_morse(text)
  when '/entroll'
    Morse.to_troll_morse(text)
  else
    ':troll: Trololololo :troll:'
  end
end

get('/'){ redirect 'https://www.youtube.com/watch?v=sTSA_sWGM44' }
