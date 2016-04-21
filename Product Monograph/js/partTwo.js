var selectedschedulingsymbol;
$(document).ready(function () {
    $("#linkTwo").attr("disabled", "disabled");
    $("#tbPharSchedulingSymbol").change(function () {
        $('#imgSymbol').attr("src", "images/x.png");
    });

    //populate dropdown list
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find('schedule').each(function () {
            var $option = $(this).text();
            var $val = $(this).attr("value");
            $('<option value="' + $val + '">' + $option + '</option>').appendTo('#tbPharSchedulingSymbol');
        });
    }).done(function () {
        //if LoadFromXML assigned value to selectedschedulingsymbol
        $('#tbPharSchedulingSymbol option').each(function () { if ($(this).html() == selectedschedulingsymbol) { $(this).attr('selected', 'selected'); return; } });
    });
});

var drugCounter = 0;
function AddDrugSubstance() {
    drugCounter = drugCounter + 1;
    var div = document.createElement('div');
    var att = document.createAttribute("class");
    att.value = "brdr-bttm";
    div.setAttributeNode(att);
    var identity = document.createAttribute("id");
    identity.value = "DrugSubstance" + drugCounter;
    div.setAttributeNode(identity);

    var tbDrugSub = "tbDrugSub" + drugCounter.toString();
    var tbChemical = "tbChemical" + drugCounter.toString();
    var tbMolecular = "tbMolecular" + drugCounter.toString();
    var tbMass = "tbMass" + drugCounter.toString();
    var tbPhysicochemical = "tbPhysicochemical" + drugCounter.toString();
    var drugString = "";
    drugString = "<div class='form-group row'>" +
            "<label for='" + tbDrugSub + "' class='col-sm-3 control-label'>Drug substance</label>"  +                      
            "<div class='col-sm-7'>" + 
                "<input type='text' id='" + tbDrugSub + "' name='tbDrugSub' class='form-control'/>" +
            "</div>" +
            "<div class='col-sm-2 text-right'>" +
                '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDrugSubstanceTextBox(' + drugCounter + ')" id="btnRemoveDrugSubstanceTextBox(' + drugCounter + ')" />' +
             "</div>" +    
          "</div>" +
       "<div class='form-group row'>" +
            "<label for='" + tbChemical + "' class='col-sm-3 control-label'>Chemical name</label>"  +    
            "<div class='col-sm-9'>" +
                "<textarea id='" + tbChemical + "' name='tbChemical' class='textarea form-control'></textarea>" +
             "</div>" +
          "</div>" +
       "<div class='form-group row'>" +
            "<label for='" + tbMolecular + "' class='col-sm-3 control-label'>Molecular formula</label>"  +         
            "<div class='col-sm-9'>" +
                "<textarea id='" + tbMolecular + "' name='tbMolecular' class='textarea form-control'></textarea>" +
              "</div>" +
          "</div>" +
       "<div class='form-group row'>" +
            "<label for='" + tbMass + "' class='col-sm-3 control-label'>Molecular mass</label>"  +        
             "<div class='col-sm-9'>" +
                "<textarea id='" + tbMass + "' name='tbMass' class='textarea form-control'></textarea>" +
              "</div>" +
          "</div>" +
        "<div class='form-group row'>" +
             "<label for='" + tbPhysicochemical + "' class='col-sm-3 control-label'>Physicochemical properties</label>"  +        
             "<div class='col-sm-9'>" +
                "<textarea id='" + tbPhysicochemical + "' name='tbPhysicochemical' class='textarea form-control'></textarea>" +
              "</div>" +
       "</div>";
    div.innerHTML = drugString;
    document.getElementById("divExtraDrugSubstance").appendChild(div);
    setup();
}

function RemoveDrugSubstanceTextBox(i) {
    var rowid = "#DrugSubstance" + i;
    $(rowid).remove();
}

function ApplyPharSchedulingSymbol() {
    var selectedsymbol = $('#tbPharSchedulingSymbol').val();
    $.get('ControlledList.xml', function (xmlcontolledlist) {
        $(xmlcontolledlist).find(selectedsymbol).each(function () {
            $('#imgSymbol').attr("src", "scheduling symbol\\" + $(this).text());
            $("#tbPharxmlimgnameSymbol").val($('#tbPharSchedulingSymbol option:selected').text());
            $("#tbPharxmlimgfilenameSymbol").val($(this).text());
        });
    });
}

function RemoveAnalyteNameTextBox(i) {
    var rowid = "#AnalyteName" + i;
    $(rowid).remove();
}

var AnalyteNameCounter = 0;

function AddAnalyteNameTextBox() {

    AnalyteNameCounter = AnalyteNameCounter + 1;
    counter = AnalyteNameCounter;

    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "roadynarow";
    identity.value = "AnalyteName" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAnalyteNameDynamicTextBox(counter);
    document.getElementById("dvExtraAnalyteName").appendChild(div);

    setup();

}

function GetAnalyteNameDynamicTextBox(id) {
    var AUCTTest = "tbAUCTTest" + id.toString();
    var AUCTRefe = "tbAUCTReference" + id.toString();
    var AUCTPerc = "tbAUCTPercentRatio" + id.toString();
    var AUCTConf = "tbAUCTConfidenceInterval" + id.toString();

    var AUCITest = "tbAUCITest" + id.toString();
    var AUCIRefe = "tbAUCIReference" + id.toString();
    var AUCIPerc = "tbAUCIPercentRatio" + id.toString();
    var AUCIConf = "tbAUCIConfidenceInterval" + id.toString();

    var CMAXTest = "tbCMAXTest" + id.toString();
    var CMAXRefe = "tbCMAXReference" + id.toString();
    var CMAXPerc = "tbCMAXPercentRatio" + id.toString();
    var CMAXConf = "tbCMAXConfidenceInterval" + id.toString();

    var TMAXTest = "tbTMAXTest" + id.toString();
    var TMAXRefe = "tbTMAXReference" + id.toString();
    var TMAXPerc = "tbTMAXPercentRatio" + id.toString();
    var TMAXConf = "tbTMAXConfidenceInterval" + id.toString();

    var THalfTest = "tbTHalfTest" + id.toString();
    var THalfRefe = "tbTHalfReference" + id.toString();
    var THalfPerc = "tbTHalfPercentRatio" + id.toString();
    var THalfConf = "tbTHalfConfidenceInterval" + id.toString();

    var AnalyteMultiplicand = "tbAnalyteMultiplicand" + id.toString();
    var AnalyteMultiplier = "tbAnalyteMultiplier" + id.toString();


    return "<section class='panel panel-default'>" +
             "<header class='panel-heading'>" +               
                "<div class='row'> " +   
                     "<div class='text-center col-sm-10'>" +                      
                         "<label for='"+AnalyteMultiplicand+"' class='control-label'>Analyte name</label>" +  
                         "<input type='number' id='" + AnalyteMultiplicand + "' name='" + AnalyteMultiplier + "'/> &nbsp;X" +     
                         "<input type='number' id='" + AnalyteMultiplier + "' name='" + AnalyteMultiplier + "'/>&nbsp;mg)" +   
                        "</div>" +
                        "<div class='text-right  col-sm-2 margin-top-0'>" +  
                        '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveAnalyteNameTextBox(' + id + ')" id="btnRemoveAnalyteNameTextBox(' + id + ')" />' +
                    "</div>" +
                "</div>" +
                "<div class='panel-body'>" +
                     "<div class='row'>" +
                           "<div class='col-xs-2 text-right'>" +
                                "Parameter" +
                            "</div>" +
                            "<div class='col-xs-2 brdr-lft'>" +
                                "Test*" +
                            "</div>" +
                            "<div class='col-xs-2 brdr-lft'>" +
                                "Reference" +
                            "</div>" +
                            "<div class='col-xs-3 brdr-lft'>" +
                                "% Ratio of Geometric Means" +
                            "</div>" +
                            "<div class='col-xs-3 brdr-lft'>" +
                                "Confidence Interval #" +
                            "</div>   " +
                     "</div>   " +

                    "<div class='row'>" +
                            "<div class='col-xs-2 brdr-tp text-right'>" +
                                    "AUCT +-(units)" +
                            "</div>" +
                            "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                 "<textarea id='" + AUCTTest + "' name='" + AUCTTest + "'></textarea>" +
                            "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCTRefe + "' name='" + AUCTRefe + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCTPerc + "' name='" + AUCTPerc + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCTConf + "' name='" + AUCTConf + "'></textarea>" +
                           "</div>" +
                    "</div>" +
                    "<div class='row'>" +
                           "<div class='col-xs-2 brdr-tp text-right'>" +
                                "AUCI (units)" +
                            "</div>" +
                            "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCITest + "' name='" + AUCITest + "'></textarea>" +
                            "</div>" +
                            "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCIRefe + "' name='" + AUCIRefe + "'></textarea>" +
                            "</div>" +
                            "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCIPerc + "' name='" + AUCIPerc + "'></textarea>" +
                            "</div>" +
                            "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + AUCIConf + "' name='" + AUCIConf + "'></textarea>" +
                            "</div>" +
                   "</div>" +

                   "<div class='row'>" +
                           "<div class='col-xs-2 brdr-tp text-right'>" +
                                 "CMAX (units)" +
                           "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                 "<textarea id='" + CMAXTest + "' name='" + CMAXTest + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + CMAXRefe + "' name='" + CMAXRefe + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + CMAXPerc + "' name='" + CMAXPerc + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + CMAXConf + "' name='" + CMAXConf + "'></textarea>" +
                           "</div>" +
                    "</div>" +

                    "<div class='row'>" +
                           "<div class='col-xs-2 brdr-tp text-right'>" +
                                "TMAX (h)" +
                           "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + TMAXTest + "' name='" + TMAXTest + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft'>" +
                                "<textarea id='" + TMAXRefe + "' name='" + TMAXRefe + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + TMAXPerc + "' name='" + TMAXPerc + "'></textarea>" +
                           "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft'>" +
                                "<textarea id='" + TMAXConf + "' name='" + TMAXConf + "'></textarea>" +
                            "</div>" +
                    "</div>" +

                   "<div class='row'>" +
                           "<div class='col-xs-2 brdr-tp text-right'>" +
                                "T1/2 (h)" +
                           "</div>" +
                            "<div class='col-xs-2 brdr-tp brdr-lft brdr-bttm'>" +
                                 "<textarea id='" + THalfTest + "' name='" + THalfTest + "'></textarea>" +
                            "</div>" +
                           "<div class='col-xs-2 brdr-tp brdr-lft brdr-bttm'>" +
                                 "<textarea id='" + THalfRefe + "' name='" + THalfRefe + "'></textarea>" +
                            "</div>" +
                           "<div class='col-xs-3 brdr-tp brdr-lft brdr-bttm'>" +
                                 "<textarea id='" + THalfPerc + "' name='" + THalfPerc + "'></textarea>" +
                            "</div>" +
                            "<div class='col-xs-3 brdr-tp brdr-lft brdr-bttm'>" +
                                 "<textarea id='" + THalfConf + "' name='" + THalfConf + "'></textarea>" +
                            "</div>" +
                  "</div>" +
               "</div>";

}