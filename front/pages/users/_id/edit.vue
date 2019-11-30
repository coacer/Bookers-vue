<template>
  <v-card class="pa-10 mx-auto mt-10" width="50%">
    <v-form>
      <input type="file" @change="setImage">
      <v-card-actions>
        <v-btn @click="submit">保存</v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
export default {

  data() {
    return {
      image: null,
    }
  },

  methods: {
    setImage(e) {
      this.image = e.target.files[0];
    },
    async submit(e) {
      const data = new FormData();
      data.append("profile_image", this.image);
      await this.$axios.patch(`/api/v1/users/${this.$route.params.id}`, data);
      this.$router.push({ name: 'users-id', params: { id: this.$route.params.id } });
    }
  },

}
</script>

<style>

</style>
