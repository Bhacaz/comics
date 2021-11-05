module.exports = {
  lintOnSave: false,

  pwa: {
    themeColor: "#FBE34C",
    msTileColor: "#FBE34C",
    manifestOptions: {
      background_color: "#FBE34C",
      display: "fullscreen",
      name: "Comics",
      icons: [
        {
          src: "/img/manifest/icon-192x192.png",
          sizes: "192x192",
          type: "image/png",
        },
        {
          src: "/img/manifest/icon-256x256.png",
          sizes: "256x256",
          type: "image/png",
        },
        {
          src: "/img/manifest/icon-384x384.png",
          sizes: "384x384",
          type: "image/png",
        },
        {
          src: "/img/manifest/icon-512x512.png",
          sizes: "512x512",
          type: "image/png",
        },
      ],
    },
    workboxOptions: {
      exclude: ["index.html"],
    },
  },
};
