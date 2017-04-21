import { EventEmitter } from 'events';

const Cable = ActionCable.createConsumer();

export const EventTypes = {
  Connected: 'CONNECTED',
  Disconnected: 'DISCONNECTED',
  Received: 'RECEIVED',
};

class Channel extends EventEmitter {
  constructor(channel) {
    super();
    this.channel = Cable.subscriptions.create(channel);
    this.channel.connected = () => this.emit(EventTypes.Connected);
    this.channel.disconnected = () => this.emit(EventTypes.Disconnected);
    this.channel.received = data => this.emit(EventTypes.Received, data);
  }

  onReceived(callback) {
    this.on(EventTypes.Received, callback);
  }

  off() {
    this.removeAllListener(EventEmitter.Received);
  }

  follow(options) {
    setTimeout(() => this.channel.perform('follow', options), 1000);
  }

  unfollow() {
    setTimeout(() => this.channel.perform('unfollow'), 1000);
  }

  perform(...args) {
    this.channel.perform(...args);
  }
}

export default Channel;

