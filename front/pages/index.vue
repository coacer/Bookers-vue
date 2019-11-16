<template>
  <BookList />
</template>

<script>
import axios from 'axios';
import BookList from '~/components/BookList.vue';

export default {
  components: {
    BookList,
  },
  mounted() {
    axios.get('/api/v1/books')
      .then(res => {
        console.log(res.data);
      });
  }
}
</script>
