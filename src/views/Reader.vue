<template>
  <div id="reader">
    <div id="navigation">
      <button class="button is-dark" @click="changePage(-1)">Previous</button>
      <span>{{ parseInt(pageNumber) }}</span>
      <button class="button is-dark" @click="toggleFullscreen()">
        Fullscreen
      </button>
      <button class="button is-dark" @click="changePage(1)">Next</button>
    </div>
    <div id="image-container">
      <img class="page" v-bind:src="baseComicPage + pageNumber + '.jpg'" />
    </div>
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
      pageNumber: "01",
      isFullScreen: false,
    };
  },
  methods: {
    changePage(direction) {
      let newPage = parseInt(this.pageNumber) + direction;
      this.formattedPageNumber(newPage);
    },
    formattedPageNumber(newPage) {
      const stringPageNumber = newPage.toString();
      if (stringPageNumber.length === 1) {
        this.pageNumber = "0" + stringPageNumber;
      } else {
        this.pageNumber = stringPageNumber;
      }
    },
    toggleFullscreen() {
      if (!this.isFullScreen) {
        if (this.$el.requestFullscreen) {
          this.$el.requestFullscreen();
        } else if (this.$el.webkitRequestFullscreen) {
          /* Safari */
          this.$el.webkitRequestFullscreen();
        }
        this.isFullScreen = true;
      } else {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
          /* Safari */
          document.webkitExitFullscreen();
        }
        this.isFullScreen = false;
      }
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
