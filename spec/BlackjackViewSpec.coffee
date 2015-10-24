assert = chai.assert

describe "AppView", ->

  view = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    view = new AppView(model: new App())
    dealerHand = view.model.get 'dealerHand'
    playerHand = view.model.get 'playerHand'

  it "should disable hit and stand when showing hand is greater than 20", ->    
    playerHand.scores = -> [21]
    view.$el.find('.hit-button').trigger('click')
    assert.strictEqual view.$el.find('.hit-button').prop('disabled'), true
    assert.strictEqual view.$el.find('.stand-button').prop('disabled'), true  

  it "should disable hit and stand buttons when standing", ->
    view.$el.find('.stand-button').trigger('click')
    assert.strictEqual view.$el.find('.hit-button').prop('disabled'), true
    assert.strictEqual view.$el.find('.stand-button').prop('disabled'), true

  it "should display dealers hand after stand", ->
    view.$el.find('.stand-button').trigger('click')
    assert.strictEqual dealerHand.at(0).get('revealed'), true

  it "should display dealers hand after bust", ->
    playerHand.scores = -> [21]
    view.$el.find('.hit-button').trigger('click')
    assert.strictEqual dealerHand.at(0).get('revealed'), true

  it "Dealer does not take a card when > hard 16 or > soft 17", ->
    dealerHand.scores = -> [17, 18]
    view.dealDealer()
    assert.strictEqual dealerHand.scores()[0], 17

  it "Dealer still takes a card when soft value exceeds 21", ->
    hand = [new Card(rank: 1, suit: 1),
            new Card(rank: 1, suit: 1)]
    view.model.set 'dealerHand', new Hand(hand, new Deck, true)
    dealerHand = view.model.get 'dealerHand'
    view.dealDealer()
    assert dealerHand.scores()[0] > 16


