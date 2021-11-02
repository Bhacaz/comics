<template>
  <div id="reader">
    <div id="image-container">
      <img class="page" v-bind:src="baseComicPage + pageNumber + '.jpg'" />
    </div>
    <div id="overlay-control">
      <div class="columns">
        <div
          id="top-control"
          class="column is-full"
          @click="toggleFullscreen2()"
        ></div>
      </div>
      <div id="left-right-control-container" class="columns">
        <div
          id="left-control"
          class="column is-half"
          @click="changePage(-1)"
        ></div>
        <div
          id="right-control"
          class="column is-half"
          @click="changePage(1)"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
import screenfull from "screenfull";

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
    toggleFullscreen2() {
      screenfull.toggle(this.$el);
    },
  },
  created() {},
};
</script>

<style>
#image-container {
  height: 100vh;
  width: 100%;
  background-color: black;
  margin: 0;
  padding-top: 3em;
}

.page {
  object-fit: scale-down;
  width: 100%;
  height: 100%;
}

#reader {
  display: grid;
}

#image-container,
#overlay-control {
  grid-area: 1 / 1;
}

#overlay-control {
  height: 100vh;
}

#top-control {
  height: 10em;
  /*border: 1px red solid;*/
}

#right-control {
  /*border: 1px greenyellow solid;*/
}

#left-control {
  /*border: 1px blue solid;*/
}

#left-right-control-container {
  height: calc(100vh - 10em);
}

.columns {
  margin: 0 !important;
}
</style>
