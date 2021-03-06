ws = undefined

$(document).ready ->
  host = location.origin.replace /^http/, 'ws'
  ws = new WebSocket host
  $("#myForm").submit (e) ->
    e.preventDefault()
  ws.onmessage = (msg) ->
    $(".spinner").removeClass "show"
    $(".spinner").addClass "hide"
    # console.log msg
    msg = JSON.parse msg.data
    handleSentiment msg

  $('#submit').on "click", ->
    style = "display:inline;"
    $(".spinner").removeClass "hide"
    $(".spinner").addClass "show"
    $('#sentiment').text ""
    $('#symbols').text ""
    text = $("#inText").val()
    msg =
      type: "message"
      text: text
    msg= JSON.stringify msg
    ws.send msg

handleSentiment = (sentiment) ->
  console.log  sentiment.opinion
  $('#sentiment').text "Sentiment: " + sentiment.opinion

  $('#symbols').text ""
  n = (Math.abs(sentiment.opinion) - (Math.abs(sentiment.opinion) % 10))/10
  n++
  for i in [0...n] by 1
    if (sentiment.opinion > 0)
      $('#symbols').append '<i class="fa fa-plus">&nbsp;</i>'
    else
      $('#symbols').append '<i class="fa fa-minus">&nbsp;</i>'

