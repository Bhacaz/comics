class ComicPage {
  constructor(comicId, chapterId, pageNumber) {
    this.comicId = comicId;
    this.chapterId = chapterId;
    this.pageNumber = pageNumber;
    this.pageUrl = this.toImage().src;
  }

  buildUrl() {
    return (
      "https://readcomicsonline.ru/uploads/manga/" +
      this.comicId +
      "/chapters/" +
      this.chapterId +
      "/" +
      this.pageNumberToString() +
      ".jpg"
    );
  }

  pageNumberToString() {
    const stringPageNumber = this.pageNumber.toString();
    if (stringPageNumber.length > 1) {
      return stringPageNumber;
    }
    return "0" + stringPageNumber;
  }

  readerPath() {
    return `/reader/${this.comicId}/${this.chapterId}/${this.pageNumber}`;
  }

  next() {
    return new ComicPage(this.comicId, this.chapterId, this.pageNumber + 1);
  }

  previous() {
    if (this.pageNumber === 1) {
      return this;
    }
    return new ComicPage(this.comicId, this.chapterId, this.pageNumber - 1);
  }

  toImage() {
    const image = new Image();
    image.src = this.buildUrl();
    return image;
  }
}

export default ComicPage;
