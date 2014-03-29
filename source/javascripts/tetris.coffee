mouseDown = false
add = false
selectBlock = 0

@tetris = {
  field: {
    width: 10
    height: 22
    array: [] #[height][width]
    createArray: ->
      for i in [0..@height-1]
        @array[i] = []
        for j in [0..@width-1]
          @array[i][j] = 0
  }
  currentMino: currentMino = {
    #mino: new Mino()
    x: 0
    y: 0

    moveLeft: (field) ->
      if !@checkHit(field, @x-1, @y)
        @x--
        refreshRender()
    moveUp: (field) ->
      if !@checkHit(field, @x, @y-1)
        @y--
        refreshRender()
    moveDown: (field) ->
      if !@checkHit(field, @x, @y+1)
        @y++
        refreshRender()
    moveRight: (field) ->
      if !@checkHit(field, @x+1, @y)
        @x++
        refreshRender()
    rotateLeft: (field, rotationSystem) ->
      result = rotationSystem.getOffsetLeft(field, @)
      if result
        @mino.rotateLeft()
        @x += result.x
        @y += result.y
        refreshRender()
    rotateRight: (field, rotationSystem) ->
      result = rotationSystem.getOffsetRight(field, @)
      if result
        @mino.rotateRight()
        @x += result.x
        @y += result.y
        refreshRender()
    checkHit: (field, x, y) ->
      for i in [0..3]
        for j in [0..3]
          if @mino.array[i][j] > 0
            if x+j<0 or x+j>=field.width or y+i<0 or y+i>=field.height or field.array[y+i][x+j] > 0 then return true
      return false
  }
  rule: {
    #width: 10
    #height: 20
    #rotationSystem: new RotationSystem()
  }
}

class @Mino
  constructor: (@minoId) ->
    @array = @getArray(minos[@minoId],@minoId+1)
  getArray: (boolArray, color) ->
    returnArray = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    for i in [0..3]
      for j in [0..3]
        returnArray[i][j] = if boolArray[i][j] then color else 0
    return returnArray
  #array: [4][4]
  #minoId: 0
  rotateState: 0

  rotateRight: ->
    newArray = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    for i in [0..3]
      for j in [0..3]
        newArray[i][j] = this.array[3-j][i]
    @array = newArray
    @rotateState = (@rotateState + 1) % 4
  rotateLeft: ->
    newArray = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    for i in [0..3]
      for j in [0..3]
        newArray[i][j] = this.array[j][3-i]
    @array = newArray
    @rotateState = (@rotateState + 3) % 4

@init = () ->
  tetris.field.createArray()
  createField(tetris.field)
  createControllerSelector()
  tetris.rule.rotationSystem = new RotationSystemWorld()
  tetris.currentMino.mino = new Mino(4)

@createField = (field) ->
  for i in [0..field.height-1]
    $("#field").append("""<div class="field-row" id="row-#{i}"></div>""")
    for j in [0..field.width-1]
      $("#row-#{i}").append("""<div class="field-cell" id="cell-#{i}-#{j}" draggable="false"></div>""")
      do (i,j) ->
        $("#cell-#{i}-#{j}").mousedown(->
          mouseDown = true
          add = tetris.field.array[i][j] != selectBlock
          if add then setField(j,i,selectBlock) else setField(j,i,0)
          return false
        )
        $("#cell-#{i}-#{j}").mouseenter(->
          if mouseDown
            if add then setField(j,i,selectBlock) else setField(j,i,0)
        )

@addControllerSelectorEntry = (id, row, start, stop) ->
  $("#ctrl-tab-content-selectblock-#{id}").append("""<div class="btn-group" data-toggle="buttons" id="ctrl-group-selectblock-#{id}-#{row}"></div>""")
  
  for i in [start..stop]
    $("#ctrl-group-selectblock-#{id}-#{row}").append("""<label id="ctrl-selectblock-#{i}" class="btn btn-default btn-selectblock"><input type="radio" name="options"><div class="selectblock-cell"></div></label>""")
    do (i) ->
      styles[i].style($("#ctrl-selectblock-#{i}>div"))
      $("#ctrl-selectblock-#{i}").click(->
        $(".btn-selectblock").removeClass("active")
        selectBlock = i
      )


@addControllerSelectorTab = (id, name, start1, stop1, start2, stop2) ->
  $("#ctrl-tab-selectblock").append("""<li><a data-toggle="tab" href="#ctrl-tab-content-selectblock-#{id}">#{name}</a></li>""")
  $("#ctrl-tab-contents-selectblock").append("""<div id="ctrl-tab-content-selectblock-#{id}" class="tab-pane"></div>""")
  addControllerSelectorEntry(id, 0, start1, stop1)
  if start2 != undefined and stop2 != undefined then addControllerSelectorEntry(id, 1, start2, stop2)


@createControllerSelector = () ->
  addControllerSelectorTab(0, "Basic", 0, 9, 10, 19)
  addControllerSelectorTab(1, "A", 20, 29, 30, 39)
  addControllerSelectorTab(2, "B", 40, 41, undefined, undefined)

  $("#ctrl-tab-selectblock>li:first").addClass("active") #todo: id?
  $("#ctrl-tab-content-selectblock-0").addClass("active")
  $("#ctrl-selectblock-0").addClass("active")

@refreshRender = () ->
  refreshField(tetris.field)
  renderMino(tetris.currentMino)

@refreshField = (field) ->
  for i in [0..field.height-1]
    for j in [0..field.width-1]
      #if field.array[i][j] == 0 then continue
      styles[field.array[i][j]].style($("#cell-#{i}-#{j}"))

@renderMino = (currentMino) ->
  for i in [0..3]
    for j in [0..3]
      if currentMino.mino.array[i][j] > 0 then styles[currentMino.mino.array[i][j]].style($("#cell-#{currentMino.y+i}-#{currentMino.x+j}"))

@setField = (x, y, b) ->
  tetris.field.array[y][x] = b
  if tetris.currentMino.checkHit(tetris.field, tetris.currentMino.x, tetris.currentMino.y) then tetris.field.array[y][x] = 0 else refreshRender()

#setCurrentMino = (array, color) ->
#  for i in [0..3]
#    for j in [0..3]
#      currentMino.mino.array[i][j] = if array[i][j] then color else 0

$ ->
  init()
  refreshRender()
  
  $("#ctrl-mino-left").click(-> tetris.currentMino.moveLeft(tetris.field))
  $("#ctrl-mino-up").click(-> tetris.currentMino.moveUp(tetris.field))
  $("#ctrl-mino-down").click(-> tetris.currentMino.moveDown(tetris.field))
  $("#ctrl-mino-right").click(-> tetris.currentMino.moveRight(tetris.field))
  $("#ctrl-mino-rot-left").click(-> tetris.currentMino.rotateLeft(tetris.field, tetris.rule.rotationSystem))
  $("#ctrl-mino-rot-right").click(-> tetris.currentMino.rotateRight(tetris.field, tetris.rule.rotationSystem))
  $("html").mouseup(-> mouseDown = false)
  $("html").keydown((e) ->
    if e.keyCode == 97 then tetris.currentMino.moveLeft(tetris.field) # NUM1
    if e.keyCode == 101 then tetris.currentMino.moveUp(tetris.field) # NUM5
    if e.keyCode == 98 then tetris.currentMino.moveDown(tetris.field) # NUM2
    if e.keyCode == 99 then tetris.currentMino.moveRight(tetris.field) # NUM3
    if e.keyCode == 90 then tetris.currentMino.rotateLeft(tetris.field, tetris.rule.rotationSystem) # Z
    if e.keyCode == 88 then tetris.currentMino.rotateRight(tetris.field, tetris.rule.rotationSystem) # X
  )
