let minSlider = document.getElementById('min');
let maxSlider = document.getElementById('max');
let outputMin = document.getElementById('min-value');
let outputMax = document.getElementById('max-value');

outputMin.innerHTML = minSlider.value;
outputMin.innerHTML = maxSlider.value;

minSlider.oninput = function(){
  outputMin.innerHTML=this.value;
}
maxSlider.oninput = function(){
  outputMax.innerHTML=this.value;
}
