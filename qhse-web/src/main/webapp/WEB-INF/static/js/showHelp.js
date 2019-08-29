function showHelp(event,questionHelp, aImg) {
  	// aImg.style.cursor='help';
  	
  	var myDiv = document.getElementById("help");
  	//clear previous help element
      	
  	if(myDiv.hasChildNodes()){
  		toRemove = myDiv.childNodes[0];
  		myDiv.removeChild(toRemove);  		
  	}
  		
	var i = document.createTextNode(questionHelp);

	var el = this.parent;
	
	var cursor = getPosition(event); 			
	
	myDiv.style.left = cursor.x + "px";
	myDiv.style.top = cursor.y + "px";
		 	
	myDiv.appendChild( i );
	Effect.Appear('help');
  }
  
  	function hideHelp() {
  		Effect.Fade('help');
  	}

  	function getPosition(e) {
		    
	    if (!e) var e = window.event;
	    var cursor = {x:0, y:0};
	    if (e.pageX || e.pageY) 	{
	    	cursor.x = e.clientX + document.body.scrollLeft
			+ document.documentElement.scrollLeft;
		cursor.y = e.clientY + document.body.scrollTop
			+ document.documentElement.scrollTop;
		}
		else if (e.clientX || e.clientY) 	{
			cursor.x = e.clientX + document.body.scrollLeft
				+ document.documentElement.scrollLeft;
			cursor.y = e.clientY + document.body.scrollTop
				+ document.documentElement.scrollTop;
		}
	    return cursor;
	}  
  	