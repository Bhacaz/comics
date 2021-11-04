function getProgression() {
  return JSON.parse(localStorage.getItem("progression"));
}

function setProgression(comicId, chapterId, pageNumber) {
  let currentProgression = getProgression("progression");
  if (currentProgression === null) {
    currentProgression = {};
  }
  currentProgression[comicId] = {
    chapterId: chapterId,
    pageNumber: pageNumber,
  };
  localStorage.setItem("progression", JSON.stringify(currentProgression));
}

export default {
  setProgression: setProgression,
  getProgression: getProgression,
};
