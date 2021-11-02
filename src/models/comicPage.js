class ComicPage {
  constructor(comicId, chapterId, pageNumber) {
    this.comicId = comicId;
    this.chapterId = chapterId;
    this.pageNumber = pageNumber;
  }

  pageUrl() {
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
}

export default ComicPage;
