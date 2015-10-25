class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="deal-button">Deal</button>
    <span class="money">Bank: $<%= money %></span>
    <button class="bet-button" data-amount="5">Bet 5</button>
    <button class="bet-button" data-amount="10">Bet 10</button>
    <button class="bet-button" data-amount="25">Bet 25</button>  
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @gameModel.hit()
    'click .stand-button': -> @gameModel.stand()
    'click .deal-button': -> @gameModel.deal()
    'click .bet-button': (e) -> 
      betAmount = $(e.target).attr('data-amount')
      @gameModel.placeBet betAmount
      @render()

  initialize: ->
    @gameModel = @model.get 'game'
    @listenTo @gameModel, 'stand', @disableActions
    @listenTo @gameModel, 'deal', @render 
    @listenTo @gameModel, 'win loss push', @render
    @gameview = new GameView model: @gameModel
    @render()


  disableActions: -> 
    @.$el.find('.hit-button').prop('disabled', true)
    @.$el.find('.stand-button').prop('disabled', true)
    @.$el.find('.deal-button').prop('disabled', false)

  render: ->
    @$el.children().detach()
    @$el.html @template(@gameModel.attributes) 
    # if val then $('deal-button').attr('disable', false)
    @$('.player-hand-container').html new HandView(collection: @gameModel.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @gameModel.get 'dealerHand').el

