

function showSection(nodeName) {
    var node= document.getElementById(nodeName);
    node.querySelectorAll('img.open-icon').forEach(n => n.style.visibility = 'hidden' );
    node.querySelectorAll('img.close-icon').forEach(n => n.style.visibility = 'visible' );
    node.querySelectorAll('div.internal-space').forEach(n => n.style.visibility = 'visible');

    /*
    var node= document.getElementById(nodeName);
    node.querySelectorAll('div > p ').forEach(n => n.style.display = 'none');
    node.querySelectorAll('div > ul ').forEach(n => n.style.display = 'none');

    node.querySelectorAll('div  > h3 >.mas ').forEach(n => n.style.display = 'inline');
    node.querySelectorAll('div  > h3 > .menos ').forEach(n => n.style.display = 'none');
    
    node.querySelectorAll('div  > h3 >.mas ').forEach(n => n.style.visibility = 'visible');
    node.querySelectorAll('div  > h3 > .menos ').forEach(n => n.style.visibility = 'hidden');
*/
}


/*


  		    <img src="closed-blue-icon.svg" class="close-icon" onclick="hide-section('context-section')" />
		    <img src="opened-blue-icon.svg" class="open-icon"  onclick="show-section('context-section')" />
		    */

function hideSection(nodeName) {
    var node= document.getElementById(nodeName);
    node.querySelectorAll('img.close-icon').forEach(n => n.style.visibility = 'hidden' );
    node.querySelectorAll('img.open-icon').forEach(n => n.style.visibility = 'visible' );
    node.querySelectorAll('div.internal-space').forEach(n => n.style.visibility = 'hidden');

}
