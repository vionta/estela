
/**
* Send a delete request to 
*/
function deleteDocument(documentId, entityName) {
    xhttp  = new XMLHttpRequest();
    xhttp.open("DELETE", "/collections/"+entityName+"/" + documentId +".xml" , true);
    xhttp.send();
    location.reload();
    return false;
}
