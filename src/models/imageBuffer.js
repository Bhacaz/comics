class ImageBuffer {
  constructor(currentItem) {
    this.currentValue = currentItem; // Must be a ComicPage
    const nextItem = currentItem.next();
    this.buffer = [
      currentItem.previous(),
      currentItem,
      nextItem,
      nextItem.next(),
    ];
  }

  current() {
    return this.buffer[1];
  }

  foward() {
    this.buffer.shift();
    const lastItem = this.buffer[this.buffer.length - 1];
    this.buffer.push(lastItem.next());
  }

  backward() {
    this.buffer.pop();
    this.buffer.unshift(this.buffer[0].previous());
  }
}

export default ImageBuffer;
