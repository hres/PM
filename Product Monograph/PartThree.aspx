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
           toolbar1: "bold italic | bullist numlist",
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
               toolbar1: "bold italic | bullist numlist",
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
            
           return "<div style='width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>" +
                        "<input type='text' id='" + cfreq + "' name='" + cfreq + "' style='width:95%'/> " +
                   "</div>  " +
                   "<div style='width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>    " +
                        "<input type='text' id='" + csymp + "' name='" + csymp + "' style='width:95%'/> " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveCommon(' + id + ')" width="58" height="40" />' +
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

           return "<div style='width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>" +
                        "<input type='text' id='" + cfreq + "' name='" + cfreq + "' style='width:95%'/> " +
                   "</div>  " +
                   "<div style='width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>    " +
                        "<input type='text' id='" + csymp + "' name='" + csymp + "' style='width:95%'/> " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveUncommon(' + id + ')" width="58" height="40" />' +
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

           return "<div style='width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>" +
                        "<input type='text' id='" + cfreq + "' name='" + cfreq + "' style='width:95%'/> " +
                   "</div>  " +
                   "<div style='width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>    " +
                        "<input type='text' id='" + csymp + "' name='" + csymp + "' style='width:95%'/> " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveRare(' + id + ')" width="58" height="40" />' +
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

           return "<div style='width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>" +
                        "<input type='text' id='" + cfreq + "' name='" + cfreq + "' style='width:95%'/> " +
                   "</div>  " +
                   "<div style='width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>    " +
                        "<input type='text' id='" + csymp + "' name='" + csymp + "' style='width:95%'/> " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveVeryRare(' + id + ')" width="58" height="40" />' +
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

           return "<div style='width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>" +
                        "<input type='text' id='" + cfreq + "' name='" + cfreq + "' style='width:95%'/> " +
                   "</div>  " +
                   "<div style='width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;'>    " +
                        "<input type='text' id='" + csymp + "' name='" + csymp + "' style='width:95%'/> " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + csevere + "' name='" + csevere + "'/>  " +
                   "</div>" +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + ccases + "' name='" + ccases + "'/>   " +
                   "</div> " +
                   "<div style='width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;'>" +
                        "<input type='checkbox' id='" + cstop + "' name='" + cstop + "'/>" +
                   "</div> " +
                   "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveUnknown(' + id + ')" width="58" height="40" />' +
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
           return "<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbMedicationForItems' class='textarea'></textarea></div>" +
                  "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveMedicationForItemsTextBox(' + id + ')" width="58" height="40" />' +
                  "</div>";
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
           return "<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbSeriousWarningsPrecautions' class='textarea'></textarea></div>" +
                  "<div style='width:5%; float:left;'>" +
                       '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" width="58" height="40" />' +
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

<div style="clear:both; padding-top: 20px;">
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

<section style="clear:both; text-align:left; padding-left:0px; padding-top: 8px;">
    <asp:Button ID="btnSave" runat="server" Text="Save draft" OnClick="btnSave_Click" />
</section>

<div style="float:left; padding:10px 10px 10px 10px; clear:both;">
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>

<section style="width:100%; padding-left: 0px; clear:both;">
    <h4 style="border: 0px !important;"><asp:Label ID="lblBrandNameProprietary" runat="server">BRAND NAME</asp:Label></h4>
</section>

<section style="width:100%; padding-left: 0px; clear:both;">
    <h4 style="border: 0px !important;"><asp:Label ID="lblProperName" runat="server">PROPER NAME</asp:Label></h4>
</section>

<section style="width:100%; padding-left: 0px; clear:both;">
    <h4 style="border: 0px !important;"><asp:Label ID="Label5" runat="server">PART III: CONSUMER INFORMATION</asp:Label></h4>
</section>

<details style="clear:both; padding-top: 10px;">
    <summary>ABOUT THIS MEDICATION</summary>               
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHAT THE MEDICATION IS USED FOR:
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left:0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationForText" name="tbMedicationForText" runat="server" class="textarea"></textarea>                            
        </div>
    </div>   

    <div style="padding: 8px 4px 4px 0px; padding-left: 0px; width:90%; display:none;">
        <div style="width:94%; float:left; clear:both;">Point form:
        </div>          
        <div style="width:5%; float:left; padding-left:4px;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddMedicationForItemsTextBox()" id="btnAddMedicationForItems" width="58" height="40" />                                                          
        </div>     
    </div> 
        
    <div id="MedicationForItems0" style="width:90%; padding-left: 0px; clear:both; display:none;">
        <div style="width:94%; float:left;">
            <textarea id="tbMedicationForItems0" name="tbMedicationForItems" class="textarea"></textarea>
        </div>  
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveMedicationForItemsTextBox(0)" width="58" height="40" />                                                          
        </div> 
    </div>    

    <div id="dvExtraMedicationForItems" style="width:90%; padding-left: 0px; clear:both; display:none;">
    </div>
        
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHAT IT DOES:
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationDoes" name="tbMedicationDoes" runat="server" class="textarea"></textarea>                            
        </div>
    </div>         

    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHEN IT SHOULD NOT BE USED:
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationNotUsed" name="tbMedicationNotUsed" runat="server" class="textarea"></textarea>                            
        </div>
    </div>    
    
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHAT THE MEDICINAL INGREDIENT IS:</br>    
        <asp:Label ID="lblProperNameMI" runat="server">PROPER NAME</asp:Label>
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationIngredient" name="tbMedicationIngredient" runat="server" class="textarea"></textarea>                            
        </div>
    </div>      
    
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHAT THE NONMEDICINAL INGREDIENTS ARE:<img id="tooltipNONMEDICINAL" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" />
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationNonmed" name="tbMedicationNonmed" runat="server" class="textarea"></textarea>                            
        </div>
    </div>  

    <section style="width:100%; padding-left: 0px; padding-bottom: 10px; clear:both;">        
        <asp:Label ID="lblNarrative" runat="server"></asp:Label>
    </section>    
    
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        WHAT DOSAGE FORMS IT COMES IN:
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMedicationDosageForm" name="tbMedicationDosageForm" runat="server" class="textarea"></textarea>                            
        </div>
    </div>
</details>             

<details style="clear:both; padding-top: 20px;">
    <summary>WARNINGS AND PRECAUTIONS</summary>  

    <div style="padding: 4px 4px 4px 0px; padding-left: 0px; width:90%;">
        <div style="width:94%; float:left; clear:both;">Serious Warnings and Precautions<img id="tooltipSeriousWarningsandPrecautions" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" />
        </div>  
        <div style="width:5%; float:left; padding-left:4px; display:none;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddSeriousWarningsPrecautionsTextBox()" id="btnAddSeriousWarningsPrecautions" width="58" height="40" />                                                          
        </div>        
    </div> 

    <div id="SeriousWarningsPrecautions0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:94%; float:left;">
            <textarea id="tbSeriousWarningsPrecautions0" name="tbSeriousWarningsPrecautions" class="textarea"></textarea>
        </div>  
        <div style="width:5%; float:left; display:none;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveSeriousWarningsPrecautionsTextBox(0)" id="btnSeriousWarningsPrecautions" width="58" height="40" />                                                          
        </div>   
    </div>

    <div id="dvExtraSeriousWarningsPrecautions" style="width:90%; padding-left: 0px; clear:both;">
    </div>

    <div style="width:90%; text-align:center; clear:both; padding-left: 0px; display:none;">
        <div id="divTextBox16" style="text-align:left;"> 
            <div style="padding: 4px 4px 4px 0px">Activities (Warnings and Precautions, e,g, under Occupational Hazards)</div>        
            <div style="padding: 4px 4px 4px 0px">Current conditions (Contraindications, Warnings and Precautions)</div>                    
            <div style="padding: 4px 4px 4px 0px">Past diseases (Contraindications, Warnings and Precautions)</div>    
            <div style="padding: 4px 4px 4px 0px">Reproductive issues (Contraindications, Warnings and Precautions)</div>    
            <div style="padding: 4px 4px 4px 0px">Anticipated medical procedures (Warnings and Precautions)</div>    
            <div style="padding: 4px 4px 4px 0px">Any allergies to this drug or its ingredients or components of the container (Contraindications)</div>    
        </div>
    </div>    
</details>

<details style="clear:both; padding-top: 20px;">
    <summary>INTERACTIONS WITH THIS MEDICATION</summary>  

    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        INTERACTIONS WITH THIS MEDICATION<img id="tooltipINTERACTIONSMEDICATION" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" />        
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbInteractionWithMed" name="tbInteractionWithMed" runat="server" class="textarea"></textarea>                            
        </div>
    </div>    

</details>

<details style="clear:both; padding-top: 20px;">
    <summary>PROPER USE OF THIS MEDICATION</summary>  

    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        Usual Dose:
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbUsualDose" name="tbUsualDose" runat="server" class="textarea"></textarea>                            
        </div>
    </div>  

    <div style="width:90%; clear:both; padding-left: 0px;">
        <div class="symbolbrand" style="width:500px;">
            <div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file" id="fustrucform0" style="width:400px;" onchange="loadFile('fustrucform0','fuimage0','tbfuimagename0','tbfuimagebasesixtyfour0')"/></div>            
            <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
                <img id="fuimage0" src="images/x.png"/>
                <input type="text" id="tbfuimagename0" name="tbfuimagename0" style="display:none;" />
                <input type="text" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour0" style="display:none;" />
            </div>                      
        </div>
    </div>

    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        Overdose:<img id="tooltipOverdose" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" />        
    </div>

    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbOverdose" name="tbOverdose" runat="server" class="textarea"></textarea>                            
        </div>
    </div>  

    <div style="width:90%; clear:both; padding-left: 0px;">
        <div class="symbolbrand" style="width:500px;">
            <div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file" id="fustrucform1" style="width:400px;" onchange="loadFile('fustrucform1','fuimage1','tbfuimagename1','tbfuimagebasesixtyfour1')"/></div>            
            <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
                <img id="fuimage1" src="images/x.png"/>
                <input type="text" id="tbfuimagename1" name="tbfuimagename1" style="display:none;" />
                <input type="text" id="tbfuimagebasesixtyfour1" name="tbfuimagebasesixtyfour1" style="display:none;" />
            </div>                      
        </div>
    </div>

    <div style="padding-left: 0px; clear:both; padding-top:20px;">
        Missed Dose:
    </div>
    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea"></textarea>                            
        </div>
    </div>    
    
    <div style="width:90%; clear:both; padding-left: 0px;">
        <div class="symbolbrand" style="width:500px;">
            <div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file" id="fustrucform2" style="width:400px;" onchange="loadFile('fustrucform2','fuimage2','tbfuimagename2','tbfuimagebasesixtyfour2')"/></div>            
            <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
                <img id="fuimage2" src="images/x.png"/>
                <input type="text" id="tbfuimagename2" name="tbfuimagename2" style="display:none;" />
                <input type="text" id="tbfuimagebasesixtyfour2" name="tbfuimagebasesixtyfour2" style="display:none;" />
            </div>                      
        </div>
    </div>       
</details>

<details style="clear:both; padding-top: 20px;">
    <summary>SIDE EFFECTS AND WHAT TO DO ABOUT THEM</summary>  
    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbSideEffects" name="tbSideEffects" runat="server" class="textarea"></textarea>                            
        </div>
    </div>       
    
    <div style="padding-left: 0px; clear:both; padding-top:20px;">
         SERIOUS SIDE EFFECTS, HOW OFTEN THEY HAPPEN AND WHAT TO DO ABOUT THEM
    </div>   
    
    <section style="width:90%; padding-left: 0px; clear:both; padding-top:4px;">
        <div style="width:12.75%; float:left; border-top: 1px solid #D9D9D9; border-left: 1px solid #D9D9D9; border-right: 1px solid #D9D9D9; border-bottom: 0px; height:50px;">
            &nbsp;
        </div>
        <div style="width:25.75%; float:left; border-top: 1px solid #D9D9D9; border-left: 1px solid #D9D9D9; border-right: 1px solid #D9D9D9; border-bottom: 0px; height:50px;">
            Symptom
        </div>
        <div style="width:15.75%; float:left; border-top: 1px solid #D9D9D9; border-left: 1px solid #D9D9D9; border-right: 1px solid #D9D9D9; border-bottom: 0px; height:50px;">             
            <asp:TextBox ID="tbTalkwithDocIfSever" runat="server" TextMode="MultiLine" style="width:100%; height:100%"></asp:TextBox>
        </div>
        <div style="width:15.75%; float:left; border-top: 1px solid #D9D9D9; border-left: 1px solid #D9D9D9; border-right: 1px solid #D9D9D9; border-bottom: 0px; height:50px;">
            <asp:TextBox ID="tbTalkwithDocAllCases" runat="server" TextMode="MultiLine" style="width:100%; height:100%"></asp:TextBox>            
        </div>
        <div style="width:15.75%; float:left; border-top: 1px solid #D9D9D9; border-left: 1px solid #D9D9D9; border-right: 1px solid #D9D9D9; border-bottom: 0px; height:50px;">            
            <asp:TextBox ID="tbStoptakingdrug" runat="server" TextMode="MultiLine" style="width:100%; height:100%"></asp:TextBox>  
        </div>    
    </section>                       

    <section style="width:90%; padding-left: 0px; clear:both; padding-top:0px;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; height:50px;">
            Common
        </div>
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddCommonSymptomsTextBox()" id="btnAddExtrCommonSymptoms" width="58" height="40" />                                                          
        </div>  
    </section>
        
    <div id="Common0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">
            <input type="text" id="tbCommonFrequency0" name="tbCommonFrequency0" style="width:95%"/>
        </div>  
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">      
            <input type="text" id="tbCommonSymptom0" name="tbCommonSymptom0" style="width:95%"/>       
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbCommonSevere0" name="cbCommonSevere0"/>              
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbCommonAllCases0" name="cbCommonAllCases0"/>           
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbCommonStoptaking0" name="cbCommonStoptaking0"/>                
        </div>  
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveCommon(0)" width="58" height="40" />                                                          
        </div>   
    </div>    
    <div id="dvExtraCommonSymptoms" style="width:90%; padding-left: 0px; clear:both;">
    </div>
 
    <section style="width:90%; padding-left: 0px; clear:both; padding-top:20px;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; height:50px;">
            Uncommon
        </div>
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddUncommonSymptomsTextBox()" id="btnAddExtrUncommonSymptoms" width="58" height="40" />                                                          
        </div>  
    </section>
        
    <div id="Uncommon0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">
            <input type="text" id="tbUncommonFrequency0" name="tbUncommonFrequency0" style="width:95%"/>
        </div>  
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">      
            <input type="text" id="tbUncommonSymptom0" name="tbUncommonSymptom0" style="width:95%"/>       
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUncommonSevere0" name="cbUncommonSevere0"/>              
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUncommonAllCases0" name="cbUncommonAllCases0"/>           
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUncommonStoptaking0" name="cbUncommonStoptaking0"/>                
        </div>     
         <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveUncommon(0)" width="58" height="40" />                                                          
        </div>  
    </div>    
    <div id="dvExtraUncommonSymptoms" style="width:90%; padding-left: 0px; clear:both;">
    </div>

    <section style="width:90%; padding-left: 0px; clear:both; padding-top:20px;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; height:50px;">
            Rare
        </div>
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddRareSymptomsTextBox()" id="btnAddExtrRareSymptoms" width="58" height="40" />                                                          
        </div>  
    </section>
        
    <div id="Rare0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">
            <input type="text" id="tbRareFrequency0" name="tbRareFrequency0" style="width:95%"/>
        </div>  
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">      
            <input type="text" id="tbRareSymptom0" name="tbRareSymptom0" style="width:95%"/>       
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbRareSevere0" name="cbRareSevere0"/>              
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbRareAllCases0" name="cbRareAllCases0"/>           
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbRareStoptaking0" name="cbRareStoptaking0"/>                
        </div>     
         <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveRare(0)" width="58" height="40" />                                                          
        </div>  
    </div>    
    <div id="dvExtraRareSymptoms" style="width:90%; padding-left: 0px; clear:both;">
    </div>

    <section style="width:90%; padding-left: 0px; clear:both; padding-top:20px;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; height:50px;">
            Very Rare
        </div>
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddVeryRareSymptomsTextBox()" id="btnAddExtrVeryRareSymptoms" width="58" height="40" />                                                          
        </div>  
    </section>
        
    <div id="VeryRare0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">
            <input type="text" id="tbVeryRareFrequency0" name="tbVeryRareFrequency0" style="width:95%"/>
        </div>  
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">      
            <input type="text" id="tbVeryRareSymptom0" name="tbVeryRareSymptom0" style="width:95%"/>       
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbVeryRareSevere0" name="cbVeryRareSevere0"/>              
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbVeryRareAllCases0" name="cbVeryRareAllCases0"/>           
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbVeryRareStoptaking0" name="cbVeryRareStoptaking0"/>                
        </div>     
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveVeryRare(0)" width="58" height="40" />                                                          
        </div>  
    </div>    
    <div id="dvExtraVeryRareSymptoms" style="width:90%; padding-left: 0px; clear:both;">
    </div>

    <section style="width:90%; padding-left: 0px; clear:both; padding-top:4px;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; height:50px;">
            Unkown
        </div>
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; height:50px">
             &nbsp;
        </div>
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddUnknownSymptomsTextBox()" id="btnAddExtrUnkownSymptoms" width="58" height="40" />                                                          
        </div>  
    </section>
        
    <div id="Unknown0" style="width:90%; padding-left: 0px; clear:both;">
        <div style="width:12.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">
            <input type="text" id="tbUnknownFrequency0" name="tbUnknownFrequency0" style="width:95%"/>
        </div>  
        <div style="width:25.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; height:50px;">      
            <input type="text" id="tbUnknownSymptom0" name="tbUnknownSymptom0" style="width:95%"/>       
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUnknownSevere0" name="cbUnknownSevere0"/>              
        </div>
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUnknownAllCases0" name="cbUnknownAllCases0"/>           
        </div> 
        <div style="width:15.75%; float:left; border: 1px solid #D9D9D9; padding:4px 4px 4px 4px; text-align:center; height:50px;">
            <input type="checkbox" id="cbUnknownStoptaking0" name="cbUnknownStoptaking0"/>                
        </div>  
        <div style="width:5%; float:left;">
            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveUnknown(0)" width="58" height="40" />                                                          
        </div>  
    </div>    
    <div id="dvExtraUnknownSymptoms" style="width:90%; padding-left: 0px; clear:both;">
    </div>

    <section style="width:100%; padding-left: 0px; padding-bottom: 10px; clear:both;">        
        <asp:Label ID="Label4" runat="server">*This is not a complete list of side effects.  For any unexpected effects while taking &nbsp;
            <asp:Label ID="lblBrandNameTbl" runat="server">BRAND NAME</asp:Label>
            , contact your doctor or pharmacist.</asp:Label>
    </section>    
</details>

<details style="clear:both; padding-top: 20px;">
    <summary>HOW TO STORE IT</summary>  
    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px; padding-bottom:20px;">
        <div style="text-align:left;">                        
            <textarea id="tbHowToStore" name="tbHowToStore" runat="server" class="textarea"></textarea>                            
        </div>
    </div> 
</details>

<details style="clear:both; padding-top: 20px;">
    <summary>REPORTING SUSPECTED SIDE EFFECTS</summary>     
    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px; padding-bottom:20px;">
        <div style="text-align:left;">                        
            <textarea id="tbReportingSuspectedSE" name="tbReportingSuspectedSE" runat="server" class="textarea"></textarea>                            
        </div>
    </div>     
</details>

<details style="clear:both; padding-top: 20px;">
    <summary>MORE INFORMATION</summary> 
    <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
        <div style="text-align:left;">                        
            <textarea id="tbMoreInformation" name="tbMoreInformation" runat="server" class="textarea"></textarea>                            
        </div>
    </div>     
    <div style="clear:both; padding-left: 0px; padding-top:20px;">
        Last revised:&nbsp;
        <asp:TextBox runat="server" ID="tbLastrRevised" Width="250" ReadOnly="true"></asp:TextBox>
            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbLastrRevised" Format="yyyy-MM-dd" />
    </div>
</details>

<div style="clear:both; padding-top:20px;">
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

<asp:HiddenField runat="server" ID="hdUnknownSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdVeryRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdCommonSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdUncommonSymptoms" ClientIDMode="Static" />
</asp:Content>
