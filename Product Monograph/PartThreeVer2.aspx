<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartThreeVer2.aspx.cs" Inherits="Product_Monograph.PartThreeVer2" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
           
           if (counter > 1) {

               var div = document.createElement('DIV');
               var att = document.createAttribute("class");
               var identity = document.createAttribute("id");
               att.value = "roadynarow";
               identity.value = "MedicationForItems" + counter;
               div.setAttributeNode(att);
               div.setAttributeNode(identity);
               //div.innerHTML = GetAddMedicationForItemsTextBoxDynamicTextBox(counter);
               document.getElementById("dvExtraMedicationForItems").appendChild(div);

               //setup();

               $("#dvExtraMedicationForItems div[id='MedicationForItems1'] div").each(function () {
                   $("#dvExtraMedicationForItems div[id='MedicationForItems" + counter + "']").append(AddDynamicHeaderColumn(counter + 5));
               });

               var columncount = $("#dvExtraMedicationForItems div[id='MedicationForItems1'] div").length; 
               var wd;
               if (columncount == 1)
               { wd = "100%"; }
               if (columncount == 2)
               { wd = "50%"; }
               if (columncount == 3)
               { wd = "33.3%"; }
               if (columncount == 4)
               { wd = "25%"; }
               if (columncount == 5)
               { wd = "20%"; }
               if (columncount == 6)
               { wd = "16.6%"; }
               if (columncount == 7)
               { wd = "14.2%"; }
               if (columncount == 8)
               { wd = "12.5%"; }
               if (columncount == 9)
               { wd = "11.1%"; }
               if (columncount == 10)
               { wd = "10%"; }
               if (columncount == 11)
               { wd = "9%"; }
               if (columncount == 12)
               { wd = "8.3%"; }
               if (columncount == 13)
               { wd = "7.6%"; }
               if (columncount == 14)
               { wd = "7.1%"; }
               if (columncount == 15)
               { wd = "6.6%"; }
               if (columncount == 16)
               { wd = "6.2%"; }
               if (columncount == 17)
               { wd = "5.8%"; }
               if (columncount == 18)
               { wd = "5.5%"; }
               if (columncount == 19)
               { wd = "5.2%"; }
               if (columncount == 20)
               { wd = "5%"; }
               if (columncount == 21)
               { wd = "4.7%"; }
               if (columncount == 22)
               { wd = "4.5%"; }
               if (columncount == 23)
               { wd = "4.3%"; }
               if (columncount == 24)
               { wd = "4.1%"; }
               if (columncount == 25)
               { wd = "4%"; }
               if (columncount == 26)
               { wd = "3.8%"; }
               if (columncount == 27)
               { wd = "3.7%"; }
               if (columncount == 28)
               { wd = "3.6%"; }
               if (columncount == 29)
               { wd = "3.4%"; }
               if (columncount == 30)
               { wd = "3.3%"; }

               $("#dvExtraMedicationForItems div[id='MedicationForItems" + counter + "'] div").each(function () {
                   $(this).css("width", wd);
               });
           }
           else
           {
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
       }

       function GetAddMedicationForItemsTextBoxDynamicTextBox(id) {
           var swp = "tbMedicationForItems" + id.toString();
           return "<div name='colcount' style='float:left; width:100%'>" + 
                        "<textarea id='" + swp + "' name='tbMedicationForItems' style='width:100%'></textarea>" + 
                  "</div>";
                  //"<div style='width:5%; float:left;'>" +
                  //     '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveMedicationForItemsTextBox(' + id + ')" width="58" height="40" />' +
                  //"</div>";
       }

       function RemoveSeriousWarningsPrecautionsTextBox(i) {
           var rowid = "#SeriousWarningsPrecautions" + i;
           $(rowid).remove();
       }

       var PartThreeOuterSection = 0;

       function AddPartThreeOuterSection() {

           PartThreeOuterSection = PartThreeOuterSection + 1;
           counter = PartThreeOuterSection;

           var div = document.createElement('DIV');
           var att = document.createAttribute("class");
           var identity = document.createAttribute("id");
           att.value = "roadynarow";
           identity.value = "PartThreeOuter" + counter;
           div.setAttributeNode(att);
           div.setAttributeNode(identity);
           div.innerHTML = GetAddPartThreeOuterSectionDynamicSection(counter);
           document.getElementById("dvExtraPartThreeOuter").appendChild(div);

           setup();
       }

       function GetAddPartThreeOuterSectionDynamicSection(id) {
           var med = "tbMedicationForText" + id.toString();
           var medD = "tbMedicationDoes" + id.toString();
           var medNU = "tbMedicationNotUsed" + id.toString();

           return '<details style="clear:both; padding-top: 10px;">' +
                        '<summary>' + id + '</summary>' +
                        '<details style="clear:both; padding-top: 10px;">'+
                                '<summary>ABOUT THIS MEDICATION</summary>' +     
                                '<div style="padding-left: 0px; clear:both; padding-top:20px;">' +
                                    'WHAT THE MEDICATION IS USED FOR:'+
                                '</div>' +
                                '<div style="width:84.5%; text-align:center; clear:both; padding-left:0px; padding-top:4px;">' +
                                   '<div style="text-align:left;">' +
                                        "<textarea id='" + med + "' name='tbMedicationForText' class='textarea'></textarea>" +
                                    '</div>' +
                                '</div>' +

                                '<div style="padding-left: 0px; clear:both; padding-top:20px;">' +
                                    'WHAT IT DOES:' +
                                '</div>' +

                                '<div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">' +
                                    '<div style="text-align:left;">' +                        
                                        '<textarea id="' + medD + '" name="tbMedicationDoes" class="textarea"></textarea>' +
                                    '</div>' +
                                '</div>' +         

                                '<div style="padding-left: 0px; clear:both; padding-top:20px;">' +
                                    'WHEN IT SHOULD NOT BE USED:' +
                                '</div>' +

                                '<div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">' +
                                    '<div style="text-align:left;">' +                        
                                        '<textarea id="' + medNU  + '" name="tbMedicationNotUsed" class="textarea"></textarea>' +
                                    '</div>' +
                                '</div>' +   
                        '</details>' +
                  '</details>';
           
                        
                




                  //"<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbSeriousWarningsPrecautions' class='textarea'></textarea></div>" +
                  //"<div style='width:5%; float:left;'>" +
                  //     '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" width="58" height="40" />' +
                  //"</div>";
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

       var pharmacolumn = 0;
       function AddPharmacokineticsColumn() {
           pharmacolumn = pharmacolumn + 1;
           
           //var hdiv = document.createElement('DIV');
           //var hstyling = document.createAttribute("style");
           //hstyling.value = "width:50%; float:left; border: 1px solid #D9D9D9;";
           //hdiv.setAttributeNode(hstyling);
           //hdiv.innerHTML = AddDynamicHeaderColumn(pharmacolumn);
           //document.getElementById("headerdiv").appendChild(hdiv);

           $("div[id^='MedicationForItems']").each(function () {
               $(this).append(AddDynamicHeaderColumn(pharmacolumn));
           });

           //document.getElementById("dvExtraMedicationForItems").appendChild(hdiv);           

           //var bdiv = document.createElement('DIV');
           //var bstyling = document.createAttribute("style");
           //bstyling.value = "width:50%; float:left; border: 1px solid #D9D9D9;";
           //bdiv.setAttributeNode(bstyling);
           //bdiv.innerHTML = AddDynamicBodyColumn(pharmacolumn);
           //document.getElementById("bodydiv").appendChild(bdiv);

           var columncount = $("#dvExtraMedicationForItems div[id='MedicationForItems1'] div").length; //$("#headerdiv > div").length; //[id^='MedicationForItems'] 
           var wd;
           if (columncount == 2)
           { wd = "50%"; }
           if (columncount == 3)
           { wd = "33.3%"; }
           if (columncount == 4)
           { wd = "25%"; }
           if (columncount == 5)
           { wd = "20%"; }
           if (columncount == 6)
           { wd = "16.6%"; }
           if (columncount == 7)
           { wd = "14.2%"; }
           if (columncount == 8)
           { wd = "12.5%"; }
           if (columncount == 9)
           { wd = "11.1%"; }
           if (columncount == 10)
           { wd = "10%"; }
           if (columncount == 11)
           { wd = "9%"; }
           if (columncount == 12)
           { wd = "8.3%"; }
           if (columncount == 13)
           { wd = "7.6%"; }
           if (columncount == 14)
           { wd = "7.1%"; }
           if (columncount == 15)
           { wd = "6.6%"; }
           if (columncount == 16)
           { wd = "6.2%"; }
           if (columncount == 17)
           { wd = "5.8%"; }
           if (columncount == 18)
           { wd = "5.5%"; }
           if (columncount == 19)
           { wd = "5.2%"; }
           if (columncount == 20)
           { wd = "5%"; }
           if (columncount == 21)
           { wd = "4.7%"; }
           if (columncount == 22)
           { wd = "4.5%"; }
           if (columncount == 23)
           { wd = "4.3%"; }
           if (columncount == 24)
           { wd = "4.1%"; }
           if (columncount == 25)
           { wd = "4%"; }
           if (columncount == 26)
           { wd = "3.8%"; }
           if (columncount == 27)
           { wd = "3.7%"; }
           if (columncount == 28)
           { wd = "3.6%"; }
           if (columncount == 29)
           { wd = "3.4%"; }
           if (columncount == 30)
           { wd = "3.3%"; }

           $("#dvExtraMedicationForItems div[id^='MedicationForItems'] div").each(function () {
               $(this).css("width", wd);
           });
           //$("#dvExtraMedicationForItems div[id='MedicationForItems2'] div").each(function () {
           //    $(this).css("width", wd);
           //});
           //$("#dvExtraMedicationForItems div[id='MedicationForItems3'] div").each(function () {
           //    $(this).css("width", wd);
           //});
           //$("#bodydiv > div").each(function () {
           //    $(this).css("width", wd);
           //});

           setup();
       }

       function AddDynamicHeaderColumn(id) {
           return "<div name='colcount' style='float:left;'>" +
                        "<textarea id='" + id + "' name='tbMedicationForItems' style='width:100%'></textarea>" +
                  "</div>";

           //'<input type="text" id="tbHeadTwoPharmacokinetics' + id + '" name="tbHeadTwoPharmacokinetics" style="width:95%; text-align:center; font-weight:bold;"/>';
       }

       function AddDynamicBodyColumn(id) {
           return '<textarea id="tbBodyTwoPharmacokinetics' + id + '" name="tbBodyTwoPharmacokinetics"></textarea>';
       }
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

<div style="width:90%; padding-left: 0px; clear:both; padding-top: 10px; padding-bottom:4px;">
    <div style="width:80%; float:left; clear:both;">
        &nbsp;
    </div>     
    <div style="width:7%; float:left;">
        <img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddMedicationForItemsTextBox()" id="btnAddPartThreeRow" width="58" height="40" />                                                          
    </div>   
    <div style="width:7%; float:left;">
        <img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddPharmacokineticsColumn()" id="btnAddPartThreeColumn" width="58" height="40" />                                                          
    </div>       
</div>

<div id="dvExtraMedicationForItems" style="clear:both; width:100%">
</div> 

<div id="dvExtraPartThreeOuter" style="clear:both; width:100%">
</div>  

 <div id='headerdiv' style='width:100%; text-align:center; clear:both; padding-top: 10px;'>

 </div>
 <div id="bodydiv" style="width:100%; text-align:center; clear:both; padding-top: 10px;">
 </div>

</asp:Content>
