# Description:
#   A way to search for images on GifGif (http://gifgif.media.mit.edu)
#
# Dependencies:
#   "fuzzy": "0.1.0"
#
# Configuration:
#   HUBOT_GIFGIF_API_KEY
#
# Commands:
#   hubot gifgif <query> - Returns an animated gif matching the requested query.
#
# Notes:
#   Information on obtaining an API key available here:
#     http://gifgif.media.mit.edu/data
#
# Author:
#   justindowning

fuzzy = require('fuzzy')

gifgif =
  api_key: process.env.HUBOT_GIFGIF_API_KEY
  api_url: 'http://gifgif.media.mit.edu/api'

unless gifgif.api_key?
  console.log "Mising HUBOT_GIFGIF_API_KEY in environment. Please set this and try again."
  process.exit(1)

emotions = [
             "amusement",
             "anger",
             "contempt",
             "contentment",
             "disgust",
             "embarrassment",
             "excitement",
             "fear",
             "guilt",
             "happiness",
             "pleasure",
             "pride",
             "relief",
             "sadness",
             "satisfaction",
             "shame",
             "surprise"
           ]

module.exports = (robot) ->
  robot.respond /gifgif (.*)/i, (msg) ->
    query = msg.match[1]
    results = fuzzy.filter(query, emotions)
    matches = results.map (x) -> x.string
    if matches.length > 0
      emotion = msg.random matches
      msg.http("#{gifgif.api_url}/results")
        .query(emotion: emotion, key: gifgif.api_key)
        .get() (err, res, body) ->
          if err
            msg.send "Uh oh, there was an error"
            robot.emit 'error', err, msg
            return
          else
            if res.statusCode is 200
              gifs = JSON.parse(body).response.results
              if gifs.length > 0
                image = msg.random gifs
                msg.send image.embedLink
              else
                msg.send "Dang! Couldn't find a gif!"
            else
              msg.send "GifGif #{res.statusCode} error:\n#{body}"
    else
      msg.send "\u261B Valid emotions include: #{emotions}"
