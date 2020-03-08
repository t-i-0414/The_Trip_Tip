$(window).on('load', () => {
  $('#loading').delay(100).fadeOut();
});

// window.onbeforeunload = function () {
//   // IE用。
// };
// window.onunload = function () {
//   // IE以外用。
// };

// window.addEventListener("pageshow", function (event) {
//   if (event.persisted) {
//     $('#loading').delay(100).fadeOut();
//     window.location.reload();
//   }
// });

// window.onpageshow = function (event) {
//   if (event.persisted) {
//     $('#loading').delay(100).fadeIn(100);
//     window.location.reload();
//   }
// };

history.replaceState(null, document.getElementsByTagName('title')[0].innerHTML, null);
window.addEventListener('popstate', function (e) {
  window.location.reload();
});
