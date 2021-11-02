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
    <nav class="panel">
      <router-link
        class="panel-block"
        v-for="result in searchResults"
        v-bind:key="result.data"
        :to="'/comic/' + result.data"
      >
        {{ result.value }}
      </router-link>
    </nav>
  </section>
</template>

<script>
export default {
  name: "Home",
  components: {},
  data() {
    return {
      search: null,
      searchResults: [],
    };
  },
  mounted() {
    this.$watch("search", () => {
      console.log(process.env);
      fetch(process.env.VUE_APP_BASE_API + "/api/search?query=" + this.search)
        .then((res) => res.json())
        .then((result) => {
          this.searchResults = result.slice(0, 10);
        });
    });
  },
};
</script>
