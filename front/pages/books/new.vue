<template>
  <members-only>
    <BookForm type="new"/>
  </members-only>
</template>

<script>
import BookForm from '~/components/BookForm.vue';
import MembersOnly from '~/components/MembersOnly';

export default {
  components: {
    BookForm,
    MembersOnly
  }
}
</script>

<style>

</style>
