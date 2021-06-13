const closeModal = () => {
  const modalSubmitButton = document.querySelector('.submit');

  if (modalSubmitButton) {
    modalSubmitButton.addEventListener('click', (event) => {
      document.querySelector(".close").click();
    });
  };
};

export { closeModal };