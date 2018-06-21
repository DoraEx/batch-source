
baseUrl = "http://localhost:8082/ReimbursementApp/searchEmployeeSession";


function getSearchedEmployee(){
	let table = document.getElementById("searched");
	while(table.firstChild){
		table.removeChild(table.firstChild);
	}
    sendAjaxGet(baseUrl, displaySearchedEmployee);
}

function sendAjaxGet(url, func){
    let xhr = (new XMLHttpRequest() || new ActiveXObject("Microsoft.HTTPRequest"));
    xhr.onreadystatechange = function(){
        if(this.status == 200 && this.readyState == 4){
            func(this);
        }
    }
    xhr.open("GET", url);
    xhr.send();
}

function displaySearchedEmployee(xhr){
	let pending = JSON.parse(xhr.response);
    //console.log(pending);
     let newTable = document.getElementById("searched");
	 let headerRow = document.createElement("tr");
	    let ridHeader = document.createElement("th");
	    let moneyHeader = document.createElement("th");
	    let eidHeader = document.createElement("th");
	    let statusHeader = document.createElement("th");
	    let revIdHeader = document.createElement("th");
	    headerRow.appendChild(ridHeader);
	    headerRow.appendChild(moneyHeader);
	    headerRow.appendChild(eidHeader);
	    headerRow.appendChild(statusHeader);
	    headerRow.appendChild(revIdHeader);
	    ridHeader.innerHTML = "Reimbursement ID";
	    moneyHeader.innerHTML = "Money";
	    eidHeader.innerHTML = "Employee ID";
	    statusHeader.innerHTML = "Status";
	    revIdHeader.innerHTML = "Reviewer ID";
	    newTable.appendChild(headerRow);
	    let reimbursementList = pending.searchedEmployee
	    
	    for(var x in reimbursementList){
	    	//if(reimbursementList[x].status === "Pending"){
	    		let row = document.createElement("tr");
	    		let ridCell = document.createElement("td");
	    		let moneyCell = document.createElement("td");
	    		let eidCell = document.createElement("td");
	    		let statusCell = document.createElement("td");
	    		let revIdCell = document.createElement("td");
	    		ridCell.innerHTML = reimbursementList[x].reimbursement_id;
	    		moneyCell.innerHTML = "$"+reimbursementList[x].money;
	    		eidCell.innerHTML = reimbursementList[x].employee_id;
	    		statusCell.innerHTML = reimbursementList[x].status;
	    		//revIdCell.innerHTML = "N/A";
	    		if(reimbursementList[x].reviewer_id === 0){
	    			revIdCell.innerHTML = "N/A"
	    		}else{
	    			revIdCell.innerHTML = reimbursementList[x].reviewer_id
	    		}
	    		row.appendChild(ridCell);
	    		row.appendChild(moneyCell);
	    		row.appendChild(eidCell);
	    		row.appendChild(statusCell);
	    		row.appendChild(revIdCell);
	    		newTable.appendChild(row);
	    	//	}
	    }
}