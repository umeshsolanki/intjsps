var curr=1;
var alfa='a';
var beta;
function change()
{
beta=alfa;
alfa=alfa+1;
try{
if(alfa=='a1111111')
{
alfa='a';
toremove=document.getElementById(beta);
toremove.removeAttribute("class");
}
else
{
item=document.getElementById(alfa);
item.setAttribute("class","effect");
toremove=document.getElementById(beta);
toremove.removeAttribute("class");
}
}catch(Err){document.getElementById("err").innerText=Err.message;}
}
setInterval(change,8000);
