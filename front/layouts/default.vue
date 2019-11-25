<template>
  <v-app>
    <TheHeader />
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from '~/components/TheHeader';
import TheFooter from '~/components/TheFooter';

export default {
  components: {
    TheHeader,
    TheFooter,
  },
}
</script>
