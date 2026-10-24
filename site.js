// Theme toggle, scroll-spy, the screenshot gallery, reveal-on-scroll. No dependencies; everything degrades to a static page.
(function () {
  var root = document.documentElement;
  var KEY = (window.__zyretailTheme || {}).key || "zyretail-site-theme";
  var btn = document.getElementById("theme");
  var reduce = window.matchMedia && matchMedia("(prefers-reduced-motion: reduce)").matches;

  function paint(theme) {
    root.setAttribute("data-theme", theme);
    var m = document.querySelector('meta[name="theme-color"]');
    if (m) m.setAttribute("content", theme === "dark" ? "#000000" : "#ffffff");
    if (btn) {
      btn.setAttribute("aria-pressed", theme === "dark" ? "true" : "false");
      btn.setAttribute("aria-label", theme === "dark" ? "Switch to light mode" : "Switch to dark mode");
    }
  }

  // ---- gallery: scene x appearance, all real captures of the app (synthetic data)
  var state = { mode: root.getAttribute("data-theme") === "dark" ? "dark" : "light", view: "overview" };
  var LABEL = {
    light: "light", dark: "dark",
    overview: "Your daily view", login: "Sign in", pos: "Point of sale", products: "Products", inventory: "Inventory", suggestions: "Reorder and expiry suggestions", finance: "Finance", shop: "Public pickup storefront"
  };
  var img = document.getElementById("shot"), cap = document.getElementById("shot-cap");
  var groups = [].slice.call(document.querySelectorAll(".seg"));

  function syncControls() {
    groups.forEach(function (g) {
      [].forEach.call(g.querySelectorAll('[role="radio"]'), function (b) {
        var on = b.getAttribute("data-value") === state[g.getAttribute("data-key")];
        b.setAttribute("aria-checked", on ? "true" : "false");
        b.tabIndex = on ? 0 : -1;
      });
    });
  }
  function render() {
    var src = "shots/" + state.mode + "-" + state.view + ".jpg";
    var text = LABEL[state.view] + " · " + LABEL[state.mode] + " · synthetic data";
    var alt = "Zyvor Retail: " + LABEL[state.view] + ", " + LABEL[state.mode] + " appearance, synthetic data";
    syncControls();
    if (!img || img.getAttribute("src") === src) { if (cap) cap.textContent = text; return; }
    img.classList.add("swap");
    var pre = new Image();
    pre.onload = pre.onerror = function () { img.src = src; img.alt = alt; img.classList.remove("swap"); };
    pre.src = src;
    if (cap) cap.textContent = text;
  }
  groups.forEach(function (g) {
    var radios = [].slice.call(g.querySelectorAll('[role="radio"]'));
    radios.forEach(function (b, i) {
      b.addEventListener("click", function () { state[g.getAttribute("data-key")] = b.getAttribute("data-value"); render(); });
      b.addEventListener("keydown", function (e) {
        var n = { ArrowRight: i + 1, ArrowDown: i + 1, ArrowLeft: i - 1, ArrowUp: i - 1, Home: 0, End: radios.length - 1 }[e.key];
        if (n === undefined) return;
        e.preventDefault();
        var t = radios[(n + radios.length) % radios.length];
        state[g.getAttribute("data-key")] = t.getAttribute("data-value"); render(); t.focus();
      });
    });
  });

  paint(root.getAttribute("data-theme") || "light");
  render();
  if (btn) btn.addEventListener("click", function () {
    var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
    try { localStorage.setItem(KEY, next); } catch (e) { /* private mode */ }
    paint(next);
    state.mode = next; render(); // the gallery follows the page
  });

  // ---- scroll-spy
  var links = [].slice.call(document.querySelectorAll("#sections a"));
  if ("IntersectionObserver" in window && links.length) {
    var byId = {};
    links.forEach(function (a) { byId[a.getAttribute("href").slice(1)] = a; });
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (!e.isIntersecting) return;
        links.forEach(function (a) { a.removeAttribute("aria-current"); });
        var a = byId[e.target.id]; if (a) a.setAttribute("aria-current", "true");
      });
    }, { rootMargin: "-40% 0px -55% 0px" });
    Object.keys(byId).forEach(function (id) { var s = document.getElementById(id); if (s) io.observe(s); });
  }

  // ---- click-to-play clips: a still poster until asked (no autoplay, so nothing moves for people who do not want it)
  [].forEach.call(document.querySelectorAll(".clip"), function (fig) {
    var btn = fig.querySelector(".play"), im = fig.querySelector("img");
    if (!btn || !im) return;
    btn.addEventListener("click", function () { im.src = im.getAttribute("data-gif"); fig.classList.add("on"); });
  });

  // ---- reveal on scroll (content is visible without JS or with reduced motion)
  var rv = [].slice.call(document.querySelectorAll(".rv"));
  if (!reduce && "IntersectionObserver" in window) {
    root.classList.add("js-rv");
    var ro = new IntersectionObserver(function (es) {
      es.forEach(function (e) { if (e.isIntersecting) { e.target.classList.add("in"); ro.unobserve(e.target); } });
    }, { rootMargin: "0px 0px -8% 0px" });
    rv.forEach(function (el, i) { el.style.transitionDelay = (i % 4) * 70 + "ms"; ro.observe(el); });
  } else {
    rv.forEach(function (el) { el.classList.add("in"); });
  }
})();
