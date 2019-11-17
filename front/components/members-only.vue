<template>
  <div v-if="loaded">
    <slot/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      loaded: false
    }
  },
  computed: {
    ...mapGetters(['isAuthenticated'])
  },
  mounted() {
    setTimeout(() => {
      if(!this.isAuthenticated) {
        this.$router.push('/users/signin');
      }
      this.loaded = true
    }, 0);
  }
}
</script>

<style>

</style>
