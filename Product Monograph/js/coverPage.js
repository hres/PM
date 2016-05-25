//Setup default values on first row of Dosage Form --- created by Ching Chang on Feb 8, 2016
var selectedschedulingsymbol;
$(document).ready(function () {
    $("#linkCover").attr("disabled", "disabled");
    var now = new Date();
    var day = (now.getDate() < 10 ? '0' : '') + now.getDate();
    var month = ((now.getMonth() + 1) < 10 ? '0' : '') + (now.getMonth() + 1);
    var year = now.getFullYear();
    var todayDate = year + "-" + month + "-" + day;
    $("#tbDatePrep").attr("name", "tbDatePrep");
    $("#tbDatePrep").attr("max", todayDate);
    $("#tbDateRev").attr("name", "tbDateRev");
    $("#tbDateRev").attr("max", todayDate);

    $("#tbSchedulingSymbol").change(function () {
        $('#imgSymbol').attr("src", "images/x.png");
    });

    //populate dropdown list
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('schedule').each(function () {
            var $option = $(this).text();
            var $val = $(this).attr("value");
            $('<option value="' + $val + '">' + $option + '</option>').appendTo('#tbSchedulingSymbol');
        });
    }).done(function () {
        //if LoadFromXML assigned value to selectedschedulingsymbol
        $('#tbSchedulingSymbol option').each(function () { if ($(this).html() == selectedschedulingsymbol) { $(this).attr('selected', 'selected'); return; } });
    });

    var existXmlFile = $.trim($("#existXmlFile").val());
    var brandName = $.trim($("#brandNameHidden").val());
    if (existXmlFile === 'False' || brandName.length == 0 )
    {
        AddBrandProperDosageDefaultRow();
    }

});


var countTBL = 0
function AddBrandProperDosageDefaultRow() {
    //first row of table - start
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('dosageform').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#tbDosage');
        });
    });
    //get strength Unit
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('unit').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#tbStrengthUnit');
        });
    });
    //get strength per Dosage Unit
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('unit').each(function () {
            var $option = $(this).text();
            $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit');
        });
    });

}




function ApplySchedulingSymbol() {
    var selectedsymbol = $('#tbSchedulingSymbol').val();
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find(selectedsymbol).each(function () {
            $('#imgSymbol').attr("src", "scheduling symbol\\" + $(this).text());
            $("#tbxmlimgnameSymbol").val($('#tbSchedulingSymbol option:selected').text());
            $("#tbxmlimgfilenameSymbol").val($(this).text());
        });
    });
}
var newRowCount = 0;
function addRow(tableID) {
    $("#tbBtnRemove").removeAttr("disabled");
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
                if (i == 3) {
                    var newDosageID = "tbDosage" + newRowCount;
                    var newDosageID_query = "#tbDosage" + newRowCount;
                    newcell.innerHTML = "<select id='" + newDosageID + "' name='tbDosage' class='form-control font-small input-sm'></select>";
                    $.get('ControlledList.xml', function (xmlcontolledlist) {
                        $(xmlcontolledlist).find('dosageform').each(function () {
                            var $option = $(this).text();
                            $('<option>' + $option + '</option>').appendTo(newDosageID_query);
                        });
                    });
                }
                else if (i == 4) {                    
                    var newStrengthValueID = "tbStrengthValue" + newRowCount;                  
                    var newStrengthValueID_query = "#tbStrengthValue" + newRowCount;
                    var newStrengthUnitID = "tbStrengthUnit" + newRowCount;
                    var newStrengthUnitID_query = "#tbStrengthUnit" + newRowCount;
                    var numStrengthValueHTML = "<input type='number' id='" + newStrengthValueID + "' name='tbStrengthValue' value='0' min='0' max='1000' class='form-control font-small input-sm'/>";
                    var listStrengthUnitHTML = "<div><select id='" + newStrengthUnitID + "' name='tbStrengthUnit' class='form-control font-small input-sm'></select></div>";
                    newcell.innerHTML = numStrengthValueHTML + listStrengthUnitHTML;
                    $.get('ControlledList.xml', function (xmlcontolledlist) {
                        $(xmlcontolledlist).find('unit').each(function () {
                            var $option = $(this).text();
                            $('<option>' + $option + '</option>').appendTo(newStrengthUnitID_query);
                        });
                    });
                }
                else if (i == 5) {
                    var newStrengthperDosageValueID = "tbStrengthperDosageValue" + newRowCount;
                    var newStrengthperDosageValueID_query = "#tbStrengthperDosageValue" + newRowCount;
                    var newStrengthperDosageUnitID = "tbStrengthperDosageUnit" + newRowCount;
                    var newStrengthperDosageUnitID_query = "#tbStrengthperDosageUnit" + newRowCount;

                    var numStrengthperDosageValueHTML = "<input type='number' id='" + newStrengthperDosageValueID + "' name='tbStrengthperDosageValue' value='0' min='0' max='1000' class='form-control font-small input-sm'/>";
                    var listStrengthperDosageUnitHTML = "<div><select id='" + newStrengthperDosageUnitID + "' name='tbStrengthperDosageUnit' class='form-control font-small input-sm'></select></div>";
                    newcell.innerHTML = numStrengthperDosageValueHTML + listStrengthperDosageUnitHTML;

                    $.get('ControlledList.xml', function (xmlcontolledlist) {
                        $(xmlcontolledlist).find('unit').each(function () {
                            var $option = $(this).text();
                            $('<option>' + $option + '</option>').appendTo(newStrengthperDosageUnitID_query);
                        });
                    });
                }
                else
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;

                newcell.type = table.rows[1].cells[i].nodeType;
                switch (newcell.childNodes[0].type) {
                    case "text":
                        newcell.childNodes[0].value = "";
                        newcell.childNodes[0].id = newcell.childNodes[0].id + newRowCount;  //BrandName and ProperName textbox
                        break;
                    case "checkbox":
                        newcell.childNodes[0].checked = false;
                        break;
                    case "select-one":
                        newcell.childNodes[0].selectedIndex = 0;
                        break;
                    case "button":
                        newcell.childNodes[0].clicked = false;
                        newcell.childNodes[0].id = newcell.childNodes[0].id + newRowCount;
                        break;
                }
            }
        }
        else {
            alert("You reach Max row number 20, thanks!");
        }

    } catch (e) {
        alert(e);
    }
}
function deleteRowBtnRow(r) {
    var i = r.parentNode.parentNode.rowIndex;
    var row = document.getElementById("dataTable").rows[i];
    if (i <= 1) {
        $("#tbBtnRemove").attr("disabled", "disabled");
    }
    else
        document.getElementById("dataTable").deleteRow(i);

}
