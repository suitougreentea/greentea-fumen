class @BlockStyle
  constructor: (@color, @textColor, @text) ->

  style: (jqobj) ->
    jqobj.css("background-color":@color,"color":@textColor).text(@text)

@styles = [
  new BlockStyle("#000","#000","")
  new BlockStyle("#F00","#F00","")
  new BlockStyle("#F80","#F80","")
  new BlockStyle("#FF0","#FF0","")
  new BlockStyle("#0F0","#0F0","")
  new BlockStyle("#0FF","#0FF","")
  new BlockStyle("#00F","#00F","")
  new BlockStyle("#F0F","#F0F","")
  new BlockStyle("#888","#888","")
  new BlockStyle("#222","#222","")
  new BlockStyle("#000","#CCC","□")
  new BlockStyle("#000","#F00","●")
  new BlockStyle("#000","#F80","●")
  new BlockStyle("#000","#FF0","●")
  new BlockStyle("#000","#0F0","●")
  new BlockStyle("#000","#0FF","●")
  new BlockStyle("#000","#00F","●")
  new BlockStyle("#000","#F0F","●")
  new BlockStyle("#000","#888","●")
  new BlockStyle("#000","#222","●")
  new BlockStyle("#CCC","#000","0")
  new BlockStyle("#CCC","#000","1")
  new BlockStyle("#CCC","#000","2")
  new BlockStyle("#CCC","#000","3")
  new BlockStyle("#CCC","#000","4")
  new BlockStyle("#CCC","#000","5")
  new BlockStyle("#CCC","#000","6")
  new BlockStyle("#CCC","#000","7")
  new BlockStyle("#CCC","#000","8")
  new BlockStyle("#CCC","#000","9")
  new BlockStyle("#CCC","#000","○")
  new BlockStyle("#CCC","#000","×")
  new BlockStyle("#CCC","#000","←")
  new BlockStyle("#CCC","#000","↑")
  new BlockStyle("#CCC","#000","↓")
  new BlockStyle("#CCC","#000","→")
  new BlockStyle("#CCC","#000","↖")
  new BlockStyle("#CCC","#000","↗")
  new BlockStyle("#CCC","#000","↙")
  new BlockStyle("#CCC","#000","↘")
  new BlockStyle("#CCC","#000","↻")
  new BlockStyle("#CCC","#000","↺")
]

@minos = [
  [#Z
    [ on, on,off,off],
    [off, on, on,off],
    [off,off,off,off],
    [off,off,off,off]
  ],
  [#L
    [off,off, on,off],
    [ on, on, on,off],
    [off,off,off,off],
    [off,off,off,off]
  ],
  [#O
    [off,off,off,off],
    [off, on, on,off],
    [off, on, on,off],
    [off,off,off,off]
  ],
  [#S
    [off, on, on,off],
    [ on, on,off,off],
    [off,off,off,off],
    [off,off,off,off]
  ],
  [#I
    [off,off,off,off],
    [ on, on, on, on],
    [off,off,off,off],
    [off,off,off,off]
  ],
  [#J
    [ on,off,off,off],
    [ on, on, on,off],
    [off,off,off,off],
    [off,off,off,off]
  ],
  [#T
    [off, on,off,off],
    [ on, on, on,off],
    [off,off,off,off],
    [off,off,off,off]
  ]
]
