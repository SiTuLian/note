let onmessage = function(event){
  let result = [];
  console.log('cooking...');
  setTimeout(()=>{
    result.price = 15;
    postMessage(result)
  }, 1000)
}
