App.machines = App.cable.subscriptions.create('MachinesChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: (data) => {
    // TODO: Refactor to React Component
    switch (data.event) {
      case 'LAST_ACTIVE_UPDATED': {
        $(`#${data.serial} .time`).text((new Date(data.last_active)).toLocaleString());
        break;
      }
      case 'SHUTDOWN': {
        $(`#${data.serial} .time`).text('');
        break;
      }
      default: {
        break;
      }
    }
  },
});
