<template>
  <div>
    <v-alert type="error" v-show="errorMessage">{{ errorMessage }}</v-alert>
      <v-card width="50%" class="mx-auto mt-5">
        <v-card-title>Sign Up</v-card-title>
        <v-card-text>
          <v-form>
            <v-text-field v-model="email" prepend-icon="mdi-email" label="Email"/>
            <v-text-field v-model="password" @click:append="showPassword = !showPassword" prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye-off' : 'mdi-eye'" :type="showPassword ? 'text' : 'password'" label="Password"/>
            <v-text-field v-model="passwordConfirmation" @click:append="showPassword = !showPassword" prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye-off' : 'mdi-eye'" :type="showPassword ? 'text' : 'password'" label="Password Confirmation"/>
            <v-card-actions>
              <v-btn class="info" @click="signup">Sign Up</v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </div>
</template>

<script>
import firebase from '~/plugins/firebase';
import { mapActions, mapGetters } from 'vuex';

export default {
  data() {
    return {
      email: '',
      password: '',
      passwordConfirmation: '',
      showPassword: false,
      errorMessage: ''
    }
  },
  mounted() {
    firebase.auth().onAuthStateChanged((user) => {
      this.setUser(user)
      if(this.isAuthenticated) {
        this.$router.push('/');
      }
    });
  },
  computed: {
    ...mapGetters(['isAuthenticated']),
  },
  methods: {
    ...mapActions(['setUser']),
    async signup() {
      try {
        if(!(this.password === this.passwordConfirmation)) {
          throw new Error('パスワードが一致しません');
        }
        await firebase.auth().createUserWithEmailAndPassword(this.email, this.password);
        this.setUser(user);
        this.$router.push('/');
      } catch(error) {
        this.errorMessage = error;
      }
    }
  }
}
</script>

<style>

</style>
