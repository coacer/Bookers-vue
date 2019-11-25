<template>
  <v-container>
    <div class="room-wrapper mx-auto">
      <div
        v-for="message in messages"
        :key="message.id"
        :class="['chat-container', 'd-flex', (isMessageOfCurrentUser(message) ? 'justify-end' : 'justify-start')]"
        >
        <div>
          <p class="grey--text">{{ message.from.name }}</p>
          <v-alert
            class="d-inline-block font-weight-bold d-inline-flex"
            color="success white--text"
            >
            {{ message.content }}
          </v-alert>
        </div>
      </div>
      <v-text-field v-model="inputMessage"/>
        <v-btn @click="submitMessage" class="green lighten-4">Submit!</v-btn>
    </div>
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
    // 相手ユーザーの取得
    const userId = this.$route.params.userId;
    const userResponse = await this.$axios.get(`/api/v1/users/${userId}`);
    this.user = userResponse.data;

    // ルームID取得
    this.roomId = this.calcRoomId(this.userId, userId);

    // メッセージ取得
    const roomResponse = await this.$axios.post('/api/v1/room/messages', { roomId: this.roomId });
    this.messages = roomResponse.data;

    // チャンネルをサブスクライブ
    const roomChannel = { channel: "RoomChannel", roomId: this.roomId };
    this.messageChannel = cable.subscriptions.create(roomChannel, {
      received: (data) => {
        if(!!data) {
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
    },
    isMessageOfCurrentUser(message) {
      return message.from.id === this.userId;
    },
  }
}
</script>

<style scoped>
.room-wrapper {
  max-width: 700px;
}
</style>

