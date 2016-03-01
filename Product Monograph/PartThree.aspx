<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartThree.aspx.cs" Inherits="Product_Monograph.PartThree" ValidateRequest="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
                        "<input type='text' title='Common frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='text' title='Common symptom' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='checkbox' title='Common severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='checkbox' title='Common all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<input type='checkbox' title='Common stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
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
                        "<input type='text' title='Uncommon frenquency' class='form-control' id='" + cfreq + "' name='" + cfreq + "'/> " +
                   "</div>  " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='text' title='Uncommon symptom' class='form-control' id='" + csymp + "' name='" + csymp + "'/> " +
                    "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='checkbox' title='Uncommon severe' class='form-control' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   " <div class='col-xs-2 brdr-lft brdr-bttm'>" +
                        "<input type='checkbox' title='Uncommon all cases' class='form-control' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   " <div class='col-xs-2 brdr-lft brdr-rght brdr-bttm'>" +
                        "<input type='checkbox' title='Uncommon stop taking' class='form-control' id='" + cstop + "' name='" + cstop + "'/>" +
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

      
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<div>
    <asp:Menu ClientIDMode="Static" ID="submenutabs" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem text="Form instructions" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
         </Items>
    </asp:Menu>
</div>

<div class="mrgn-tp-md">
    <asp:Button ID="btnSave" class=" btn btn-primary" runat="server" Text="Save draft" OnClick="btnSave_Click" />
</div>

<div>
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>
<div><h2 id="PartIII" ><asp:Label ID="lblPartIII" runat="server"></asp:Label></h2></div>
<div>
    <h4><asp:Label ID="lblBrandNameProprietary" runat="server"></asp:Label></h4>
</div>
<div>
    <h4><asp:Label ID="lblProperName" runat="server"></asp:Label></h4>
</div>

<details class="margin-top-medium">
    <summary id="SUM_ABOUT">
        <asp:Label ID="lblSumAbout" runat="server"></asp:Label>
    </summary> 
    <div class="form-group">
        <div class="margin-top-medium">
             <asp:Label id="lblWHAT"  AssociatedControlID="tbMedicationForText" CssClass="control-label" runat="server"></asp:Label>
        </div>
       
        <div class="row">
            <div class="col-xs-10 text-left">                          
                <textarea id="tbMedicationForText" name="tbMedicationForText" class="textarea" runat="server"></textarea>
            </div>
        </div>
    </div>
    <div class="form-group hidden">
        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">
                <asp:Label id="lblPointForm" AssociatedControlID="tbMedicationForItems0" CssClass="control-label" runat="server"></asp:Label>
            </div>
            <div class="col-xs-2 text-left">
                <asp:Button ID="btnAddMedicationForItems" OnClientClick="AddMedicationForItemsTextBox(); return false;" CssClass="btn btn-default btn-xs"  runat="server"/>
                <!--<img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddMedicationForItemsTextBox()" id="btnAddMedicationForItems" width="22" height="22" alt="Add" />-->
            </div>
        </div>
        <div id="MedicationForItems0" class="row margin-top-medium">
            <div class="col-xs-10 text-left">                                        
                <textarea id="tbMedicationForItems0" name="tbMedicationForItems" class="textarea form-control" runat="server"></textarea>
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
                <asp:Label AssociatedControlID="tbMedicationDoes" id="lblWHAT_IT_DOES" CssClass="control-label" runat="server"></asp:Label>
            </div>
            <div class="row">
                <div class="col-xs-10 text-left">
                    <textarea id="tbMedicationDoes" name="tbMedicationDoes" runat="server" class="textarea form-control"></textarea>
                </div>
            </div>
    </div>
    <div class="form-group">
         <div class="margin-top-medium">
            <asp:Label id="lblWHEN_IT_SHOULD" AssociatedControlID="tbMedicationNotUsed" CssClass="control-label" runat="server"></asp:Label>
        </div>
        <div class="row"> 
            <div class="col-xs-10 text-left">                                   
                <textarea id="tbMedicationNotUsed" name="tbMedicationNotUsed" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>    
    </div>
    <div class="form-group">
        <div class="margin-top-medium">
            <asp:Label ID="lblWHAT_THE_MEDICINAL" AssociatedControlID="tbMedicationIngredient" CssClass="control-label" runat="server"></asp:Label><br />   
            <asp:Label ID="lblProperNameMI" runat="server"></asp:Label>
        </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">                                         
                <textarea id="tbMedicationIngredient" name="tbMedicationIngredient" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>      
    </div>
    <div class="form-group">
        <div class="margin-top-medium">
            <asp:Label id="lblWHAT_THE_NONMEDICINAL" AssociatedControlID="tbMedicationNonmed" CssClass="control-label" runat="server"></asp:Label><img id="tooltipNONMEDICINAL" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" alt="Non Medicinal Tooltip" />
        </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">                                               
                <textarea id="tbMedicationNonmed" name="tbMedicationNonmed" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>  
    </div>
    <section>        
           <asp:Label ID="lblNarrative" runat="server"></asp:Label>
    </section>    
    <div class="form-group">
       <div class="margin-top-medium">
            <asp:Label id="lblWHAT_DOSAGE"  AssociatedControlID="tbMedicationDosageForm" CssClass="control-label" runat="server"></asp:Label>
        </div>
       <div class="row"> 
            <div class="col-xs-10 text-left">                                             
                <textarea id="tbMedicationDosageForm" name="tbMedicationDosageForm" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
     </div> 
    </details>             

<details class="margin-top-medium">
    
    <summary id="SUM_WARNINGS" lang="en">
         <asp:Label ID="lblSumWarningsPrecautions" runat="server"></asp:Label>
    </summary>
   
    
        <div class="form-group">
             <div class="margin-top-medium">
                  <asp:label ID="lblSeriousWarnings" AssociatedControlID="tbSeriousWarningsPrecautions0" CssClass="control-label" runat="server"></asp:label><img id="tooltipSeriousWarningsandPrecautions" src="images/qmark.jpg"  style="width:24px; height:24px; cursor:pointer !important;" alt="Serious warnings and precautions tooltip"/>                
             </div>     
             <div>
                  <asp:Button ID="btnAddSeriousWarningsPrecautions" OnClientClick="AddSeriousWarningsPrecautionsTextBox(); return false;" CssClass="btn btn-default btn-xs"  runat="server"/>
                  <!--<img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddSeriousWarningsPrecautionsTextBox()" id="btnAddSeriousWarningsPrecautions" width="58" height="40" alt="Add a serious warnings and precautions"/>-->                                                         
             </div>
       
            <div  class="row" id="SeriousWarningsPrecautions0" > 
                <div class="col-xs-10 text-left">                                          
                    <textarea id="tbSeriousWarningsPrecautions0"  class="textarea" runat="server"></textarea>  
                </div>
                  
                <div class="col-xs-2">
                    <asp:Button ID="btnSeriousWarningsPrecautions" OnClientClick="RemoveSeriousWarningsPrecautionsTextBox(0); return false;" CssClass="btn btn-default btn-xs"  runat="server"/>
                    <!--<img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveSeriousWarningsPrecautionsTextBox(0)" id="btnSeriousWarningsPrecautions" width="58" height="40"  alt="Remove a serious warnings and precautions"/>-->                                                          
                </div>   
            </div>
          </div>
         <div id="dvExtraSeriousWarningsPrecautions">
         </div>
         <div class="row">
                <div class="col-md-11 text-center">
                    <div id="divTextBox16" class="text-left hidden"> 
                        <div><asp:Label ID="lblActivity" runat="server"></asp:Label></div>        
                        <div><asp:Label ID="lblCondition" runat="server"></asp:Label></div>                    
                        <div><asp:Label ID="lblDiseases" runat="server"></asp:Label></div>    
                        <div><asp:Label ID="lblIssues" runat="server"></asp:Label></div>    
                        <div><asp:Label ID="lblProcedure" runat="server"></asp:Label></div>    
                        <div><asp:Label ID="lblAllergy" runat="server"></asp:Label></div>    
                    </div>
               </div>
        </div>   
</details>

<details class="margin-top-medium">
    <summary id="SUM_INTERACTIONS">
        <asp:Label ID="lblSumInteractions" runat="server"></asp:Label>
    </summary>  
    <div class="form-group">
          <div class="margin-top-medium">
            <asp:Label ID="lblInteractions" AssociatedControlID="tbInteractionWithMed" CssClass="control-label" runat="server"></asp:label><img id="tooltipINTERACTIONSMEDICATION" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" alt="help Message of INTERACTIONS"/>        
          </div>

        <div class="row"> 
            <div class="col-xs-10 text-left">                 
                <textarea id="tbInteractionWithMed" name="tbInteractionWithMed" runat="server" class="textarea"></textarea>                            
            </div>
        </div>    
   </div>
</details>

<details class="margin-top-medium">
        <summary id="SUM_PROPER_USE">
            <asp:Label ID="lblSumProperUse" runat="server"></asp:Label>
        </summary>
        <div class="form-group">
           <div class="margin-top-medium">
                <asp:Label ID="lblProperUse" AssociatedControlID="tbProperUseMed" CssClass="control-label" runat="server"></asp:label>       
           </div>
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                    
                    <textarea id="tbProperUseMed" name="tbProperUseMed" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label id="lblUsualDose" AssociatedControlID="tbUsualDose" CssClass="control-label" runat="server"></asp:Label>      
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
               <div class="margin-top-medium" style="border:1px solid #D9D9D9; width:103px; height:103px;">
                    <img id="fuimage0" src="images/x.png"  alt=""/>
                    <input type="text" class="hidden" id="tbfuimagename0" name="tbfuimagename0" />
                    <input type="text" class="hidden" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour0"  />
               </div>
           </div>
         </div>
         <div class="form-group margin-top-medium">
             <asp:Label id="lblOverdose" AssociatedControlID="tbOverdose" CssClass="control-label" runat="server"></asp:Label><img id="tooltipOverdose" src="images/qmark.jpg" style="width:24px; height:24px; cursor: pointer !important;" alt="help Message of Overdose" />
             <div class="row">
                <div class="col-xs-10 text-left">                               
                    <textarea id="tbOverdose" name="tbOverdose" runat="server" class="textarea form-control"></textarea>
                </div>
            </div>
        </div>
        <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
           <div class="col-xs-10 symbolbrand">
                 <div><input type="file" id="fustrucform1" onchange="loadFile('fustrucform1','fuimage1','tbfuimagename1','tbfuimagebasesixtyfour1')" /></div>
                <div class="margin-top-medium"  style="border:1px solid #D9D9D9; width:103px; height:103px;">
                    <img id="fuimage1" src="images/x.png"  alt=""/>
                    <input type="text" class="hidden" id="tbfuimagename1" name="tbfuimagename1"/>
                    <input type="text" class="hidden" id="tbfuimagebasesixtyfour1" name="tbfuimagebasesixtyfour1" />
                </div>
            </div>
        </div>
       
       <div class="form-group margin-top-medium">
            <asp:Label id="lblMissedDose" AssociatedControlID="tbMissedDose" CssClass="control-label" runat="server"></asp:Label>         
            <div class="row">
                <div class="col-xs-10 text-left">                    
                    <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea form-control"></textarea>
                </div>
            </div>
        </div>

        <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
           <div class="col-xs-10 symbolbrand">
                <div><input type="file" id="fustrucform2" onchange="loadFile('fustrucform2','fuimage2','tbfuimagename2','tbfuimagebasesixtyfour2')" /></div>
                <div class="margin-top-medium"  style="border:1px solid #D9D9D9; width:103px; height:103px;">
                    <img id="fuimage2" src="images/x.png"  alt="" />
                    <input type="text" id="tbfuimagename2" name="tbfuimagename2" class="hidden"/>
                    <input type="text" id="tbfuimagebasesixtyfour2" name="tbfuimagebasesixtyfour2" class="hidden" />
                </div>
            </div>
        </div>

    </details>

<details class="margin-top-medium">
        <summary id="SUM_SIDE_EFFECTS">
            <asp:Label ID="lblSumSideEffect" runat="server"></asp:Label>
        </summary>
        <div class="form-group">
            <div class="margin-top-medium wb-inv">
                <asp:Label id="lblSideEffect" AssociatedControlID="tbSideEffects" CssClass="control-label" runat="server"></asp:Label>
            </div>
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                    
                    <textarea id="tbSideEffects" name="tbSideEffects" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>

        <div class="margin-top-medium">
            <asp:Label id="lblSERIOUS" runat="server"></asp:Label>
        </div>

        <section>
            <div class="row margin-top-medium wb-eqht">
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    &nbsp;
                </div>
                <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:Label id="LblSymptom" runat="server"></asp:Label>
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
                    <asp:label ID="lblCommon" runat="server"></asp:label>
                </div>
                <div class="col-xs-2 brdr-bttm">                         
                </div>
                <div class="col-xs-2 brdr-bttm">                         
                </div>
                <div class="col-xs-2 brdr-bttm">       
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">                         
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddCommonSymptomsTextBox()" id="btnAddExtrCommonSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>

        <section>
            <div id="Common0" class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input class="form-control" title="Common frequency" type="text" id="tbCommonFrequency0" name="tbCommonFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input class="form-control" title="Common symptom" type="text" id="tbCommonSymptom0" name="tbCommonSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input class="form-control" title="Common severe" type="checkbox" id="cbCommonSevere0" name="cbCommonSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input class="form-control" title="Common all cases" type="checkbox" id="cbCommonAllCases0" name="cbCommonAllCases0" />
                </div>
                <div class="col-xs-2 brdr-rght brdr-lft brdr-bttm">
                    <input class="form-control" title="Common stop taking" type="checkbox" id="cbCommonStoptaking0" name="cbCommonStoptaking0" />
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
                    <asp:Label ID="lblUncommon" runat="server"></asp:Label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddUncommonSymptomsTextBox()" id="btnAddExtrUncommonSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Uncommon frequency" class="form-control" id="tbUncommonFrequency0" name="tbUncommonFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Uncommon symptom" class="form-control" id="tbUncommonSymptom0" name="tbUncommonSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Uncommon severe" class="form-control" id="cbUncommonSevere0" name="cbUncommonSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Uncommon all cases" class="form-control" id="cbUncommonAllCases0" name="cbUncommonAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Uncommon stop taking" class="form-control" id="cbUncommonStoptaking0" name="cbUncommonStoptaking0" />
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
                    <asp:Label ID="lblRare" runat="server"></asp:Label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                </div>
                <div class="col-xs-2">
                    <img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddRareSymptomsTextBox()" id="btnAddExtrRareSymptoms" width="22" height="22" alt="Add"/>
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Rare frequency" class="form-control" id="tbRareFrequency0" name="tbRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Rare symptom" class="form-control" id="tbRareSymptom0" name="tbRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Rare severe" class="form-control" id="cbRareSevere0" name="cbRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Rare all cases" class="form-control" id="cbRareAllCases0" name="cbRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Rare stop taking" class="form-control" id="cbRareStoptaking0" name="cbRareStoptaking0" />
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
                    <asp:Label ID="lblVeryRare" runat="server"></asp:Label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddVeryRareSymptomsTextBox()" id="btnAddExtrVeryRareSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>
        
        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="text" title="Very rare frequency" class="form-control" id="tbVeryRareFrequency0" name="tbVeryRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Very rare symptom" class="form-control" id="tbVeryRareSymptom0" name="tbVeryRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="checkbox" title="Very rare severe" class="form-control" id="cbVeryRareSevere0" name="cbVeryRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="checkbox" title="Very rare all cases" class="form-control" id="cbVeryRareAllCases0" name="cbVeryRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">                    
                    <input type="checkbox" title="Very rare stop taking" class="form-control" id="cbVeryRareStoptaking0" name="cbVeryRareStoptaking0" />
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
                    <asp:Label id="lblUnkown" runat="server"></asp:Label>
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-bttm">
                </div>
                <div class="col-xs-2 brdr-rght brdr-bttm">
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/plus_icon.png" onclick="AddUnknownSymptomsTextBox()" id="btnAddExtrUnkownSymptoms" width="22" height="22" alt="Add" />
                </div>
            </div>
        </section>
    
        <section>
            <div class="row wb-eqht" id="Unknown0">
                <div class="col-xs-2 brdr-lft brdr-bttm">                   
                    <input type="text" title="Unknown frequency" class="form-control" id="tbUnknownFrequency0" name="tbUnknownFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Unknown symptom" class="form-control" id="tbUnknownSymptom0" name="tbUnknownSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Unknown severe" class="form-control" id="cbUnknownSevere0" name="cbUnknownSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Unknown all cases" class="form-control" id="cbUnknownAllCases0" name="cbUnknownAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Unknown stop taking" class="form-control" id="cbUnknownStoptaking0" name="cbUnknownStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <img style="cursor: pointer !important;" src="images/minus_icon.png" onclick="RemoveUnknown(0)" width="22" height="22" alt="Remove" />
                </div>
            </div>
            <div id="dvExtraUnknownSymptoms"></div>
        </section>

        <section>
           <div class="margin-top-meduim">
               <asp:Label ID="Label4" runat="server">*
                    <asp:Label ID="lblComment1" runat="server"></asp:Label>
                     &nbsp;           
                    <asp:Label ID="lblBrandNameTbl" runat="server">XXX</asp:Label>
                     &nbsp; 
                    <asp:Label ID="lblComment2" runat="server"></asp:Label>
              </asp:Label>
            </div>            
        </section>
        <div class="form-group">
            <div class="margin-top-large">
                <asp:Label ID="lblSideEffectsWhatToDo" AssociatedControlID="tbSideEffectsWhatToDo" CssClass="control-label" runat="server"></asp:Label>
            </div>
            <div class="row">
                <div class="col-xs-10 text-left">                    
                    <textarea id="tbSideEffectsWhatToDo" name="tbSideEffectsWhatToDo" runat="server" class="textarea"></textarea>
                </div>
            </div>
        </div>
         
</details>

<details class="margin-top-medium">
        <summary id="SUM_HOW_TO_STORE-IT">
            <asp:Label ID="lblSumStore" runat="server"></asp:Label>
        </summary>
        <div class="form-group">
            <div class="margin-top-medium wb-inv">
                <asp:Label ID="lblHowToStore" AssociatedControlID="tbHowToStore" CssClass="control-label" runat="server"></asp:Label>
            </div>
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">
                    <textarea id="tbHowToStore" name="tbHowToStore" runat="server" class="textarea form-control"></textarea>
                </div>
            </div>
        </div>

</details>

<details class="margin-top-medium">
        <summary id="SUM_REPORTING">
            <asp:Label ID="lblSumReporting" runat="server"></asp:Label>  
        </summary>
        <div class="form-group">
            <div class="margin-top-medium wb-inv">
                    <asp:Label ID="lblReporting" AssociatedControlID="tbReportingSuspectedSE" CssClass="control-label" runat="server"></asp:Label>
             </div>
            <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">
                    <textarea id="tbReportingSuspectedSE" name="tbReportingSuspectedSE" runat="server" class="textarea form-control"></textarea>
                </div>
            </div>
        </div>

    </details>

<details class="margin-top-medium margin-bottom-small">
    <summary id="SUM_MORE_INFORMATION">
            <asp:Label ID="lblSumMoreInfo" runat="server"></asp:Label>    
    </summary>
    <div class="form-group">
        <div class="margin-top-medium wb-inv">
                <asp:Label ID="lblMoreInfo" AssociatedControlID="tbMoreInformation" CssClass="control-label" runat="server"></asp:Label>
         </div>
        <div class="row margin-top-medium">
            <div class="col-xs-10 text-left">                
                <textarea id="tbMoreInformation" name="tbMoreInformation" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="mrgn-bttm-md mrgn-tp-md">
            <asp:Label ID="lblLastRevised" AssociatedControlID="tbLastrRevised" CssClass="control-label" runat="server"></asp:Label>           
            <asp:TextBox runat="server" ID="tbLastrRevised" Width="250" ReadOnly="true"></asp:TextBox>
            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbLastrRevised" Format="yyyy-MM-dd" />
        </div>
    </div>
</details>


<div class="margin-top-large">
    <asp:Menu ClientIDMode="Static" ID="submenutabsbottom" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem text="Form instructions" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
            </Items>
    </asp:Menu>
    
</div>

<asp:HiddenField runat="server" ID="hdUnknownSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdVeryRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdCommonSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdUncommonSymptoms" ClientIDMode="Static" />
</asp:Content>
