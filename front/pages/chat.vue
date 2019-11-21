<template>
  <v-container>
    <ul>
      <li v-for="message in messages" :key="message">{{ message }}</li>
    </ul>
    <v-text-field v-model="inputMessage"/>
      <v-btn @click="submitMessage" class="primary">Submit!</v-btn>
  </v-container>
</template>

<script>
import cable from '~/plugins/actioncable.js';

export default {

  data() {
    return {
      messages: ["チャット", "できたかも"],
      inputMessage: '',
    }
  },

  created() {
    this.messageChannel = cable.subscriptions.create("RoomChannel", {
      received: (data) => {
        this.messages.push(data.message);
      },
    });
  },

  methods: {
    submitMessage() {
      this.messageChannel.perform('speak', { message: this.inputMessage });
      this.inputMessage = '';
    }
  }
}
</script>

<style>

</style>
