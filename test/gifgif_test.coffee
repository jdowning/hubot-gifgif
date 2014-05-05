chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "GifGif", ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require("../src/gifgif")(@robot)

  it "gets a fear gif", ->
    expect(@robot.respond).to.have.been.calledWith(/gifgif fear/)
