$(document).ready(function () {
    $("#linkThree").attr("disabled", "disabled");
});

var loadFile = function (fuid, imgid, txtname, txtdata) {

    //input file element
    var x = document.getElementById(fuid);
    //first item, only item
    var file = x.files[0];

    var reader = new FileReader();
    reader.onload = function () {
        $('#' + imgid).each(function () {
            $(this).attr("src", reader.result);
            $("input[id='" + txtname + "']").each(function () {
                $(this).val(file.name);
            });
            $("input[id='" + txtdata + "']").each(function () {
                $(this).val(reader.result);
            });
        });
    };
    reader.readAsDataURL(event.target.files[0]);
};


var seriousCounter = 0;
function AddSeriousWarningsPrecautions() {
    seriousCounter = seriousCounter + 1;
    var div = document.createElement('div');
    var att = document.createAttribute("class");
    att.value = "brdr-bttm";
    div.setAttributeNode(att);
    var identity = document.createAttribute("id");
    identity.value = "SeriousWarningsPrecautions" + seriousCounter;
    div.setAttributeNode(identity);
    var tbSeriousWarningsPrecautions = "tbSeriousWarningsPrecautions" + seriousCounter.toString();
    var returnString = "";    
    
    returnString = "<div class='form-group row'>" +
                           "<label for='" + tbSeriousWarningsPrecautions + "' class='col-sm-3 control-label'></label>" +
                           "<div class='col-sm-7'>" +
                               "<textarea id='" + tbSeriousWarningsPrecautions + "' name='tbSeriousWarningsPrecautions' class='textarea form-control'></textarea>" +
                            "</div>" +
                            "<div class='col-sm-2 text-right'>" +
                               '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue +'" onclick="RemoveSeriousWarningsPrecautions(' + seriousCounter + ')" id="btnRemoveSeriousWarnings(' + seriousCounter + ')" />' +
                           "</div>" +
                   "</div>";   
    div.innerHTML = returnString;
    document.getElementById("dvExtraSeriousWarningsPrecautions").appendChild(div);
    setup();
}
function RemoveSeriousWarningsPrecautions(i) {
    var rowid = "#SeriousWarningsPrecautions" + i;
    $(rowid).remove();
}


function AddCommonSymptomsTextBox() {
    CommonCounter = CommonCounter + 1;
    counter = CommonCounter;
    $("#hdCommonSymptoms").val(counter);
    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "wb-eqht row";
    identity.value = "Common" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddCommonSymptomsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraCommonSymptoms").appendChild(div);
}

function GetAddCommonSymptomsTextBoxDynamicTextBox(id) {
    var cfreq = "tbCommonFrequency" + id.toString();
    var csymp = "tbCommonSymptom" + id.toString();
    var csevere = "cbCommonSevere" + id.toString();
    var ccases = "cbCommonAllCases" + id.toString();
    var cstop = "cbCommonStoptaking" + id.toString();

    return " <div class='col-xs-2 wb-eqht brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Common frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
            "</div>  " +
            " <div class='col-xs-2 wb-eqht brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Common symptom' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
            "</div> " +
            " <div class='col-xs-2 wb-eqht brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Common severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
            "</div>" +
            " <div class='col-xs-2 wb-eqht brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Common all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
            "</div> " +
            " <div class='col-xs-2 wb-eqht brdr-lft brdr-rght brdr-bttm'>" +
                 "<input type='checkbox' title='Common stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
            "</div> " +
            " <div class='col-xs-2 wb-eqht'>" +
                '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveCommon(' + id + ')" id="btnRemoveCommon(' + id + ')" />' +
           "</div>";
}

function AddUncommonSymptomsTextBox() {

    UncommonCounter = UncommonCounter + 1;
    counter = UncommonCounter;
    $("#hdUncommonSymptoms").val(counter);
    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "wb-eqht row";
    identity.value = "Uncommon" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddUncommonSymptomsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraUncommonSymptoms").appendChild(div);
}

function GetAddUncommonSymptomsTextBoxDynamicTextBox(id) {
    var cfreq = "tbUncommonFrequency" + id.toString();
    var csymp = "tbUncommonSymptom" + id.toString();
    var csevere = "cbUncommonSevere" + id.toString();
    var ccases = "cbUncommonAllCases" + id.toString();
    var cstop = "cbUncommonStoptaking" + id.toString();

    return " <div class='wb-eqht col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Uncommon frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
            "</div>  " +
            " <div class='wb-eqht col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Uncommon symptom' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
             "</div> " +
            " <div class='wb-eqht col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Uncommon severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
            "</div>" +
            " <div class='wb-eqht col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Uncommon all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
            "</div> " +
            " <div class='wb-eqht col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                 "<input type='checkbox' title='Uncommon stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
            "</div> " +
            " <div class='wb-eqht col-xs-2'>" +
                '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveUncommon(' + id + ')" id="btnRemoveUncommon(' + id + ')" />' +
           "</div>";
}

function AddRareSymptomsTextBox() {

    RareCounter = RareCounter + 1;
    counter = RareCounter;
    $("#hdRareSymptoms").val(counter);
    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "wb-eqht row";
    identity.value = "Rare" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddRareSymptomsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraRareSymptoms").appendChild(div);
}

function GetAddRareSymptomsTextBoxDynamicTextBox(id) {
    var cfreq = "tbRareFrequency" + id.toString();
    var csymp = "tbRareSymptom" + id.toString();
    var csevere = "cbRareSevere" + id.toString();
    var ccases = "cbRareAllCases" + id.toString();
    var cstop = "cbRareStoptaking" + id.toString();

    return "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Rare frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "' /> " +
            "</div>  " +
            " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Rare symptom' class='form-control' id='" + csymp + "' name='" + csymp + "' /> " +
            "</div> " +
            " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Rare severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
            "</div>" +
           " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Rare all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
            "</div> " +
            " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                 "<input type='checkbox' title='Rare stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
            "</div> " +
            " <div class='col-xs-2'>" +
            '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveRare(' + id + ')" id="btnRemoveRare(' + id + ')" />' +
           "</div>";
}

function AddVeryRareSymptomsTextBox() {

    VeryRareCounter = VeryRareCounter + 1;
    counter = VeryRareCounter;
    $("#hdVeryRareSymptoms").val(counter);
    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "wb-eqht row";
    identity.value = "VeryRare" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddVeryRareSymptomsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraVeryRareSymptoms").appendChild(div);
}

function GetAddVeryRareSymptomsTextBoxDynamicTextBox(id) {
    var cfreq = "tbVeryRareFrequency" + id.toString();
    var csymp = "tbVeryRareSymptom" + id.toString();
    var csevere = "cbVeryRareSevere" + id.toString();
    var ccases = "cbVeryRareAllCases" + id.toString();
    var cstop = "cbVeryRareStoptaking" + id.toString();

    return " <div class='row wb-eqht'> " +
           " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Very rare frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
            "</div>  " +
            "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Very rare symptom' class='form-control' id='" + csymp + "' name='" + csymp + "' /> " +
            "</div> " +
             "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Very rare severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
            "</div>" +
             "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Very rare all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
            "</div> " +
             "<div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                 "<input type='checkbox' title='Very rare stop taking' class='form-control'  id='" + cstop + "' name='" + cstop + "'/>" +
            "</div> " +
             "<div class='col-xs-2'>" +
                '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveVeryRare(' + id + ')" id="btnRemoveVeryRare(' + id + ')" />' +
           "</div>" +
           "</div>";
}

function AddUnknownSymptomsTextBox() {

    UnknownCounter = UnknownCounter + 1;
    counter = UnknownCounter;
    $("#hdUnknownSymptoms").val(counter);
    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "wb-eqht row";
    identity.value = "Unknown" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddUnknownSymptomsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraUnknownSymptoms").appendChild(div);
}

function GetAddUnknownSymptomsTextBoxDynamicTextBox(id) {
    var cfreq = "tbUnknownFrequency" + id.toString();
    var csymp = "tbUnknownSymptom" + id.toString();
    var csevere = "cbUnknownSevere" + id.toString();
    var ccases = "cbUnknownAllCases" + id.toString();
    var cstop = "cbUnknownStoptaking" + id.toString();

    return " <div class='row wb-eqht'> " +
           " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 " <input type='text' title='Unknown frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
            "</div>  " +
            "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='text' title='Unknown symptom' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
            "</div> " +
            "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Unknown severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
            "</div>" +
            "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                 "<input type='checkbox' title='Unknown all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
            "</div> " +
            "<div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                 "<input type='checkbox' title='Unknown stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
            "</div> " +
            "<div class='col-xs-2'>" +
                        '<input class="btn btn-default btn-xs" type="button" value="' + removeButtonValue + '" onclick="RemoveUnknown(' + id + ')" id="btnRemoveUnknown(' + id + ')" />' +
           "</div>" +
           "</div>";
}

function RemoveMedicationForItemsTextBox(i) {
    var rowid = "#MedicationForItems" + i;
    $(rowid).remove();
}

var MedicationForItemsCounter = 0;

function AddMedicationForItemsTextBox() {

    MedicationForItemsCounter = MedicationForItemsCounter + 1;
    counter = MedicationForItemsCounter;

    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "roadynarow";
    identity.value = "MedicationForItems" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddMedicationForItemsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraMedicationForItems").appendChild(div);

    setup();
}

function GetAddMedicationForItemsTextBoxDynamicTextBox(id) {
    var swp = "tbMedicationForItems" + id.toString();
    return "<div class='row margin-top-medium'>" +
           "<div class='col-xs-10 text-left'><textarea id='" + swp + "' name='tbMedicationForItems' class='textarea'></textarea></div>" +
           "<div class='col-xs-2 text-left'>" +
                '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveMedicationForItemsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
           "</div>" + "</div>";
}

function RemoveSeriousWarningsPrecautionsTextBox(i) {
    var rowid = "#SeriousWarningsPrecautions" + i;
    $(rowid).remove();
}

var SeriousWarningsPrecautionsCounter = 0;

function AddSeriousWarningsPrecautionsTextBox() {

    SeriousWarningsPrecautionsCounter = SeriousWarningsPrecautionsCounter + 1;
    counter = SeriousWarningsPrecautionsCounter;

    var div = document.createElement('DIV');
    var att = document.createAttribute("class");
    var identity = document.createAttribute("id");
    att.value = "roadynarow";
    identity.value = "SeriousWarningsPrecautions" + counter;
    div.setAttributeNode(att);
    div.setAttributeNode(identity);
    div.innerHTML = GetAddSeriousWarningsPrecautionsTextBoxDynamicTextBox(counter);
    document.getElementById("dvExtraSeriousWarningsPrecautions").appendChild(div);

    setup();
}

function GetAddSeriousWarningsPrecautionsTextBoxDynamicTextBox(id) {
    var swp = "tbSeriousWarningsPrecautions" + id.toString();
    return "<div class='row margin-top-medium'>" +
           "<div class='col-xs-10 text-left'><textarea id='" + swp + "' name='tbSeriousWarningsPrecautions' class='textarea'></textarea></div>" +
           "<div class='col-xs-2'>" +
                '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
           "</div>" +
           "</div>";
}

var CommonCounter = 0;
var UncommonCounter = 0;
var RareCounter = 0;
var VeryRareCounter = 0;
var UnknownCounter = 0;

function RemoveCommon(i) {
    var rowid = "#Common" + i;
    $(rowid).remove();
}
function RemoveUncommon(i) {
    var rowid = "#Uncommon" + i;
    $(rowid).remove();
}
function RemoveRare(i) {
    var rowid = "#Rare" + i;
    $(rowid).remove();
}
function RemoveVeryRare(i) {
    var rowid = "#VeryRare" + i;
    $(rowid).remove();
}
function RemoveUnknown(i) {
    var rowid = "#Unknown" + i;
    $(rowid).remove();
}
