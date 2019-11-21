<template>
  <v-container>
    <h2>{{ user.name }}さんとDM</h2>
    <ul>
      <li v-for="message in messages" :key="message">{{ message }}</li>
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
      messages: ["チャット", "できたかも"],
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

    const roomResponse = await this.$axios.post('/api/v1/get_room_info', {
      currentUserId: this.userId,
      otherUserId: userId
    });
    this.messages = roomResponse.data.messages;
    this.roomId = roomResponse.data.roomId;
    const roomChannel = { channel: "RoomChannel", roomId: this.roomId };

    this.messageChannel = cable.subscriptions.create(roomChannel, {
      received: (data) => {
        this.messages.push(data.message);
      },
    });
  },

  methods: {
    submitMessage() {
      this.messageChannel.perform('speak', { roomId: this.roomId, message: this.inputMessage });
      this.inputMessage = '';
    }
  }
}
</script>

<style>

</style>

