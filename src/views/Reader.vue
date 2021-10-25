<template>
  <div id="navigation">
    <button class="button is-dark" @click="changePage(-1)">Previous</button>
    <span>{{ pageNumber }}</span>
    <button class="button is-dark" @click="changePage(1)">Next</button>
  </div>
  <div id="image-container">
    <img class="page" v-bind:src="basePageSrc + '0' + pageNumber + '.jpg'" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      basePageSrc:
        "https://readcomicsonline.ru/uploads/manga/infinity-gauntlet-19911992/chapters/1/",
      pageNumber: 1,
    };
  },
  methods: {
    changePage(direction) {
      this.pageNumber += direction;
    },
  },
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
