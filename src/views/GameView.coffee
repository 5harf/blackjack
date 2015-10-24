class window.GameView extends Backbone.View

  initialize: ->
    @listenTo @model, 'hit', @hit
    @listenTo @model, 'stand', @stand 
    @listenTo @model, 'deal', @deal 


  stand: ->
    @disableActions()
    @dealDealer()

  dealDealer: ->
    dealerHand = @model.get('dealerHand')
    dealerHand.showHand()
    while dealerHand.scores()[0] <= 16 and (dealerHand.scores()[1] <= 17 or dealerHand.scores()[1] > 21)
      dealerHand.hit()
    @checkWin()
  
  checkWin: ->
    dealerHand = @model.get('dealerHand')
    playerHand = @model.get('playerHand')

    playerScore = if playerHand.scores()[1] > 21 then playerHand.scores()[0] else playerHand.scores()[1]
    dealerScore = if dealerHand.scores()[1] > 21 then dealerHand.scores()[0] else dealerHand.scores()[1]

    if playerScore > 21 or (dealerScore <= 21 and dealerScore > playerScore)
      alert('Dealer wins!', playerScore, dealerScore)
    else if playerScore == dealerScore
      alert "tie"
    else
      alert('win', playerScore, dealerScore)

  deal: ->
    @model.initialize()
    @.$el.find('.hit-button').prop('disabled', false)
    @.$el.find('.stand-button').prop('disabled', false)
    @render()


  hit: ->
    playerHand = @model.get('playerHand')
    playerHand.hit()
    #bust
    if playerHand.scores()[0] > 20
      @stand()

