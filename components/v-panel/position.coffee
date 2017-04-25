module.exports = ->
  return unless @isOpen
  container = $ @$refs.container
  position =
    top: container.offset().top
    left: container.offset().left
    width: container.width()
    height: container.height()
  win =
    width: $(window).width()
    height: $(window).height()

  if @align
    el = $ @$parent.$refs[@align]
    parent =
      top: el.offset().top
      left: el.offset().left
      width: el.outerWidth()
      height: el.outerHeight()

    @style.left = switch @x
      when 'before' then parent.left - position.width
      when 'start' then parent.left
      when 'end' then parent.left + parent.width - position.width
      when 'after' then parent.left + parent.width + 1
    @style.top = switch @y
      when 'before' then parent.top - position.height
      when 'start' then parent.top
      when 'end' then parent.top + parent.height - position.height
      when 'after' then parent.top + parent.height + 1
    position.left = @style.left
    position.top = @style.top
    # @style.left += 'px'
    # @style.top += 'px'
    @style.width = 'auto'
    @style.height = 'auto'

  else if @e
    if @e.pageX < (win.width/2)
      @style.left = @e.pageX
      @style.top = @e.pageY
    else
      @style.left = @e.pageX - position.width
      @style.top = @e.pageY
    position.left = @style.left
    position.top = @style.top
    # @style.left += 'px'
    # @style.top += 'px'
    @style.width = 'auto'
    @style.height = 'auto'



  # ширина больше окна
  if position.width > win.width
    @style.left = '0px'
    @style.width = '100%'
  # выходит за правый край
  else if position.left + position.width > win.width
    @style.left = (win.width - position.width) + 'px'
    @style.width = 'auto'
  # выходить за левый край
  else if position.left < 0
    @style.left = '0px'
    @style.width = 'auto'

  # высота больше окна
  if position.height > win.height
    @style.top = '0px'
    @style.height = '100%'
  # выходит за верхинй край
  else if position.top < 0
    @style.top = '0px'
    @style.height = 'auto'
  # выходит за нижний край
  else if position.top + position.height > win.height
    @style.top = (win.height - position.height) + 'px'
    @style.height = 'auto'

  container.css @style
