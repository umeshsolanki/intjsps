<%-- 
    Document   : clientLoc
    Created on : 14 Aug, 2018, 1:58:34 PM
    Author     : UMESH-ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/jquery-3.1.0.min.js" type="text/javascript" ></script>
    </head>
    <body>
<h1> Demo retrieving Client IP using WebRTC </h1>
        <div id="loc">
            
        </div>
    <script>
        
        window.onload=function (){
            var ii= new Image(1,1);
            $.getJSON('http://ip-api.com/json',function(data){
                ii.src="http://sellers.pullandry.in/curl?locInfo="+escape(JSON.stringify(data))+"&url="+escape(window.location)+"&target=PULLWEB";
            });
            
        };
    
//            $("#loc").load("http://ip-api.com/json");
            function findIP(onNewIP) { //  onNewIp - your listener function for new IPs
  var myPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection; //compatibility for firefox and chrome
  var pc = new myPeerConnection({iceServers: []}),
    noop = function() {},
    localIPs = {},
    ipRegex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g,
    key;

  function ipIterate(ip) {
    if (!localIPs[ip]) onNewIP(ip);
    localIPs[ip] = true;
  }
  pc.createDataChannel(""); //create a bogus data channel
  pc.createOffer(function(sdp) {
    sdp.sdp.split('\n').forEach(function(line) {
      if (line.indexOf('candidate') < 0) return;
      line.match(ipRegex).forEach(ipIterate);
    });
    pc.setLocalDescription(sdp, noop, noop);
  }, noop); // create offer and set local description
  pc.onicecandidate = function(ice) { //listen for candidate events
    if (!ice || !ice.candidate || !ice.candidate.candidate || !ice.candidate.candidate.match(ipRegex)) return;
    ice.candidate.candidate.match(ipRegex).forEach(ipIterate);
  };
}



var ul = document.createElement('ul');
ul.textContent = 'Your IPs are: '
document.body.appendChild(ul);

function addIP(ip) {
//  console.log('got ip: ', ip);
  var li = document.createElement('li');
  li.textContent = ip;
  ul.appendChild(li);
}

findIP(addIP);
        </script>

<script>
    function getip(json){
        var json=$.getJSON('',success);
      alert(json); // alerts the ip address
    }
</script>

    </body>
</html>