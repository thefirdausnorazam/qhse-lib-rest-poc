//provide support for safari and other ios & non-compliant browsers
function hasHtml5Validation () {
  return typeof document.createElement('input').checkValidity === 'function';
}

if (hasHtml5Validation()) {
  $('.validate-form').submit(function (e) {
    if (!this.checkValidity()) {
      e.preventDefault();
      $(this).addClass('invalid');
      $('#status').html('invalid');
    } else {
      $(this).removeClass('invalid');
      $('#status').html('submitted');
    }
  });
}
//math to text functions by Ian L. of Jafty.com
function makenumber(numb){
if(numb==1)return "One";
if(numb==2)return "Two";
if(numb==3)return "Three";
if(numb==4)return "Four";
if(numb==5)return "Five";
if(numb==6)return "Six";
if(numb==7)return "Seven";
if(numb==8)return "Eight";
if(numb==9)return "Nine";
if(numb==10)return "Ten";
}//end makenumber function
function placenumber(){
var x = Math.floor((Math.random() * 10) + 1);
var y = Math.floor((Math.random() * 10) + 1);
var no1 = makenumber(x);
var no2 = makenumber(y);
var ans = x+y;
document.getElementById('answer').pattern=ans;
jQuery('#no1').text(no1);
jQuery('#no2').text(no2);
}//end placenumber function