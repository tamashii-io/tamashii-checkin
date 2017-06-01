import { MachineChannel } from '../channels';

class Home {
  constructor() {
    MachineChannel.onReceived(action => this.update(action));

    this.activated = false;
    this.total_machines = 0;
    this.$machine_status_bar = null;
  }

  on() {
    this.activated = true;
    this.total_machines = parseInt(document.querySelector('#machine_num').innerText, 10);
    this.$machine_status_bar = document.querySelector('#machine_num_bar .progress .progress-bar');
  }

  off() {
    this.activated = false;
  }

  update(action) {
    if (!this.activated) {
      return;
    }

    if (action.total !== undefined) {
      const percent = (action.total / this.total_machines) * 100;
      this.$machine_status_bar.style = `width: ${percent}%`;
    }
  }
}

export default new Home();
