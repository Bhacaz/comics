<template>
  <section class="hero is-warning">
    <div class="hero-body">
      <p class="title">Comics</p>
      <p class="subtitle">Nice design from <em>readcomicsonline.ru</em></p>
    </div>
  </section>

  <section class="section">
    <input
      class="input is-rounded"
      type="text"
      placeholder="Search"
      v-model="search"
    />
  </section>
</template>

<script>
export default {
  name: "Home",
  components: {},
  data() {
    return {
      search: null,
    };
  },
  mounted() {
    this.$watch("search", () => {
      fetch("https://readcomicsonline.ru/search?query=" + this.search, {
        headers: { Origin: "https://readcomicsonline.ru" },
      })
        .then((res) => res.json())
        .then((result) => {
          console.log(result);
        });
    });
  },
};
</script>
