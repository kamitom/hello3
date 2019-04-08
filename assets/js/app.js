// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

let channel = socket.channel("room:lobby", {})
let chatInput = document.querySelector("#chat-input")
let messagesContainer = document.querySelector("#messages")

let eli_channel = socket.channel("eliroom:lobby", {})
let eli_chatInput = document.querySelector("#eli-chat")
let eli_messagesContainer = document.querySelector("#eli-messages")

chatInput.addEventListener("keypress", event => {
  if (event.keyCode == 13) {
    channel.push("new_msg", {body: chatInput.value})
    chatInput.value = ''
  }
})

// eli_chatInput.addEventListener("keypress", event => {
//    if (event.keyCode == 13) {
//      eli_channel.push("new_msg", {
//        body: eli_chatInput.value
//      })
//      eli_chatInput.value = ''
//    }
// })


channel.on("new_msg", payload => {
  let messageItem = document.createElement("li")
  messageItem.innerText = `[${Date()}] : ${payload.body}`
  messagesContainer.appendChild(messageItem)
})

// eli_channel.on("new_msg", payload => {
//   let eli_messageItem = document.createElement("li")
//   eli_messageItem.innerText = `[${Date()}] : ${payload.body}`
//   eli_messagesContainer.appendChild(eli_messageItem)
// })

// channel.join()

channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)
  })
  .receive("error", resp => {
    console.log("Unable to join", resp)
  })


// eli_channel.join()

export default socket
