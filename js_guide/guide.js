HTMLInputElement.prototype.writeLetter = function(letter) {
	this.value = this.value + letter;  
};

function ghostwrite(id_selector, text) {
	var	element = document.getElementById(id_selector);
	
	for(var i = 0; i < text.length; i++) {
	  setTimeout(	function() { element.writeLetter(text[i]); }, 1000 );
	}	
}
