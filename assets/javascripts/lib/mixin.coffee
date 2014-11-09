define ['jquery', 'underscore', 'moment'], ($, _, moment) ->

  debug = console.debug or console.log

  debugCalled = 0

  debugColors = [
    ['#DE212A', '#FFFFFF']
    ['#F6C6C8', '#000000']
    ['#E9642D', '#FFFFFF']
    ['#F9D8C8', '#000000']
    ['#FAC92F', '#FFFFFF']
    ['#FEF1C2', '#000000']
    ['#149617', '#FFFFFF']
    ['#C0E4C0', '#000000']
    ['#0D6B74', '#FFFFFF']
    ['#C0DADC', '#000000']
    ['#2880E2', '#FFFFFF']
    ['#C8DEF7', '#000000']
    ['#0D56C9', '#FFFFFF']
    ['#C0D4F1', '#000000']
    ['#532BE3', '#FFFFFF']
    ['#D4C6F7', '#000000']
  ]

  $mainScript = $ '#script'

  _.mixin

    isDebug: ->
      $mainScript = $ '#script' if $mainScript.length is 0
      return /require\.js$/.test $mainScript.attr 'src'

    moment: (date) ->
      return moment date

    debug: (label) ->
      label = label.name if typeof label is 'function'
      if _.isDebug()
        color = debugColors[debugCalled++ % debugColors.length]
        return ->
          callee = new Error().stack.split('\n')[1]
          callee = if /@/.test callee then callee.replace /@.*$/, '' else null
          debug.apply console, [].concat [
            "%c#{label}#{if callee then '::' + callee else ''}"
            "padding:1px;background:#{color[0]};color:#{color[1]}"
          ], arguments.callee.caller.arguments, Array::slice.call arguments
      else
        return -> return

  return _
