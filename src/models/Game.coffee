class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  hit: ->
    @trigger 'hit', @ 

  stand: ->
    @trigger 'stand', @

  deal: ->
    @initialize()
    @trigger 'deal', @

