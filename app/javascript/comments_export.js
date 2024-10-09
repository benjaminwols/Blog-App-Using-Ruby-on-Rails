// Used in posts_index view to change the text of the download-csv-export button so as to indicate
// to the user that something is happening, in case the generation of the export takes some time
document.addEventListener("DOMContentLoaded", () => {
  document
    .getElementById('download-csv-export-button')
    .addEventListener('click', function () {
      let currentButtonText = this.innerText
      this.innerText = 'Generating export ...'
      // Change the text back once the user focuses the window, since there's no non-hacky way to
      // check whether the download really has finished
      window.addEventListener(
        'focus',
        () => (this.innerText = currentButtonText),
        { once: true }
      )
    })
})
