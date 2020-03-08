$(window).on('load', () => {
  $('#loading').delay(100).fadeOut();
});

window.onbeforeunload = function () {
  // IE用。
};
window.onunload = function () {
  // IE以外用。
};

window.addEventListener("pageshow", function (event) {
  if (event.persisted) {
    $('#loading').delay(100).fadeOut();
    window.location.reload();
  }
});
