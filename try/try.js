// The /try/ page: pick the computer, copy the command, tick the checklist. Without JavaScript every panel and command is visible and selectable.
(function () {
  var KEY_OS = "zyvor-retail-try-os", KEY_TICKS = "zyvor-retail-try-ticks";
  function get(k) { try { return localStorage.getItem(k); } catch (e) { return null; } }
  function set(k, v) { try { localStorage.setItem(k, v); } catch (e) { /* private mode */ } }

  var group = document.querySelector(".oseg");
  var panels = [].slice.call(document.querySelectorAll(".os-panel"));
  var buttons = group ? [].slice.call(group.querySelectorAll('[role="radio"]')) : [];
  function guess() {
    var ua = (navigator.userAgent || "") + " " + (navigator.platform || "");
    if (/Win/i.test(ua)) return "windows";
    if (/Mac|iPhone|iPad/i.test(ua)) return "mac";
    if (/Linux|X11|CrOS/i.test(ua)) return "linux";
    return "mac";
  }
  function show(os, remember) {
    buttons.forEach(function (b) {
      var on = b.getAttribute("data-value") === os;
      b.setAttribute("aria-checked", on ? "true" : "false");
      b.tabIndex = on ? 0 : -1;
    });
    panels.forEach(function (p) { p.hidden = p.getAttribute("data-os") !== os; });
    if (remember) set(KEY_OS, os);
  }
  if (buttons.length) {
    var saved = get(KEY_OS);
    show(/^(mac|windows|linux)$/.test(saved || "") ? saved : guess(), false);
    buttons.forEach(function (b, i) {
      b.addEventListener("click", function () { show(b.getAttribute("data-value"), true); });
      b.addEventListener("keydown", function (e) {
        var n = { ArrowRight: i + 1, ArrowDown: i + 1, ArrowLeft: i - 1, ArrowUp: i - 1, Home: 0, End: buttons.length - 1 }[e.key];
        if (n === undefined) return;
        e.preventDefault();
        var t = buttons[(n + buttons.length) % buttons.length];
        show(t.getAttribute("data-value"), true); t.focus();
      });
    });
  }

  [].forEach.call(document.querySelectorAll(".copy"), function (btn) {
    btn.addEventListener("click", function () {
      var el = document.getElementById(btn.getAttribute("data-copy"));
      if (!el) return;
      var text = el.textContent.trim();
      function done() {
        btn.textContent = "Copied"; btn.classList.add("done");
        setTimeout(function () { btn.textContent = "Copy"; btn.classList.remove("done"); }, 2000);
      }
      function fallback() {
        var r = document.createRange(); r.selectNodeContents(el);
        var s = window.getSelection(); s.removeAllRanges(); s.addRange(r);
        try { if (document.execCommand("copy")) done(); } catch (e) { /* leave selected */ }
      }
      if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(text).then(done, fallback); else fallback();
    });
  });

  var boxes = [].slice.call(document.querySelectorAll('.drive input[type="checkbox"]'));
  var count = document.getElementById("drive-count");
  var ticks = {};
  try { ticks = JSON.parse(get(KEY_TICKS) || "{}") || {}; } catch (e) { ticks = {}; }
  function tally() { if (count) count.textContent = String(boxes.filter(function (b) { return b.checked; }).length); }
  boxes.forEach(function (b) {
    b.checked = !!ticks[b.getAttribute("data-k")];
    b.addEventListener("change", function () { ticks[b.getAttribute("data-k")] = b.checked; set(KEY_TICKS, JSON.stringify(ticks)); tally(); });
  });
  tally();
})();
