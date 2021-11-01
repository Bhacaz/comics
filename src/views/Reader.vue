<template>
  <div id="navigation">
    <button class="button is-dark" @click="changePage(-1)">Previous</button>
    <span>{{ pageNumber }}</span>
    <button class="button is-dark" @click="changePage(1)">Next</button>
  </div>
  <div id="image-container">
    <img class="page" v-bind:src="baseComicPage + '0' + pageNumber + '.jpg'" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      baseComicPage:
        "https://readcomicsonline.ru/uploads/manga/" +
        this.$route.params.id +
        "/chapters/" +
        this.$route.params.chapterId +
        "/",
      pageNumber: 1,
    };
  },
  methods: {
    changePage(direction) {
      this.pageNumber += direction;
    },
  },
  created() {},
};
</script>

<style>
#image-container {
  height: calc(100vh - 40px);
  width: 100%;
  background-color: black;
  margin: 0;
}

.page {
  object-fit: scale-down;
  width: 100%;
  height: 100%;
}

#navigation {
  display: flex;
  justify-content: space-between;
  background-color: black;
  color: white;
}

#navigation button {
  width: 8em;
}
</style>
