class @RotationSystem
  getOffsetLeft: (field, currentMino) ->
    currentMino.mino.rotateLeft()
    if !currentMino.checkHit(field,currentMino.x,currentMino.y)
      currentMino.mino.rotateRight()
      return {x:0,y:0}
    currentMino.mino.rotateRight()
    return null
  getOffsetRight: (field, currentMino) ->
    currentMino.mino.rotateRight()
    if !currentMino.checkHit(field,currentMino.x,currentMino.y)
      currentMino.mino.rotateLeft()
      return {x:0,y:0}
    currentMino.mino.rotateLeft()
    return null

class @RotationSystemClassic extends RotationSystem
  offsetLeft:  [{x: 1,y: 0},{x: 0,y: 1},{x:-1,y: 0},{x: 0,y:-1}] #R>0,2>R,L>2,0>L
  offsetRight: [{x: 0,y: 1},{x:-1,y: 0},{x: 0,y:-1},{x: 1,y: 0}] #L>0,0>R,R>2,2>L
  getOffsetLeft: (field, currentMino) ->
    currentMino.mino.rotateLeft()
    currentOffset = if currentMino.mino.minoId == 2 or currentMino.mino.minoId == 4 then {x:0,y:0} else @offsetLeft[currentMino.mino.rotateState]
    if !currentMino.checkHit(field,currentMino.x+currentOffset.x,currentMino.y+currentOffset.y)
      currentMino.mino.rotateRight()
      return {x:currentOffset.x,y:currentOffset.y}
    currentMino.mino.rotateRight()
    return null
  getOffsetRight: (field, currentMino) ->
    currentMino.mino.rotateRight()
    currentOffset = if currentMino.mino.minoId == 2 or currentMino.mino.minoId == 4 then {x:0,y:0} else @offsetRight[currentMino.mino.rotateState]
    if !currentMino.checkHit(field,currentMino.x+currentOffset.x,currentMino.y+currentOffset.y)
      currentMino.mino.rotateLeft()
      return {x:currentOffset.x,y:currentOffset.y}
    currentMino.mino.rotateLeft()
    return null

class @RotationSystemWorld extends RotationSystemClassic
  superOffsetLeft: [
    [{x: 0,y: 0},{x: 1,y: 0},{x: 1,y:-1},{x: 0,y: 2},{x: 1,y: 2}], #R>0
    [{x: 0,y: 0},{x:-1,y: 0},{x:-1,y:-1},{x: 0,y: 2},{x:-1,y: 2}], #2>R
    [{x: 0,y: 0},{x:-1,y: 0},{x:-1,y: 1},{x: 0,y:-2},{x:-1,y:-2}], #L>2
    [{x: 0,y: 0},{x: 1,y: 0},{x: 1,y:-1},{x: 0,y: 2},{x: 1,y: 2}]  #0>L
  ]
  superOffsetRight: [
    [{x: 0,y: 0},{x:-1,y: 0},{x:-1,y: 1},{x: 0,y:-2},{x:-1,y:-2}], #L>0
    [{x: 0,y: 0},{x:-1,y: 0},{x:-1,y:-1},{x: 0,y: 2},{x:-1,y: 2}], #0>R
    [{x: 0,y: 0},{x: 1,y: 0},{x: 1,y: 1},{x: 0,y:-2},{x: 1,y:-2}], #R>2
    [{x: 0,y: 0},{x: 1,y: 0},{x: 1,y:-1},{x: 0,y: 2},{x: 1,y: 2}]  #2>L
  ]
  superOffsetILeft: [
    [{x: 0,y: 0},{x: 2,y: 0},{x:-1,y: 0},{x: 2,y:-1},{x:-1,y: 2}], #R>0
    [{x: 0,y: 0},{x: 1,y: 0},{x:-2,y: 0},{x: 1,y: 2},{x:-2,y:-1}], #2>R
    [{x: 0,y: 0},{x:-2,y: 0},{x: 1,y: 0},{x:-2,y: 1},{x: 1,y:-2}], #L>2
    [{x: 0,y: 0},{x:-1,y: 0},{x: 2,y: 0},{x:-1,y:-2},{x: 2,y: 1}]  #0>L
  ]
  superOffsetIRight: [
    [{x: 0,y: 0},{x: 1,y: 0},{x:-2,y: 0},{x: 1,y: 2},{x:-2,y:-1}], #L>0
    [{x: 0,y: 0},{x:-2,y: 0},{x: 1,y: 0},{x:-2,y: 1},{x: 1,y:-2}], #0>R
    [{x: 0,y: 0},{x:-1,y: 0},{x: 2,y: 0},{x:-1,y:-2},{x: 2,y: 1}], #R>2
    [{x: 0,y: 0},{x: 2,y: 0},{x:-1,y: 0},{x: 2,y:-1},{x:-1,y: 2}]  #2>L
  ]

  getOffsetLeft: (field, currentMino) ->
    currentMino.mino.rotateLeft()
    i=0
    loop
      currentOffsetA = if currentMino.mino.minoId == 2 or currentMino.mino.minoId == 4 then {x:0,y:0} else @offsetLeft[currentMino.mino.rotateState]
      currentOffsetB = if currentMino.mino.minoId == 4 then @superOffsetILeft[currentMino.mino.rotateState][i] else @superOffsetLeft[currentMino.mino.rotateState][i]
      compoundOffset = {x: currentOffsetA.x+currentOffsetB.x, y: currentOffsetA.y+currentOffsetB.y}
      if !currentMino.checkHit(field,currentMino.x+compoundOffset.x,currentMino.y+compoundOffset.y)
        currentMino.mino.rotateRight()
        return {x: compoundOffset.x, y: compoundOffset.y}
      if i == 4 then break else i++
    currentMino.mino.rotateRight()
    return null
  getOffsetRight: (field, currentMino) ->
    currentMino.mino.rotateRight()
    i=0
    loop
      currentOffsetA = if currentMino.mino.minoId == 2 or currentMino.mino.minoId == 4 then {x:0,y:0} else @offsetRight[currentMino.mino.rotateState]
      currentOffsetB = if currentMino.mino.minoId == 4 then @superOffsetIRight[currentMino.mino.rotateState][i] else @superOffsetRight[currentMino.mino.rotateState][i]
      compoundOffset = {x: currentOffsetA.x+currentOffsetB.x, y: currentOffsetA.y+currentOffsetB.y}
      if !currentMino.checkHit(field,currentMino.x+compoundOffset.x,currentMino.y+compoundOffset.y)
        currentMino.mino.rotateLeft()
        return {x: compoundOffset.x, y: compoundOffset.y}
      if i == 4 then break else i++
    currentMino.mino.rotateLeft()
    return null
