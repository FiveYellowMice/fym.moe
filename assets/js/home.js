document.addEventListener('DOMContentLoaded', function() {

  // Override '100vh' to prevent height changing on mobile browsers
  var firstPage = document.getElementsByClassName('first-page')[0];
  firstPage.style.minHeight = firstPage.offsetHeight + 'px';

});
