<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartThree.aspx.cs" Inherits="Product_Monograph.PartThree" ValidateRequest="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--Health Canada- PMP--> 
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">
        
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

       $(document).ready(function () {
           var bname = 'BrandName';
           $("#tooltipNONMEDICINAL").attr('title', 'For a full listing of nonmedicinal ingredients see Part 1 of the product monograph.');
           $("#tooltipSeriousWarningsandPrecautions").attr('title', 'Activities (Warnings and Precautions, e,g, under Occupational Hazards)\nCurrent conditions (Contraindications, Warnings and Precautions)\nPast diseases (Contraindications, Warnings and Precautions)\nReproductive issues (Contraindications, Warnings and Precautions)\nAnticipated medical procedures (Warnings and Precautions)\nAny allergies to this drug or its ingredients or components of the container (Contraindications)');
           $("#tooltipINTERACTIONSMEDICATION").attr('title', 'Drugs that may interact with ' + bname + ' include');
           $("#tooltipOverdose").attr('title', 'The boxed message may be modified to provide the most appropriate advice according to current standards of care for this drug product ');           
       });

       tinymce.init({
           //selector: "textarea",
           mode: "specific_textareas",
           editor_selector: "textarea",
           width: '100%',
           height: 0,
           min_height: 50,
           plugins: [
           ],
           toolbar1: "bold italic | bullist numlist | indent",
           menubar: false,
           resize: "both",
           toolbar_items_size: 'small',
           style_formats: [
           ],
           templates: [
           ],
           setup: function (theEditor) {
               theEditor.on('focus', function () {
                   $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").show();
               });
               theEditor.on('blur', function () {
                   $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
               });
               theEditor.on("init", function () {
                   $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
               });               
               $("textarea[name='tbReportingSuspectedSE']").each(function () {
                   alert($(this).val());
               });
               theEditor.on('init', function (args) {
                   $('iframe[id$="tbReportingSuspectedSE_ifr"]').css("height", "270px");
                   $('iframe[id$="tbMoreInformation_ifr"]').css("height", "80px");
               }),
                theEditor.on('keydown', function (ed, e) {
                    var tinymax, tinylen, htmlcount;
                    tinymax = 1500;
                    tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
                    if (tinylen > tinymax) {
                        if (ed.keyCode == 8 || ed.keyCode == 46) {
                            //backspace or delete
                        } else {
                            alert("Maximum " + tinymax + " characters");
                            ed.preventDefault();
                            ed.stopPropagation();
                        }
                    }
                }),
                theEditor.on('paste', function (ed, e) {
                    tinymax = 1500;
                    tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
                    clipboardlen = window.clipboardData.getData('Text').replace(/(<([^>]+)>)/ig, "").length;
                    totallen = tinylen + clipboardlen
                    if (totallen > tinymax) {
                        alert("Maximum " + tinymax + " characters");
                        ed.preventDefault();
                        ed.stopPropagation();
                    }
                });
           }
       });

       function setup() {
           tinymce.init({
               //selector: "textarea",
               mode: "specific_textareas",
               editor_selector: "textarea",
               width: '100%',
               height: 0,
               min_height: 50,
               plugins: [
               ],
               toolbar1: "bold italic | bullist numlist | indent",
               menubar: false,
               toolbar_items_size: 'small',
               style_formats: [
               ],
               templates: [
               ],
               setup: function (theEditor) {
                   theEditor.on('focus', function () {
                       $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").show();
                   });
                   theEditor.on('blur', function () {
                       $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
                   });
                   theEditor.on("init", function () {
                       $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
                   }),
                   theEditor.on('keydown', function (ed, e) {
                        var tinymax, tinylen, htmlcount;
                        tinymax = 1500;
                        tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
                        if (tinylen > tinymax) {
                            if (ed.keyCode == 8 || ed.keyCode == 46) {
                                //backspace or delete
                            } else {
                                alert("Maximum " + tinymax + " characters");
                                ed.preventDefault();
                                ed.stopPropagation();
                            }
                        }
                    }),
                    theEditor.on('paste', function (ed, e) {
                        tinymax = 1500;
                        tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
                        clipboardlen = window.clipboardData.getData('Text').replace(/(<([^>]+)>)/ig, "").length;
                        totallen = tinylen + clipboardlen
                        if (totallen > tinymax) {
                            alert("Maximum " + tinymax + " characters");
                            ed.preventDefault();
                            ed.stopPropagation();
                        }
                    });
               }
           });
       }

       function AddCommonSymptomsTextBox() {

           CommonCounter = CommonCounter + 1;
           counter = CommonCounter;
           $("#hdCommonSymptoms").val(counter);
           var div = document.createElement('DIV');
           var att = document.createAttribute("class");
           var identity = document.createAttribute("id");
           att.value = "roadynarow";
           identity.value = "Common" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddCommonSymptomsTextBoxDynamicTextBox(counter);
           document.getElementById("dvExtraCommonSymptoms").appendChild(div);

           setup();
       }

       function GetAddCommonSymptomsTextBoxDynamicTextBox(id) {           
           var cfreq = "tbCommonFrequency" + id.toString();
           var csymp = "tbCommonSymptom" + id.toString();
           var csevere = "cbCommonSevere" + id.toString();
           var ccases = "cbCommonAllCases" + id.toString();
           var cstop = "cbCommonStoptaking" + id.toString();
            
           return " <div class='row wb-eqht'> " +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cfreq + "'>Common frenquency</label>" +
                        "<input type='text' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csymp + "'>Common symptom</label>" +
                        "<input type='text' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csevere + "'>Common severe</label>" +
                        "<input type='checkbox' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + ccases + "'>Common all cases</label>" +
                        "<input type='checkbox' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cstop + "'>Common stop taking</label>" +
                        "<input type='checkbox' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   " <div class='col-xs-2'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveCommon(' + id + ')" width="22" height="22" alt="Remove" />' +
                  "</div>" +
                  "</div>";
       }

       function AddUncommonSymptomsTextBox() {

           UncommonCounter = UncommonCounter + 1;
           counter = UncommonCounter;
           $("#hdUncommonSymptoms").val(counter);
           var div = document.createElement('DIV');
           var att = document.createAttribute("class");
           var identity = document.createAttribute("id");
           att.value = "roadynarow";
           identity.value = "Uncommon" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddUncommonSymptomsTextBoxDynamicTextBox(counter);
           document.getElementById("dvExtraUncommonSymptoms").appendChild(div);

           setup();
       }
        
       function GetAddUncommonSymptomsTextBoxDynamicTextBox(id) {
           var cfreq = "tbUncommonFrequency" + id.toString();
           var csymp = "tbUncommonSymptom" + id.toString();
           var csevere = "cbUncommonSevere" + id.toString();
           var ccases = "cbUncommonAllCases" + id.toString();
           var cstop = "cbUncommonStoptaking" + id.toString();

           return " <div class='row wb-eqht'> " +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cfreq + "'>Uncommon frenquency</label>" +
                        "<input type='text'  class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csymp + "'>Uncommon symptom</label>" +
                        "<input type='text'  class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
                    "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csevere + "'>Uncommon severe</label>" +
                        "<input type='checkbox'  class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + ccases + "'>Uncommon all cases</label>" +
                        "<input type='checkbox'  class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cstop + "'>Uncommon stop taking</label>" +
                        "<input type='checkbox'  class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   " <div class='col-xs-2'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveUncommon(' + id + ')" width="22" height="22" alt="Remove"/>' +
                  "</div>" +
                  "</div>";
       }

       function AddRareSymptomsTextBox() {

           RareCounter = RareCounter + 1;
           counter = RareCounter;
           $("#hdRareSymptoms").val(counter);
           var div = document.createElement('DIV');
           var att = document.createAttribute("class");
           var identity = document.createAttribute("id");
           att.value = "roadynarow";
           identity.value = "Rare" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddRareSymptomsTextBoxDynamicTextBox(counter);
           document.getElementById("dvExtraRareSymptoms").appendChild(div);

           setup();
       }

       function GetAddRareSymptomsTextBoxDynamicTextBox(id) {
           var cfreq = "tbRareFrequency" + id.toString();
           var csymp = "tbRareSymptom" + id.toString();
           var csevere = "cbRareSevere" + id.toString();
           var ccases = "cbRareAllCases" + id.toString();
           var cstop = "cbRareStoptaking" + id.toString();

           return " <div class='row wb-eqht'> " +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cfreq + "'>Rare frenquency</label>" +
                        "<input type='text' class='form-control' id='" + cfreq + "' name='" + cfreq + "' /> " +
                   "</div>  " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csymp + "'>Rare symptom</label>" +
                        "<input type='text' class='form-control' id='" + csymp + "' name='" + csymp + "' /> " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csevere + "'>Rare severe</label>" +
                        "<input type='checkbox' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + ccases + "'>Rare all cases</label>" +
                        "<input type='checkbox' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cstop + "'>Rare stop taking</label>" +
                        "<input type='checkbox' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   " <div class='col-xs-2'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveRare(' + id + ')" width="22" height="22" alt="Remove"/>' +
                  "</div>" +
                  "</div>";
       }

       function AddVeryRareSymptomsTextBox() {

           VeryRareCounter = VeryRareCounter + 1;
           counter = VeryRareCounter;
           $("#hdVeryRareSymptoms").val(counter);
           var div = document.createElement('DIV');
           var att = document.createAttribute("class");
           var identity = document.createAttribute("id");
           att.value = "roadynarow";
           identity.value = "VeryRare" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddVeryRareSymptomsTextBoxDynamicTextBox(counter);
           document.getElementById("dvExtraVeryRareSymptoms").appendChild(div);

           setup();
       }

       function GetAddVeryRareSymptomsTextBoxDynamicTextBox(id) {
           var cfreq = "tbVeryRareFrequency" + id.toString();
           var csymp = "tbVeryRareSymptom" + id.toString();
           var csevere = "cbVeryRareSevere" + id.toString();
           var ccases = "cbVeryRareAllCases" + id.toString();
           var cstop = "cbVeryRareStoptaking" + id.toString();

           return " <div class='row wb-eqht'> " +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cfreq + "'>Very rare frenquency</label>" +
                        "<input type='text' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csymp + "'>Very rare symptom</label>" +
                        "<input type='text' class='form-control' id='" + csymp + "' name='" + csymp + "' /> " +
                   "</div> " +
                    "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csevere + "'>Very rare severe</label>" +
                        "<input type='checkbox' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                    "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + ccases + "'>Very rare all cases</label>" +
                        "<input type='checkbox' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                    "<div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cstop + "'>Very rare stop taking</label>" +
                        "<input type='checkbox' class='form-control'  id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                    "<div class='col-xs-2'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveVeryRare(' + id + ')" width="22" height="22" />' +
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
           att.value = "roadynarow";
           identity.value = "Unknown" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddUnknownSymptomsTextBoxDynamicTextBox(counter);
           document.getElementById("dvExtraUnknownSymptoms").appendChild(div);

           setup();
       }

       function GetAddUnknownSymptomsTextBoxDynamicTextBox(id) {
           var cfreq = "tbUnknownFrequency" + id.toString();
           var csymp = "tbUnknownSymptom" + id.toString();
           var csevere = "cbUnknownSevere" + id.toString();
           var ccases = "cbUnknownAllCases" + id.toString();
           var cstop = "cbUnknownStoptaking" + id.toString();

           return " <div class='row wb-eqht'> " +
                  " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + cfreq + "'>Unknown frenquency</label>" +
                        " <input type='text' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csymp + "'>Unknown symptom</label>" +
                        "<input type='text' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
                   "</div> " +
                   "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + csevere + "'>Unknown severe</label>" +
                        "<input type='checkbox' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<label class='wb-inv' for='" + ccases + "'>Unknown all cases</label>" +
                        "<input type='checkbox' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                         "<label class='wb-inv' for='" + cstop + "'>Unknown stop taking</label>" +
                        "<input type='checkbox' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div class='col-xs-2'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveUnknown(' + id + ')" width="22" height="22" />' +
                  "</div>"+
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
                  "<div class='col-xs-10'>" +
                       '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
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
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div>
    <asp:Menu ClientIDMode="Static" ID="submenutabs" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
        </Items>
    </asp:Menu>
</div>

<section class="mrgn-tp-md">
    <asp:Button ID="btnSave" class=" btn btn-primary" runat="server" Text="Save draft" OnClick="btnSave_Click" />
</section>

<div>
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>
<div><h2 id="PartIII" runat="server" ><%$ Resources:resource,PartIII %>"</h2></div>
<section>
    <h4><asp:Label ID="lblBrandNameProprietary" runat="server">Brand name</asp:Label></h4>
</section>

<section>
    <h4><asp:Label ID="lblProperName" runat="server">Proper name</asp:Label></h4>
</section>

<section>
    <h4><asp:Label ID="Label5" runat="server">Part III: consumer information</asp:Label></h4>
</section>

<details class="margin-top-medium">
    <summary id="SUM_ABOUT " lang="en">About this medication</summary> 
    <div class="form-group">
        <div class="margin-top-medium">
            <label id="lblWHAT" for="tbMedicationForText" lang="en">What the medication is used for</label>:       
        </div>
        <div class="row">
            <div class="col-xs-10 text-left">
                <textarea id="tbMedicationForText" name="tbMedicationForText" class="textarea" runat="server"></textarea>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <label id="lblPointForm" lang="en">Point form</label>:
            </div>
            <div class="col-xs-2 text-left">
                <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddMedicationForItemsTextBox()" id="btnAddMedicationForItems" width="22" height="22" alt="Add" />
            </div>
        </div>
        <div id="MedicationForItems0" class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <asp:Label runat="server" ID="lblMedicationForItem" CssClass="control-label"></asp:Label>
                                       
                <textarea id="tbMedicationForItems0" name="tbMedicationForItems" class="textarea form-control"></textarea>
            </div>
            <div class="col-xs-2 text-left">
                <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveMedicationForItemsTextBox(0)" width="22" height="22" alt="Remove" />
            </div>
        </div>

        <div id="dvExtraMedicationForItems">
        </div>
    </div>
     
   <div class="form-group">
            <div class="margin-top-medium">
                <label id="lblWHAT_IT_DOES" for="tbMedicationDoes" lang="en">What it does</label>:           
            </div>
            <div class="row">
                <div class="col-xs-10 text-left">
                    <textarea id="tbMedicationDoes" name="tbMedicationDoes" runat="server" class="textarea"></textarea>
                </div>
            </div>
    </div>
    <div class="form-group">
         <div class="margin-top-medium">
            <label id="lblWHEN_IT_SHOULD" for="tbMedicationNotUsed" lang="en">When it should not be used</label>:
        </div>
        <div class="row"> 
            <div class="col-xs-10 text-left">                     
                <textarea id="tbMedicationNotUsed" name="tbMedicationNotUsed" runat="server" class="textarea"></textarea>                            
            </div>
        </div>    
    </div>
    <div class="form-group">
        <div class="margin-top-medium">
            <label id="lblWHAT_THE_MEDICINAL" for="tbMedicationIngredient" lang="en">What the medicinal ingredient is</label>:<br />   
            <asp:Label ID="lblProperNameMI" runat="server">Proper name</asp:Label>
        </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">                          
                <textarea id="tbMedicationIngredient" name="tbMedicationIngredient" runat="server" class="textarea"></textarea>                            
            </div>
        </div>      
    </div>
    <div class="form-group">
        <div class="margin-top-medium">
            <label id="lblWHAT_THE_NONMEDICINAL" for="tbMedicationNonmed" lang="en">What the nonmedicinal ingredients are</label>:<img id="tooltipNONMEDICINAL" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" />
        </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">                           
                <textarea id="tbMedicationNonmed" name="tbMedicationNonmed" runat="server" class="textarea"></textarea>                            
            </div>
        </div>  
    </div>
    <section>        
           <asp:Label ID="lblNarrative" runat="server"></asp:Label>
    </section>    
    <div class="form-group">
       <div class="margin-top-medium">
            <label id="lblWHAT_DOSAGE" for="tbMedicationDosageForm" lang="en">What dosage forms it comes in</label>:
        </div>

       <div class="row"> 
            <div class="col-xs-10 text-left">                           
                <textarea id="tbMedicationDosageForm" name="tbMedicationDosageForm" runat="server" class="textarea"></textarea>                            
            </div>
        </div>
     </div> 
    </details>             

<details class="margin-top-medium">
        <summary>Warnings and precautions</summary>
        <div class="form-group">
             <div class="margin-top-medium">    
                  <label for="tbSeriousWarningsPrecautions0" lang="en">Serious warnings and precautions</label><img id="tooltipSeriousWarningsandPrecautions" src="images/qmark.jpg"  style="width:24px; height:24px; cursor:pointer !important;" />
             </div>     
             <div class="wb-invisible">
                  <img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddSeriousWarningsPrecautionsTextBox()" id="btnAddSeriousWarningsPrecautions" width="58" height="40" />                                                          
             </div>
       
            <div  class="row" id="SeriousWarningsPrecautions0" > 
                <div class="col-xs-10 text-left"> 
                    <textarea id="tbSeriousWarningsPrecautions0" name="tbSeriousWarningsPrecautions" class="textarea"></textarea>
                </div>
                  
                <div class="col-xs-2 wb-invisible">
                    <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveSeriousWarningsPrecautionsTextBox(0)" id="btnSeriousWarningsPrecautions" width="58" height="40" />                                                          
                </div>   
            </div>
         </div>
         <div id="dvExtraSeriousWarningsPrecautions">
         </div>
         <div class="row">
                <div class="col-md-11 text-center wb-invisible">
                    <div id="divTextBox16" class="text-left"> 
                        <div>Activities (Warnings and Precautions, e,g, under Occupational Hazards)</div>        
                        <div>Current conditions (Contraindications, Warnings and Precautions)</div>                    
                        <div>Past diseases (Contraindications, Warnings and Precautions)</div>    
                        <div>Reproductive issues (Contraindications, Warnings and Precautions)</div>    
                        <div>Anticipated medical procedures (Warnings and Precautions)</div>    
                        <div>Any allergies to this drug or its ingredients or components of the container (Contraindications)</div>    
                    </div>
               </div>
        </div>   
</details>

<details class="margin-top-medium">
    <summary id="SUM_INTERACTIONS" lang="en">Interactions with this medication</summary>  
    <div class="form-group">
          <div class="margin-top-medium">
            <label id="lblINTERACTIONS_WITH" for="tbInteractionWithMed" lang="en">Interactions with this medication</label><img id="tooltipINTERACTIONSMEDICATION" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" alt="help Message of INTERACTIONS"/>        
          </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">   
                <textarea id="tbInteractionWithMed" name="tbInteractionWithMed" runat="server" class="textarea"></textarea>                            
            </div>
        </div>    
   </div>
</details>

<details class="margin-top-medium">
        <summary id="SUM_PROPER_USE " lang="en">Proper use of this medication</summary>
        <div class="form-group">
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">
                    <label for="tbProperUseMed"  class="wb-inv" lang="en">Proper use  of this medication</label>
                    <textarea id="tbProperUseMed" name="tbProperUseMed" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="margin-top-medium">
                <label id="lblUsualDose" for="tbUsualDose" lang="en">Usual dose</label>:       
            </div>

            <div class="row">
                <div class="col-xs-10 text-left">
                    <textarea id="tbUsualDose" name="tbUsualDose" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>
        
        <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
           <div class="col-xs-10 symbolbrand">
               <div><input type="file" id="fustrucform0" onchange="loadFile('fustrucform0','fuimage0','tbfuimagename0','tbfuimagebasesixtyfour0')" /></div>
               <div class="margin-top-medium">
                    <img id="fuimage0" src="images/x.png" />
                    <input type="text" class="wb-inv" id="tbfuimagename0" name="tbfuimagename0"  />
                    <input type="text" class="wb-inv" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour0"  />
               </div>
           </div>
         </div>
         <div class="form-group margin-top-medium">
             <label id="lblOverdose" for="tbOverdose" lang="en">Overdose</label>:<img id="tooltipOverdose" src="images/qmark.jpg" width ="24" height ="24"; cursor: pointer !important;" alt="help Message of Overdose" />
             <div class="row">
                <div class="col-xs-10 text-left">               
                    <textarea id="tbOverdose" name="tbOverdose" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>
        <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
           <div class="col-xs-10 symbolbrand">
                 <div><input type="file" id="fustrucform1" onchange="loadFile('fustrucform1','fuimage1','tbfuimagename1','tbfuimagebasesixtyfour1')" /></div>
                <div class="margin-top-medium">
                    <img id="fuimage1" src="images/x.png" />
                    <input type="text" class="wb-inv" id="tbfuimagename1" name="tbfuimagename1"/>
                    <input type="text" class="wb-inv" id="tbfuimagebasesixtyfour1" name="tbfuimagebasesixtyfour1" />
                </div>
            </div>
        </div>
       
       <div class="form-group margin-top-medium">
            <label id="lblMissedDose" for="tbMissedDose" lang="en">Missed dose</label>:          
            <div class="row">
                <div class="col-xs-10 text-left">
                    <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>

        <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
           <div class="col-xs-10 symbolbrand">
                <div><input type="file" id="fustrucform2" onchange="loadFile('fustrucform2','fuimage2','tbfuimagename2','tbfuimagebasesixtyfour2')" /></div>
                <div class="margin-top-medium">
                    <img id="fuimage2" src="images/x.png" />
                    <input type="text" id="tbfuimagename2" name="tbfuimagename2" style="display: none;" />
                    <input type="text" id="tbfuimagebasesixtyfour2" name="tbfuimagebasesixtyfour2" style="display: none;" />
                </div>
            </div>
        </div>

    </details>

<details class="margin-top-medium">
        <summary id="SUM_SIDE EFFECTS" lang="en">Side effects and what to do about them</summary>
        <div class="form-group">
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">
                    <label for="tbSideEffects" class="wb-inv" lang="en">Side effects and what to do about them: </label>
                    <textarea id="tbSideEffects" name="tbSideEffects" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>

        <div class="margin-top-medium">
            <label id="lblSERIOUS" lang="en">Serious side effects, how often they happen and what to do about them</label>
        </div>

        <section>
            <div class="row margin-top-medium wb-eqht">
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    &nbsp;
                </div>
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <label id="LblSymptom" lang="en">Symptom</label>
                </div>
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocIfSever" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocAllCases" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
                <div class="col-xs-2 brdr-tp brdr-rght brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbStoptakingdrug" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label id="lblCommon" lang="en">Common</label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddCommonSymptomsTextBox()" id="btnAddExtrCommonSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>

        <section>
            <div id="Common0" class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbCommonFrequency0">Common frenquency</label>
                    <input class="form-control" type="text" id="tbCommonFrequency0" name="tbCommonFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbCommonSymptom0">Common symptom</label>
                    <input class="form-control" type="text" id="tbCommonSymptom0" name="tbCommonSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbCommonSevere0">Common severe</label>
                    <input class="form-control" type="checkbox" id="cbCommonSevere0" name="cbCommonSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbCommonAllCases0">Common all cases</label>
                    <input class="form-control" type="checkbox" id="cbCommonAllCases0" name="cbCommonAllCases0" />
                </div>
                <div class="col-xs-2 brdr-rght brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbCommonStoptaking0">Common stop taking</label>
                    <input class="form-control" type="checkbox" id="cbCommonStoptaking0" name="cbCommonStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveCommon(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraCommonSymptoms">
            </div>
        </section>
        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label id="lblUncommon" lang="en">Uncommon</label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddUncommonSymptomsTextBox()" id="btnAddExtrUncommonSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbUncommonFrequency0">Common frequency</label>
                    <input type="text" class="form-control" id="tbUncommonFrequency0" name="tbUncommonFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbUncommonFrequency0">Common symptom</label>
                    <input type="text" class="form-control" id="tbUncommonSymptom0" name="tbUncommonSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbUncommonSevere0">Uncommon severe0</label>
                    <input type="checkbox" class="form-control" id="cbUncommonSevere0" name="cbUncommonSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbUncommonAllCases0">Uncommon all cases</label>
                    <input type="checkbox" class="form-control" id="cbUncommonAllCases0" name="cbUncommonAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <label class="wb-invisible" for="cbUncommonStoptaking0">Uncommon stop taking</label>
                    <input type="checkbox" class="form-control" id="cbUncommonStoptaking0" name="cbUncommonStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveUncommon(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraUncommonSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label id="lblRare" lang="en">Rare</label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2">
                    <img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddRareSymptomsTextBox()" id="btnAddExtrRareSymptoms" width="22" height="22" alt="Add"/>
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbRareFrequency0">Rare frequency</label>
                    <input type="text" class="form-control" id="tbRareFrequency0" name="tbRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbRareSymptom0">Rare symptom</label>
                    <input type="text" class="form-control" id="tbRareSymptom0" name="tbRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbRareSevere0">Rare severe</label>
                    <input type="checkbox" class="form-control" id="cbRareSevere0" name="cbRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbRareAllCases0">Rare all cases</label>
                    <input type="checkbox" class="form-control" id="cbRareAllCases0" name="cbRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <label class="wb-invisible" for="cbRareStoptaking0">Rare stop taking</label>
                    <input type="checkbox" class="form-control" id="cbRareStoptaking0" name="cbRareStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveRare(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label id="lblVeryRare" lang="en">Very Rare</label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddVeryRareSymptomsTextBox()" id="btnAddExtrVeryRareSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>
        
        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbVeryRareFrequency0">Very rare frequency</label>
                    <input type="text" class="form-control" id="tbVeryRareFrequency0" name="tbVeryRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbVeryRareSymptom0">Very rare symptom</label>
                    <input type="text" class="form-control" id="tbVeryRareSymptom0" name="tbVeryRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbVeryRareSevere0">Very rare severe</label>
                    <input type="checkbox" class="form-control" id="cbVeryRareSevere0" name="cbVeryRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbVeryRareAllCases0">Very rare all cases</label>
                    <input type="checkbox" class="form-control" id="cbVeryRareAllCases0" name="cbVeryRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <label class="wb-invisible" for="cbVeryRareStoptaking0">Very rare stop taking</label>
                    <input type="checkbox" class="form-control" id="cbVeryRareStoptaking0" name="cbVeryRareStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveVeryRare(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraVeryRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label id="lblUnkown" lang="en">Unkown</label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                    &nbsp;       
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddUnknownSymptomsTextBox()" id="btnAddExtrUnkownSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>
    
        <section>
            <div class="row wb-eqht" id="Unknown0">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbUnknownFrequency0">Unknown frequency</label>
                    <input type="text" class="form-control" id="tbUnknownFrequency0" name="tbUnknownFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="tbUnknownSymptom0">Unknown symptom"</label>
                    <input type="text" class="form-control" id="tbUnknownSymptom0" name="tbUnknownSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbUnknownSevere0">Unknown severe</label>
                    <input type="checkbox" class="form-control" id="cbUnknownSevere0" name="cbUnknownSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <label class="wb-invisible" for="cbUnknownAllCases0">Unknown all cases</label>
                    <input type="checkbox" class="form-control" id="cbUnknownAllCases0" name="cbUnknownAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <label class="wb-invisible" for="cbUnknownStoptaking0">Unknown stop taking</label>
                    <input type="checkbox" class="form-control" id="cbUnknownStoptaking0" name="cbUnknownStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveUnknown(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraUnknownSymptoms"></div>
        </section>

        <section>
            <div class="row mrgn-tp-md">
                <asp:Label ID="Label4" runat="server">*<label id="lbl" lang="en">This is not a complete list of side effects.  For any unexpected effects while taking</label>
                    &nbsp;
           
                    <asp:Label ID="lblBrandNameTbl" runat="server">Brand name</asp:Label>
                    , contact your doctor or pharmacist.</asp:Label>
            </div>
        </section>

        <div class="row mrgn-tp-md">
            <div class="col-xs-10 text-left">
                <label class="wb-invisible" for="tbSideEffectsWhatToDo">Side effects what to do</label>
                <textarea id="tbSideEffectsWhatToDo" name="tbSideEffectsWhatToDo" runat="server" class="textarea"></textarea>
            </div>
        </div>
         
</details>

<details class="margin-top-medium">
        <summary id="SUM_HOW_TO_STORE-IT" lang="en">How to store it</summary>

        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <label for="tbHowToStore" class="wb-inv">How to store it</label>
                <textarea id="tbHowToStore" name="tbHowToStore" runat="server" class="textarea"></textarea>
            </div>
        </div>

</details>

<details class="margin-top-medium">
        <summary id="SUM_REPORTING" lang="EN">Reporting suspected side effects</summary>

        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <label for="tbReportingSuspectedSE" class="wb-inv">Reporting suspected side effects</label>
                <textarea id="tbReportingSuspectedSE" name="tbReportingSuspectedSE" runat="server" class="textarea"></textarea>
            </div>
        </div>

    </details>

<details class="margin-top-medium margin-bottom-small">
        <summary id="SUM_MORE_INFORMATION" lang="en">More information</summary>

        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <label for="tbMoreInformation" class="wb-inv">More information</label>
                <textarea id="tbMoreInformation" name="tbMoreInformation" runat="server" class="textarea"></textarea>
            </div>
        </div>
        <div class="mrgn-bttm-md mrgn-tp-md">
            Last revised:&nbsp;
             <label for="tbLastrRevised" class="wb-inv">Last revised date</label>
            <asp:TextBox runat="server" ID="tbLastrRevised" Width="250" ReadOnly="true"></asp:TextBox>
            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbLastrRevised" Format="yyyy-MM-dd" />
        </div>
</details>


<div class="list-group mrgn-top-lg">
    <div class="list-group-item  list-group-item-info">
    <asp:Menu ClientIDMode="Static" ID="submenutabsbottom" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
        </Items>
    </asp:Menu>
    </div>
</div>

<asp:HiddenField runat="server" ID="hdUnknownSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdVeryRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdCommonSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdUncommonSymptoms" ClientIDMode="Static" />
</asp:Content>
