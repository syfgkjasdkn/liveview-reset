export const MapHook = {
  async mounted() {
    const { default: L } = await import("mapbox.js");
    this.map = L.map(this.el).setView([51.505, -0.09], 13);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(this.map);

    // don't allow the map to hijack page scrolling
    this.map.scrollWheelZoom.disable();
  },
  destroyed() {
    if (this.map) this.map.remove();
  },
};
