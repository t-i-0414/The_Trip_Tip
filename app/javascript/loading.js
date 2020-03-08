$(window).on('load', () => {
  $('#loading').delay(100).fadeOut();
});

history.replaceState(null, document.getElementsByTagName('title')[0].innerHTML, null);
window.addEventListener('popstate', function (e) {
  window.location.reload();
});
