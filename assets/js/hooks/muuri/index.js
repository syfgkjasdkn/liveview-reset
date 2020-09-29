export const MuuriHook = {
  async mounted() {
    const { default: Muuri } = await import("muuri");

    this.grid = new Muuri(this.el, {
      dragEnabled: true,
      dragSortPredicate: { action: "swap" },
      layout: { fillGaps: true },
    });

    window.grid = this.grid;
  },

  updated() {
    const newChildren = Array.from(this.el.children).filter((c) => {
      return !c.classList.contains("muuri-item");
    });

    this.grid.add(newChildren, { index: 0 });
  },
  reconnected() {
    this.grid.refreshItems();
    this.grid.layout();
  },
};

export function cloneContainer(from, to) {
  to.classList.add("muuri");
  to.style.cssText = from.style.cssText;
}

export function cloneItem(from, to) {
  const muuriClasses = Array.from(from.classList).filter((c) =>
    c.startsWith("muuri")
  );
  to.classList.add(...muuriClasses);
  to.style.cssText = from.style.cssText;
}
