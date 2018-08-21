let header = $('#header');
const scrollClass = 'header--scrolled'
const activateAtY = 10;

window.onscroll = e => {
  setHeader();
  $(window).scrollTop() > activateAtY
  ? (
    addHeaderScrolledClass()
  ) : (
    removeHeaderScrolledClass()
  );
}

const addHeaderScrolledClass = () => {
  if (! header.hasClass(scrollClass)) {
    header.addClass(scrollClass);
  }
};

const removeHeaderScrolledClass = () => {
  if (header.hasClass(scrollClass)) {
    header.removeClass(scrollClass);
  }
};

const setHeader = () => {
  header = $('#header');
}