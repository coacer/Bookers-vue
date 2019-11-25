<template>
  <v-container>
    <h2>{{ user.name }}さんとDM</h2>
    <h3>ルームid: {{ roomId }}</h3>
    <ul>
      <li v-for="message in messages" :key="message.id">{{ message.from.name }} / {{ message.content }}</li>
    </ul>
    <v-text-field v-model="inputMessage"/>
      <v-btn @click="submitMessage" class="primary">Submit!</v-btn>
  </v-container>
</template>

<script>
import cable from '~/plugins/actioncable.js';
import { mapState } from 'vuex';

export default {

  data() {
    return {
      roomId: null,
      messages: [],
      user: {},
      inputMessage: '',
    }
  },

  computed: {
    ...mapState(['userId']),
  },

  async created() {
    const userId = this.$route.params.userId;
    const userResponse = await this.$axios.get(`/api/v1/users/${userId}`);
    this.user = userResponse.data;

    this.roomId = this.calcRoomId(this.userId, userId);
    console.log("roomId:", this.roomId);
    const roomResponse = await this.$axios.post('/api/v1/room/messages', { roomId: this.roomId });
    this.messages = roomResponse.data;
    const roomChannel = { channel: "RoomChannel", roomId: this.roomId };

    console.log("roomId: ",this.roomId);
    this.messageChannel = cable.subscriptions.create(roomChannel, {
      received: (data) => {
        if(!!data) {
          console.log("data", data);
          console.log("data.from", data.from);
          this.messages.push(data);
        }
      },
    });
  },

  methods: {
    submitMessage() {
      this.messageChannel.perform('speak', {
        roomId: this.roomId,
        content: this.inputMessage,
        fromId: this.userId,
        toId: this.user.id
      });
      this.inputMessage = '';
    },
    calcRoomId(currentUserId, otherUserId) {
      return currentUserId < otherUserId ? `${currentUserId}-${otherUserId}`
       : `${otherUserId}-${currentUserId}`;
    }
  }
}
</script>

<style>

</style>

