document.addEventListener('DOMContentLoaded', function() {

  // Override '100vh' to prevent height changing on mobile browsers
  var firstPage = document.getElementsByClassName('first-page')[0];
  firstPage.style.minHeight = firstPage.offsetHeight + 'px';

  // Hidden texts
  var hiddenTextElements = document.getElementsByClassName('text-hidden-by-default');
  for (var i = 0; i < hiddenTextElements.length; i++) {
    var el = hiddenTextElements[i];
    var button = document.createElement('a');
    button.href = 'javascript:void(0);'
    button.setAttribute('role', 'button');
    button.classList.add('text-hidden-by-default-expand-button');
    button.innerText = el.dataset.buttonText;
    button.addEventListener('click', function(event) {
      event.preventDefault();
      el.classList.add('text-hidden-by-default-expanded');
      button.parentNode.removeChild(button);
    });
    el.parentNode.insertBefore(button, el);
  }

});
