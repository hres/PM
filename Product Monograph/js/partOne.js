$(document).ready(function () {
    $("#linkOne").attr("disabled", "disabled");

    $("#brandNameHidden").attr("name", "brandNameHidden");
    var brandName = $.trim($("#brandNameHidden").val());
    if (brandName.length > 0) {
        $("#btnSaveDraft").removeAttribute("disabled", "disabled");
    }
    else {
        $("#btnSaveDraft").attr("disabled", "disabled");
    }


    AddRouteOfAdministrationDefaultRow();
    setup();
});

function AddRouteOfAdministrationDefaultRow() {
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('route').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic');
        });
    });

     $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('dosageform').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic');
        });
     });

     $.get('ControlledList.xml', function (xmlcontolledlist) {
         $(xmlcontolledlist).find('warning').each(function () {
             var $option = $(this).text();
             if ($option.toLowerCase() == 'special populations') {
                 $('<option disabled="disabled">' + $option + '</option>').appendTo('#dlHeadings')
             } 
             else if ($option.indexOf('xxx') >= 0) {
                 $option = $option.replace("xxx", "&nbsp;&nbsp;&nbsp;&nbsp;");
                 $('<option>' + $option + '</option>').appendTo('#dlHeadings')
             }
             else {
                 $('<option>' + $option + '</option>').appendTo('#dlHeadings')
             }            
         });
     });
     $.get('ControlledList.xml', function (xmlcontolledlist) {
         $(xmlcontolledlist).find('interactions').each(function () {
             var $option = $(this).text();
             $('<option>' + $option + '</option>').appendTo('#dlDrugHeadings')
         });
     });
     $.get('ControlledList.xml', function (xmlcontolledlist) {
         $(xmlcontolledlist).find('kinetics').each(function () {
             var $option = $(this).text();
             $('<option>' + $option + '</option>').appendTo('#dlActionHeadings')
         });
     });
     
}


var selectedschedulingsymbol;
var newRowCount = 0;
function AddRouteOfAdminTextBox(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var colCount = table.rows[1].cells.length;
    var selectCount = 0;
    try {
        newRowCount = newRowCount + 1;
        if (newRowCount < 11) {
            for (var i = 0; i < colCount; i++) {
                var newcell = row.insertCell(i);
                if (i == 1) {
                    var newRouteOfAdminDynamicID = "tbRouteOfAdminDynamic" + newRowCount;
                    var newRouteOfAdminDynamicID_query = "#tbRouteOfAdminDynamic" + newRowCount;
                    newcell.innerHTML = "<select id='" + newRouteOfAdminDynamicID + "' name='tbRouteOfAdminDynamic' class='form-control font-small input-sm'></select>";
                    $.get('ControlledList.xml', function (xmlcontolledlist) {
                        $(xmlcontolledlist).find('route').each(function () {
                            var $option = $(this).text();
                            $('<option>' + $option + '</option>').appendTo(newRouteOfAdminDynamicID_query);
                        });
                    });
                }
                else if (i == 2) {
                    var newDosageID = "tbDosageFormDynamic" + newRowCount;
                    var newDosageID_query = "#tbDosageFormDynamic" + newRowCount;
                    newcell.innerHTML = "<select id='" + newDosageID + "' name='tbDosageFormDynamic' class='form-control font-small input-sm'></select>";
                    $.get('ControlledList.xml', function (xmlcontolledlist) {
                        $(xmlcontolledlist).find('dosageform').each(function () {
                            var $option = $(this).text();
                            $('<option>' + $option + '</option>').appendTo(newDosageID_query);
                        });
                    });
                }
                else if (i == 3) {
                    var newStrengthDynamicID = "tbStrengthDynamic" + newRowCount;
                    var numStrengthValueHTML = "<textarea  id='" + newStrengthDynamicID + "' name='tbStrengthDynamic'></textarea>";
                    newcell.innerHTML = numStrengthValueHTML;
                }
                else if (i == 4) {
                    var newClinicallyRelevantID = "tbClinicallyRelevant" + newRowCount;
                    var numStrengthValueHTML = "<textarea  id='" + newClinicallyRelevantID + "' name='tbClinicallyRelevant'></textarea>";
                    newcell.innerHTML = numStrengthValueHTML;
                }
                else {
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                    newcell.type = table.rows[1].cells[i].nodeType;
                    switch (newcell.childNodes[0].type) {
                        case "checkbox":
                            newcell.childNodes[0].checked = false;
                            break;
                        case "select-one":
                            newcell.childNodes[0].selectedIndex = 0;
                            break;
                        case "button":
                            newcell.childNodes[0].clicked = false;
                            break;
                        case "textarea":
                            newcell.childNodes[0].value = "";
                            newcell.childNodes[0].id = newcell.childNodes[0].id + newRowCount;  //BrandName and ProperName textbox
                            break;
                    }
                }
            }
        }
        else {
            alert("You reach Max row number 20, thanks!");
        }

    } catch (e) {
        alert(e);
    }
    setup();
}
function deleteRowBtnRow(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("dataTable1").rows[i];
    if (i <= 1) {
        alert("Cannot delete all the rows.");
    }
    else
        document.getElementById("dataTable1").deleteRow(i);   
}

var contraindicationsCounter = 0;
function AddContraindications() {
    contraindicationsCounter = contraindicationsCounter + 1;
    var div = document.createElement('div');
    var identity = document.createAttribute("id");
    identity.value = "Contraindications" + contraindicationsCounter;
    div.setAttributeNode(identity);

    var tbContraindications = "tbContraindications" + contraindicationsCounter.toString();
    var returnString = "";
    returnString = "<div class='form-group row'>" +
                        "<label for='" + tbContraindications + "' class='col-sm-3 control-label'></label>" +
                        "<div class='col-sm-7'>" +
                            "<textarea id='" + tbContraindications + "' name='tbContraindications' class='textarea form-control'></textarea>" +
                         "</div>" +
                         "<div class='col-sm-2 text-right'>" +
                            '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveContraindications(' + contraindicationsCounter + ')" id="btnRemoveContraindications(' + contraindicationsCounter + ')" />' +
                        "</div>" +
                "</div>";
    div.innerHTML = returnString;
    document.getElementById("divExtraContraindications").appendChild(div);
    setup();
}
function RemoveContraindications(i) {
    var rowid = "#Contraindications" + i;
    $(rowid).remove();
}

//var seriousCounter = 0;
//function AddSeriousWarnings() {
//    seriousCounter = seriousCounter + 1;
//    var div = document.createElement('div');
//    var identity = document.createAttribute("id");
//    identity.value = "SeriousWarnings" + seriousCounter;
//    div.setAttributeNode(identity);
//    var tbSeriousWarnings = "tbSeriousWarnings" + seriousCounter.toString();
//    var returnString = "";
//    returnString = "<div class='form-group row'>" +
//                        "<label for='" + tbSeriousWarnings + "' class='col-sm-3 control-label'></label>" +
//                        "<div class='col-sm-7'>" +
//                            "<textarea id='" + tbSeriousWarnings + "' name='tbSeriousWarnings' class='textarea form-control'></textarea>" +
//                         "</div>" +
//                         "<div class='col-sm-2 text-right'>" +
//                            '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveSeriousWarnings(' + seriousCounter + ')" id="btnRemoveSeriousWarnings(' + seriousCounter + ')" />' +
//                        "</div>" +
//                "</div>";
//    div.innerHTML = returnString;
//    document.getElementById("divExtraSeriousWarnings").appendChild(div);
//    setup();
//}
//function RemoveSeriousWarnings(i) {
//    var rowid = "#SeriousWarnings" + i;
//    $(rowid).remove();
//}

var headingCounter = 0;
function AddHeadings() {
    headingCounter = headingCounter + 1;
    var div = document.createElement('div');
    var identity = document.createAttribute("id");
    identity.value = "Headings" + headingCounter;
    div.setAttributeNode(identity);
    var dlHeadings = "dlHeadings" + headingCounter.toString();
    var tbHeadings = "tbHeadings" + headingCounter.toString();
    var returnString = "";
    returnString = "<div class='form-group row'>" +
                       "<label for='" + tbHeadings + "' class='col-sm-3 control-label'></label>" +
                       "<div class='col-sm-7'>" +
                           '<select id="'+ dlHeadings + '" name="dlHeadings" class="form-control font-small input-sm"></select>' +
                           "<textarea id='" + tbHeadings + "' name='tbHeadings' class='textarea form-control'></textarea>" +
                        "</div>" +
                        "<div class='col-sm-2 text-right'>" +
                           '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveHeadings(' + headingCounter + ')" id="btnRemoveHeadings(' + headingCounter + ')" />' +
                       "</div>" +
               "</div>";  
    div.innerHTML = returnString;
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('warning').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#dlHeadings' + headingCounter.toString())
        });
    });
    document.getElementById("divExtratbHeadings").appendChild(div);
    setup();
}

function RemoveHeadings(i) {
    var rowid = "#Headings" + i;
    $(rowid).remove();
}

var dosingcounter = 0;
function AddDosageConsiderations() {
    dosingcounter = dosingcounter + 1;
    var div = document.createElement('div');
    var identity = document.createAttribute("id");
    identity.value = "DosageConsiderations" + dosingcounter;
    div.setAttributeNode(identity);
    var tbDosageConsiderations = "tbDosageConsiderations" + dosingcounter.toString();
    var returnString = "";
    returnString = "<div class='form-group row'>" +
                        "<label for='" + tbDosageConsiderations + "' class='col-sm-3 control-label'></label>" +
                        "<div class='col-sm-7'>" +
                            "<textarea id='" + tbDosageConsiderations + "' name='tbDosageConsiderations' class='textarea form-control'></textarea>" +
                         "</div>" +
                         "<div class='col-sm-2 text-right'>" +
                            '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveDosageConsiderations(' + dosingcounter + ')" id="btnRemoveDosageConsiderations(' + dosingcounter + ')" />' +
                        "</div>" +
                "</div>";
    div.innerHTML = returnString;
    document.getElementById("divExtraDosageConsiderations").appendChild(div);
    setup();
}
function RemoveDosageConsiderations(i) {
    var rowid = "#DosageConsiderations" + i;
    $(rowid).remove();
}

var newRowCnt = 0;
function AddParenteralProducts(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var colCount = table.rows[1].cells.length;
    var selectCount = 0;
    try {
        newRowCnt = newRowCnt + 1;
        if (newRowCnt < 11) {
            for (var i = 0; i < colCount; i++) {
                var newcell = row.insertCell(i);
                if (i == 1) {
                    var newVialID = "tbVial" + newRowCnt;
                    var numVialHTML = "<textarea  id='" + newVialID + "' name='tbVial'></textarea>";
                    newcell.innerHTML = numVialHTML;
                }
                else if (i == 2) {
                    var newVolumeID = "tbVolume" + newRowCnt;
                    var numVolumeHTML = "<textarea  id='" + newVolumeID + "' name='tbVolume'></textarea>";
                    newcell.innerHTML = numVolumeHTML;
                }
                else if (i == 3) {
                    var newApproximateID = "tbApproximate" + newRowCnt;
                    var numApproximateValueHTML = "<textarea  id='" + newApproximateID + "' name='tbApproximate'></textarea>";
                    newcell.innerHTML = numApproximateValueHTML;
                }
                else if (i == 4) {
                    var newNominalID = "tbNominal" + newRowCnt;
                    var numNominalHTML = "<textarea  id='" + newNominalID + "' name='tbNominal'></textarea>";
                    newcell.innerHTML = numNominalHTML;
                }
                else {
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                    newcell.type = table.rows[1].cells[i].nodeType;
                    switch (newcell.childNodes[0].type) {               
                        case "button":
                            newcell.childNodes[0].clicked = false;
                            break;
                    }
                }
            }
        }
        else {
            alert("You reach Max row number 20, thanks!");
        }

    } catch (e) {
        alert(e);
    }
    setup();
}
function deleteParenteralProduct(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("dataTable2").rows[i];
    if (i <= 1) {
        alert("Cannot delete all the rows.");
    }
    else
        document.getElementById("dataTable2").deleteRow(i);
}


var headingDrugCounter = 0;
function AddDrugHeadings() {
    headingDrugCounter = headingDrugCounter + 1;
    var div = document.createElement('div');
    var identity = document.createAttribute("id");
    identity.value = "DrugHeadings" + headingDrugCounter;
    div.setAttributeNode(identity);
    var dlDrugHeadings = "dlDrugHeadings" + headingDrugCounter.toString();
    var tbDrugHeadings = "tbDrugHeadings" + headingDrugCounter.toString();
    var returnString = "";
    returnString = "<div class='form-group row'>" +
                       "<label for='" + tbDrugHeadings + "' class='col-sm-3 control-label'></label>" +
                       "<div class='col-sm-7'>" +
                           '<select id="' + dlDrugHeadings + '" name="dlDrugHeadings" class="form-control font-small input-sm"></select>' +
                           "<textarea id='" + tbDrugHeadings + "' name='tbDrugHeadings' class='textarea form-control'></textarea>" +
                        "</div>" +
                        "<div class='col-sm-2 text-right'>" +
                           '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveDrugHeadings(' + headingDrugCounter + ')" id="btnRemoveDrugHeadings(' + headingDrugCounter + ')" />' +
                       "</div>" +
               "</div>";
    div.innerHTML = returnString;
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('interactions').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#dlDrugHeadings' + headingDrugCounter.toString())
        });
    });
    document.getElementById("divExtratbDrugHeadings").appendChild(div);
    setup();
}

function RemoveDrugHeadings(i) {
    var rowid = "#DrugHeadings" + i;
    $(rowid).remove();
}

var headingActionCounter = 0;
function AddActionHeadings() {
    headingActionCounter = headingActionCounter + 1;
    var div = document.createElement('div');
    var identity = document.createAttribute("id");
    identity.value = "ActionHeadings" + headingActionCounter;
    div.setAttributeNode(identity);
    var dlActionHeadings = "dlActionHeadings" + headingActionCounter.toString();
    var tbActionHeadings = "tbActionHeadings" + headingActionCounter.toString();
    var returnString = "";
    returnString = "<div class='form-group row'>" +
                       "<label for='" + tbActionHeadings + "' class='col-sm-3 control-label'></label>" +
                       "<div class='col-sm-7'>" +
                           '<select id="' + dlActionHeadings + '" name="dlActionHeadings" class="form-control font-small input-sm"></select>' +
                           "<textarea id='" + tbActionHeadings + "' name='tbActionHeadings' class='textarea form-control'></textarea>" +
                        "</div>" +
                        "<div class='col-sm-2 text-right'>" +
                           '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveActionHeadings(' + headingActionCounter + ')" id="btnRemoveActionHeadings(' + headingActionCounter + ')" />' +
                       "</div>" +
               "</div>";
    div.innerHTML = returnString;
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('kinetics').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#dlActionHeadings' + headingActionCounter.toString())
        });
    });
    document.getElementById("divExtratbActionHeadings").appendChild(div);
    setup();
}

function RemoveActionHeadings(i) {
    var rowid = "#ActionHeadings" + i;
    $(rowid).remove();
}

var newPharRowCnt = 0;
function AddPharmacokineticsTable(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var colCount = table.rows[1].cells.length;
    var selectCount = 0;
    try {
        newPharRowCnt = newPharRowCnt + 1;
        if (newPharRowCnt < 11) {
            for (var i = 0; i < colCount; i++) {
                var newcell = row.insertCell(i);
                if (i == 1) {
                    var newCmax = "tbCmax" + newPharRowCnt;
                    var numCmaxHTML = "<textarea  id='" + newCmax + "' name='tbCmax'></textarea>";
                    newcell.innerHTML = numCmaxHTML;
                }
                else if (i == 2) {
                    var newT12h = "tbT12h" + newPharRowCnt;
                    var numT12hHTML = "<textarea  id='" + newT12h + "' name='tbT12h'></textarea>";
                    newcell.innerHTML = numT12hHTML;
                }
                else if (i == 3) {
                    var newAuc = "tbAuc" + newPharRowCnt;
                    var numAucHTML = "<textarea  id='" + newAuc + "' name='tbAuc'></textarea>";
                    newcell.innerHTML = numAucHTML;
                }
                else if (i == 4) {
                    var newClearance = "tbClearance" + newPharRowCnt;
                    var numClearanceHTML = "<textarea  id='" + newClearance + "' name='tbClearance'></textarea>";
                    newcell.innerHTML = numClearanceHTML;
                }
                else if (i == 5) {
                    var newVolumeDis = "tbVolumeDis" + newPharRowCnt;
                    var numVolumeDisHTML = "<textarea  id='" + newVolumeDis + "' name='tbVolumeDis'></textarea>";
                    newcell.innerHTML = numVolumeDisHTML;
                }
                else {
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                    newcell.type = table.rows[1].cells[i].nodeType;
                    switch (newcell.childNodes[0].type) {
                        case "button":
                            newcell.childNodes[0].clicked = false;
                            break;
                    }
                }
            }
        }
        else {
            alert("You reach Max row number 20, thanks!");
        }

    } catch (e) {
        alert(e);
    }
    setup();
}
function deletePharmacokineticsTable(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("pharmacokineticsTable").rows[i];
    if (i <= 1) {
        alert("Cannot delete all the rows.");
    }
    else
        document.getElementById("pharmacokineticsTable").deleteRow(i);
}

var newAdverseRowCnt = 0;
function AddAdverseReactionsTable(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var colCount = table.rows[1].cells.length;
    var selectCount = 0;
    try {
        newAdverseRowCnt = newAdverseRowCnt + 1;
        if (newAdverseRowCnt < 11) {
            for (var i = 0; i < colCount; i++) {
                var newcell = row.insertCell(i);
                if (i == 1) {
                    var newClinicalTrial = "tbClinicalTrial" + newAdverseRowCnt;
                    var numClinicalTrialHTML = "<input type='text'  id='" + newClinicalTrial + "' name='tbClinicalTrial' class='form-control input-sm' />";
                    newcell.innerHTML = numClinicalTrialHTML;
                }
                else if (i == 2) {
                    var newDrugName = "tbDrugName" + newAdverseRowCnt;
                    var numDrugNameHTML = "<textarea  id='" + newDrugName + "' name='tbDrugName'></textarea>";
                    newcell.innerHTML = numDrugNameHTML;
                }
                else if (i == 3) {
                    var newPlacebo = "tbPlacebo" + newAdverseRowCnt;
                    var numPlaceboHTML = "<textarea  id='" + newPlacebo + "' name='tbPlacebo'></textarea>";
                    newcell.innerHTML = numPlaceboHTML;
                }
                else {
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                    newcell.type = table.rows[1].cells[i].nodeType;
                    switch (newcell.childNodes[0].type) {
                        case "button":
                            newcell.childNodes[0].clicked = false;
                            break;
                    }
                }
            }
        }
        else {
            alert("You reach Max row number 10, thanks!");
        }

    } catch (e) {
        alert(e);
    }
    setup();
}
function DeleteAdverseReactionsTable(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("adverseReactionsTable").rows[i];
    if (i <= 1) {
        alert("Cannot delete all the rows.");
    }
    else
        document.getElementById("adverseReactionsTable").deleteRow(i);
}

var newDrugRowCnt = 0;
function AddDruginteractionTable(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var colCount = table.rows[1].cells.length;
    var selectCount = 0;
    try {
        newDrugRowCnt = newDrugRowCnt + 1;
        if (newDrugRowCnt < 11) {
            for (var i = 0; i < colCount; i++) {
                var newcell = row.insertCell(i);
                if (i == 1) {
                    var newProperName = "tbProperName" + newDrugRowCnt;
                    var numProperNameHTML = "<textarea  id='" + newProperName + "' name='tbProperName'></textarea>";
                    newcell.innerHTML = numProperNameHTML;
                }
                else if (i == 2) {
                    var newRef = "tbRef" + newDrugRowCnt;
                    var numRefHTML = "<textarea  id='" + newRef + "' name='tbRef'></textarea>";
                    newcell.innerHTML = numRefHTML;
                }
                else if (i == 3) {
                    var newEffect = "tbEffect" + newDrugRowCnt;
                    var numEffectHTML = "<textarea  id='" + newEffect + "' name='tbEffect'></textarea>";
                    newcell.innerHTML = numEffectHTML;
                }
                else if (i == 4) {
                    var newClinical = "tbClinical" + newDrugRowCnt;
                    var numClinicalHTML = "<textarea  id='" + newClinical + "' name='tbClinical'></textarea>";
                    newcell.innerHTML = numClinicalHTML;
                }
                else {
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                    newcell.type = table.rows[1].cells[i].nodeType;
                    switch (newcell.childNodes[0].type) {
                        case "button":
                            newcell.childNodes[0].clicked = false;
                            break;
                    }
                }
            }
        }
        else {
            alert("You reach Max row number 20, thanks!");
        }

    } catch (e) {
        alert(e);
    }
    setup();
}
function deleteDruginteractionTable(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("druginteractionTable").rows[i];
    if (i <= 1) {
        alert("Cannot delete all the rows.");
    }
    else
        document.getElementById("druginteractionTable").deleteRow(i);
}