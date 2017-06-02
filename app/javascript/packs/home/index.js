import { MachineChannel } from '../channels';

class Home {
  constructor() {
    MachineChannel.onReceived(action => this.update(action));

    this.activated = false;
    this.total_machines = 0;
    this.$machine_status_bar = null;
    this.$machine_counts = null;
  }

  on() {
    this.activated = true;
    this.$machine_counts = document.querySelector('#machine_num');
    this.$machine_status_bar = document.querySelector('#machine_num_bar .progress .progress-bar');
    if (!this.$machine_counts || !this.$machine_status_bar) {
      this.activated = false;
      return;
    }
    this.total_machines = parseInt(this.$machine_counts.innerText, 10);
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
