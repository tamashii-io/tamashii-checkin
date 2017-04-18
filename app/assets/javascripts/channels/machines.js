App.machines = App.cable.subscriptions.create("MachinesChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
      // TODO: Refactor to React Component
      if(data.event === 'LAST_ACTIVE_UPDATED') {
          $(`#${data.serial} .time`).text((new Date(data.last_active)).toLocaleString());
      }
  }
});
