$(() => {
  userDrawer = $('.user_drawer').length;
  if (userDrawer == 0) {
    $('#userDetailOpen').css({
      'display': 'none'
    });
  }
});
