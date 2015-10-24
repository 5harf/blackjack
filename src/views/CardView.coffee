class window.CardView extends Backbone.View
  className: 'card'

  #tagName: 'img'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    rankname = @model.get('rankName').toString().toLowerCase()
    suitname = @model.get('suitName').toLowerCase()
    imagePath = "#{rankname}-#{suitname}.png"

    if @model.get 'revealed' 
      @$el.html '<img class="front" src="./img/cards/' + imagePath + '"/>'
    else
      @$el.html '<img class="front" src="./img/card-back.png"/>'
    