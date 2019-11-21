import ActionCable from 'actioncable';
const cable = ActionCable.createConsumer('ws://localhost:4000/cable');
export default cable;
