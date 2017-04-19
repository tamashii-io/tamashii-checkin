App.index = App.cable.subscriptions.create('IndexChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: (data) => {
    // Called when there's incoming data on the websocket for this channel
    $('#machine_num').text(data.machine_nums);
  },
});
