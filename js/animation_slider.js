var curr=1;
function changesourse()
{
   if(curr==8){curr=1;}
   if(curr<=7){
	photo1=document.getElementById("next");
	photo1.setAttribute("src","images/"+curr+".jpg");
        document.getElementById("pushme").style.margin="0px 0px 0px -400px";
        document.getElementById("pushme2").style.margin="-400px 0px 0px 0px";
        
        
        //pushme.setAttribute("id","pushme4");
        
        curr++;
}}
function insertimage()
{
    
 if(curr==8){curr=1;}
 if(curr<=7)
 {
	//photo1=document.getElementById("next");
	//photo1.setAttribute("src",curr+".jpg");
	//photo1.setAttribute("id","replaceme");
        //if(pushme4.getAttribute("id")=="pushme")
        
        document.getElementById("pushme2").style.margin="-400px 0px 0px -400px";
        document.getElementById("pushme").style.margin="0px 0px 0px 0px";
        useme.setAttribute("src","images"+curr+1+".jpg");
        //pushme.setAttribute("id","pushme4");
        
        }	
}
setInterval(insertimage,6000);
setInterval(changesourse,12000);