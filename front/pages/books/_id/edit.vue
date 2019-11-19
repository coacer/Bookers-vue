<template>
  <members-only>
    <BookForm type="edit"/>
  </members-only>
</template>

<script>
import BookForm from '~/components/BookForm.vue';
import MembersOnly from '~/components/MembersOnly';

export default {
  components: {
    BookForm,
    MembersOnly
  },
  data() {
    return {
    }
  }
}
</script>

<style>

</style>
