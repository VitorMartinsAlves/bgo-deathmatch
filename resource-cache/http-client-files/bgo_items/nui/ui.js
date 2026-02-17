  function erroquant(info, text) {	  
let timerInterval
Swal.fire({
  title: info,
  html: text,
  timer: 3000,
  timerProgressBar: true,
  willOpen: () => {
    Swal.showLoading()
    timerInterval = setInterval(() => {
      const content = Swal.getContent()
      if (content) {
        const b = content.querySelector('b')
        if (b) {
          b.textContent = Swal.getTimerLeft()
        }
      }
    }, 100)
  },
  onClose: () => {
    clearInterval(timerInterval)
  }
}).then((result) => {
  /* Read more about handling dismissals below */
  if (result.dismiss === Swal.DismissReason.timer) {
    console.log('I was closed by the timer')
  }
})

	 } 
	 
  function sucesso(text) {	
	 Swal.fire({

  icon: 'success',
  title: "Boa!",
  text: text,
  showConfirmButton: false,
  timer: 1500
})	 
	 } 	 
	 
