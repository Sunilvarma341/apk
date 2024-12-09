import consumer from "./consumer"

consumer.subscriptions.create("RtcChannel", {
  connected() {
    console.log("WebSocket connected and subscription confirmed");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("WebSocket disconnected");

    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Data received:", data);
    // Called when there's incoming data on the websocket for this channel
  }
});
