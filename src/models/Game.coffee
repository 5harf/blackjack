class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  hit: ->
    console.log 'hit'
    @trigger 'hit', @ 

  stand: ->
    console.log 'stand'
    @trigger 'stand', @

  deal: ->
    @trigger 'deal', @

