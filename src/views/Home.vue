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
      <a
        class="panel-block"
        v-for="result in searchResults"
        v-bind:key="result.data"
        target="”_blank”"
        v-bind:href="'https://readcomicsonline.ru/comic/' + result.data"
      >
        {{ result.value }}
      </a>
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
      fetch("http://localhost:8000/api/search?query=" + this.search, {
        headers: { Origin: "https://readcomicsonline.ru" },
      })
        .then((res) => res.json())
        .then((result) => {
          this.searchResults = result.slice(0, 10);
        });
    });
  },
};
</script>
