class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @hit()
    'click .stand-button': -> @stand()

  initialize: ->
    @render()

  disableActions: -> 
    @.$el.find('.hit-button').prop('disabled', true)
    @.$el.find('.stand-button').prop('disabled', true)
 

  stand: ->
    @disableActions()
    @dealDealer()

  dealDealer: ->
    dealerHand = @model.get('dealerHand')
    dealerHand.showHand()
    while dealerHand.scores()[0] <= 16 and (dealerHand.scores()[1] <= 17 or dealerHand.scores()[1] > 21)
      dealerHand.hit()

  hit: ->
    playerHand = @model.get('playerHand')
    playerHand.hit()
    #bust
    if playerHand.scores()[0] > 20
      @stand()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

