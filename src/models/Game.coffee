class window.Game extends Backbone.Model
  defaults: 
    'money': 500,
    'bet': 0

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  placeBet: (bet) ->
    @set('money', @get('money') - bet)
    @set('bet', bet)

  hit: ->
    @trigger 'hit', @ 

  stand: ->
    @trigger 'stand', @

  deal: ->
    @initialize()
    @trigger 'deal', @

  win: ->
    money = @get('money')
    @set('money', money + @.get('bet') * 2)
    @set('bet', 0)
    @trigger 'win', @

  loss: ->
    @set('bet', 0)
    @trigger 'loss', @


  push: ->
    money = @get('money')
    @set('money', money + @.get('bet'))
    @set('bet', 0)
    @trigger 'push', @


#if its a win, set money += to 2* bet
#set bet 0
