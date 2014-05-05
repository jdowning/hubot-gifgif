# hubot-gifgif

A Hubot script to search for images on GifGif (http://gifgif.media.mit.edu)

# Requirements

You will need a GifGif API key. More information on obtaining an API key available here:  http://gifgif.media.mit.edu/data

# Usage
```
Hubot> hubot gifgif fear
[hubot] http://media.giphy.com/media/U0KKP27zRTL1e/giphy.gif
```

# Intallation

Add the package `hubot-gifgif` as a dependency in your Hubot `package.json` file.

    "dependencies": {
      "hubot-gifgif": "1.0.x"
    }

Run the following command to make sure the module is installed.

    $ npm install

To enable the script, add the `hubot-gifgif` entry to the `external-scripts.json` file (you may need to create this file).

    ["hubot-gifgif"]

Ensure you set the `HUBOT_GIFGIF_API_KEY` environment variable when Hubot starts.
