<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartTwo.aspx.cs" Inherits="Product_Monograph.PartTwo" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<!--Health Canada- PMP--> 
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

    tinymce.init({
        selector: "textarea",
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
            selector: "textarea",
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

    var ClinicalTrialsOuterSection = 0;

    function RemoveClinicalTrialsOuterSection(i) {
        var rowid = "#ClinicalTrialsOuter" + i;
        $(rowid).remove();
    }

    function AddClinicalTrialsOuterSection() {

        ClinicalTrialsOuterSection = ClinicalTrialsOuterSection + 1;
        counter = ClinicalTrialsOuterSection;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "ClinicalTrialsOuter" + counter;
        styling.value = "width:100%;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddClinicalTrialsOuterSection(counter);
        document.getElementById("dvExtraClinicalTrialsOuter").appendChild(div);

        setup();

        $("#lblSelectedHeaderClinicalTrials" + counter).val($('#tbSelectedClinicalTrials').val());
    }

    function GetAddClinicalTrialsOuterSection(id) {
      
        var fuClinicalTrials = "fuClinicalTrials" + id.toString();
        var fuimageClinicalTrials = "fuimageClinicalTrials" + id.toString();
        var tbfuimagenameClinicalTrials = "tbfuimagenameClinicalTrials" + id.toString();
        var tbfuimagebasesixtyfourClinicalTrials = "tbfuimagebasesixtyfourClinicalTrials" + id.toString();

        return '<div style="width:90%; padding-left: 0px; border:1px solid #D9D9D9; height:auto; margin-top:10px; float:left;">' +
                    '<div style="width:40%; float:left; clear:both; margin:4px;">' +
                        '<input type="text" id="lblSelectedHeaderClinicalTrials' + id + '" name="lblSelectedHeaderClinicalTrials" style="width:95%; border:0px; height:27px;" readonly="true"/>' +
                        '<input type="text" id="lblSelectedHeaderCountClinicalTrials' + id + '" name="lblSelectedHeaderCountClinicalTrials" value="' + id + '" style="display:none;"/>' +
                    '</div>' +

                    '<div style="width:100%; text-align:center; clear:both; text-align:left; border: 1px solid #D9D9D9;">' +
                        "<textarea id='tbSelectedHeaderClinicalTrials" + id + "' name='tbSelectedHeaderClinicalTrials'></textarea>" +
                    '</div>' +
                    '<div style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">' +
           
                        "<div style='width:90%; text-align:center; float:left; border: 1px solid #D9D9D9;'>" +
                            "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumberClinicalTrials" + id + "' name='nmTableNumberClinicalTrials' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableTextClinicalTrials" + id + "' name='tbTableTextClinicalTrials' style='width:55px; text-align:center;'/>&nbsp;>" +
                        "</div>" +

                        '<div style="width:5%; float:left;">' +
                            '<div style="float:left;">' +
                                '<img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddClinicalTrialsInnerTextBox(' + id + ')" width="58" height="40" />' +
                            '</div>' +
                        '</div>' +
                    '</div>' + 

                    '<div id="dvExtraClinicalTrialsInner' + id + '" style="width:100%; padding-left: 0px; clear:both;">' +
                    '</div>' +

                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbSelectedHeaderDescClinicalTrials' + id + '" name="tbSelectedHeaderDescClinicalTrials"></textarea>' +
                    '</div>' +

                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<input type="text" id="tbSelectedImageCaptionClinicalTrials' + id + '" name="tbSelectedImageCaptionClinicalTrials" style="width:95%; height:27px;" />' +
                    '</div>' +

                    "<div style='width:100%; clear:both; padding-left: 0px;'>" +
                        "<div class='symbolbrand' style='width:500px;'>" +                            
                            '<div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file"  id=' + fuClinicalTrials + ' style="width:400px;" onchange="loadFile(\'' + fuClinicalTrials + '\',\'' + fuimageClinicalTrials + '\',\'' + tbfuimagenameClinicalTrials + '\',\'' + tbfuimagebasesixtyfourClinicalTrials + '\')"/></div>' +
                            "<div style='clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;'>" +
                                "<img  id='" + fuimageClinicalTrials + "' src='images/x.png'/>" +
                                "<input type='text' id='" + tbfuimagenameClinicalTrials + "' name='tbfuimagenameClinicalTrials' style='display:none;' />" +
                                "<input type='text' id='" + tbfuimagebasesixtyfourClinicalTrials + "' name='tbfuimagebasesixtyfourClinicalTrials' style='display:none;' />" +
                            "</div>" +
                        "</div>" +
                    "</div>" +

                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbSelectedFooterDescClinicalTrials' + id + '" name="tbSelectedFooterDescClinicalTrials"></textarea>' +
                    '</div>' +

                '</div>' +
                '<div style="width:5%; float:left; margin-top:10px;">' +
                    '<img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveClinicalTrialsOuterSection(' + id + ')" width="58" height="40" />' +
                '</div>';

    }

    var ClinicalTrialsInnerCounter = 0;

    function RemoveClinicalTrialsInnerTextBox(i) {
        var rowid = "#ClinicalTrialsInner" + i;
        $(rowid).remove();
    }

    function AddClinicalTrialsInnerTextBox(id) {
       
        ClinicalTrialsInnerCounter = ClinicalTrialsInnerCounter + 1;
        counter = ClinicalTrialsInnerCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "ClinicalTrialsInner" + counter;
        styling.value = "padding-top:6px;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddClinicalTrialsInnerTextBoxDynamicTextBox(counter, id);
        document.getElementById("dvExtraClinicalTrialsInner" + id).appendChild(div);

        setup();
    }

    function GetAddClinicalTrialsInnerTextBoxDynamicTextBox(innerid, outerid) {
     
        return '<div style="width:90%; float:left;">' +
                   
                    "<div style='width:100%; text-align:center; clear:both; text-align:center;'>" +
                        "<div style='width:50%; float:left; border: 1px solid #D9D9D9;'>" +
                           '<input type="text" id="tbHeadOneClinicalTrials' + outerid + "_" + innerid + '" name="tbHeadOneClinicalTrials' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<input type="text" id="tbHeadTwoClinicalTrials' + outerid + "_" + innerid + '" name="tbHeadTwoClinicalTrials' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyOneClinicalTrials' + outerid + "_" + innerid + '" name="tbBodyOneClinicalTrials' + outerid + '"></textarea>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyTwoClinicalTrials' + outerid + "_" + innerid + '" name="tbBodyTwoClinicalTrials' + outerid + '"></textarea>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbNarrativeClinicalTrials' + outerid + "_" + innerid + '" name="tbNarrativeClinicalTrials' + outerid + '"></textarea>' +
                    "</div>" +
                '</div>' +
                '<div style="width:5%; float:left; padding-top:6px;">' +
                    '<div style="height:70px; width:70px;">' +
                        '<div style="float:left;">' +
                            '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveClinicalTrialsInnerTextBox(' + innerid + ')" width="58" height="40" />' +
                        '</div>' +
                    '</div>' +
                '</div>';
    }




    function RemoveDrugSubstanceTextBox(i) {
        var rowid = "#DrugSubstance" + i;
        $(rowid).remove();
    }

    var DrugSubstanceCounter = 0;

    var lblpropername;

    function AddDrugSubstanceTextBox() {

        DrugSubstanceCounter = DrugSubstanceCounter + 1;
        counter = DrugSubstanceCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "DrugSubstance" + counter;
        //styling.value = "border:1px solid #D9D9D9; margin-bottom:20px; width:90%; clear:both;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        //div.setAttributeNode(styling);
        div.innerHTML = GetDrugSubstanceDynamicTextBox(counter);
        document.getElementById("dvExtraDrugSubstance").appendChild(div);

        $('#tbSciInfoProperName' + counter).val(lblpropername);

        setup();

    }

    function GetDrugSubstanceDynamicTextBox(id) {
        var tbSciInfoProperName = "tbSciInfoProperName" + id.toString();
        var tbSciInfoChemicalname = "tbSciInfoChemicalname" + id.toString();
        var tbSciInfoMolecularformula = "tbSciInfoMolecularformula" + id.toString();
        var tbSciInfoMolecularmass = "tbSciInfoMolecularmass" + id.toString();
        var fustrucform = "fustrucform" + id.toString();
        var fuimage = "fuimage" + id.toString();
        var tbfuimagename = "tbfuimagename" + id.toString();
        var tbfuimagebasesixtyfour = "tbfuimagebasesixtyfour" + id.toString();
        var tbPhysicochemicalproperties = "tbPhysicochemicalproperties" + id.toString();

        return "<div class='brdr-bttm brdr-tp brdr-lft brdr-rght margin-top-large'>" +
                    "<div class='row'>"+
                       "<div class='col-xs-10 text-left'>" +
                           //"<textarea id='" + tbSciInfoProperName + "' name='tbSciInfoProperName'></textarea>" +
                             '<input type="text" id="' + tbSciInfoProperName + '" name="tbSciInfoProperName" readonly="readonly"/>' +
                       "</div>" +
                       "<div class='col-xs-2 pull-right'>" +
                            '<img class="pull-right" style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveDrugSubstanceTextBox(' + id + ')" width="58" height="40" />' +
                        "</div>" +
                    "</div>" +
                    "<div class='form-group'>" +                       
                             "<div class='margin-top-medium'>" +
                                     "<label for='" + tbSciInfoChemicalname + "'>Chemical name<label>" +
                             "</div>" +
                             "<div class='row'>" +
                                 "<div class='col-xs-10 text-left'>" +                                
                                    "<textarea id='" + tbSciInfoChemicalname + "' title='Chemical name' name='tbSciInfoChemicalname'></textarea>" +
                                 "</div>" +
                             "</div>"+
                    "</div>"+
                    "<div class='form-group'>" +
                            "<div class='margin-top-medium'>" +
                                    "<label for='" + tbSciInfoMolecularformula + "'>Molecular formula<label>" +
                             "</div>" +
                             "<div class='row'>" +
                                 "<div class='col-xs-10 text-left'>" +
                                     "<textarea id='" + tbSciInfoMolecularformula + "' title='Molecular formula' name='tbSciInfoMolecularformula'></textarea>" +
                                 "</div>" +
                            "</div>" +
                     "</div>" +
                    "<div class='form-group'>" +
                            "<div class='margin-top-medium'>" +
                                     "<label for='" + tbSciInfoMolecularmass + "'>Molecular mass<label>" +
                             "</div>" +
                             "<div class='row'>" +
                                 "<div class='col-xs-10 text-left'>" +
                                     "<textarea id='" + tbSciInfoMolecularmass + "' title='Molecular mass' name='tbSciInfoMolecularmass'></textarea>" +
                                "</div>" +
                            "</div>" +
                     "</div>" +
                   "<div class='form-group'>" +
                     "<div class='row margin-top-medium margin-bottom-medium mrgn-lft-sm'>"+
                        "<div class='col-xs-10 symbolbrand'>"+
                            '<input type="file"  id=' + fustrucform + ' style="width:400px;" onchange="loadFile(\'' + fustrucform + '\',\'' + fuimage + '\',\'' + tbfuimagename + '\',\'' + tbfuimagebasesixtyfour + '\')"/>' +
                        "</div>" +
                        "<div style='clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;'>" +
                            "<img  id='" + fuimage + "' src='images/x.png'/>" +
                            "<input type='text' id='" + tbfuimagename + "' name='tbfuimagename' style='display:none;' />" +
                            "<input type='text' id='" + tbfuimagebasesixtyfour + "' name='tbfuimagebasesixtyfour' style='display:none;' />" +
                        "</div>" +
                    "</div>" +
                "</div>" +
                 "<div class='form-group'>" +
                     "<div class='margin-top-medium'>" +
                            "<label for='" + tbPhysicochemicalproperties + "'>Physicochemical properties<label>" +
                     "</div>" +
                     "<div class='row'>"+
                          "<div class='col-xs-10 text-left'>"+
                                "<textarea id='" + tbPhysicochemicalproperties + "' title='Physico chemical properties' name='tbPhysicochemicalproperties'></textarea>" +
                          "</div>" +
                     "</div>" +
                "</div>"+
           "</div>";
                
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
        

            return  "<div style='padding-left: 0px; padding-top:20px; clear:both;'>" +
                        "Analyte Name" +
                    "</div>" +
                    "<div style='width:90%; padding-left: 0px; clear:both;'>" +
                        "<div style='width:94.5%; float:left; clear:both;'>" +
                            "<div style='height:40px; float:left; font-size:xx-large'>(</div>" +
                            "<div style='height:40px; width:90px; float:left; padding-top:6px;'>" +
                                "<input type='number' id='" + AnalyteMultiplicand + "' name='tbAnalyteMultiplicand' style='width:100%; text-align:center;'/>" +
                            "</div>" +
                            "<div style='height:40px; float:left; font-size:xx-large'>&nbsp;&nbsp;X</div>" +
                            "<div style='height:40px; width:90px; float:left; padding-top:6px;'>" +
                                "<input type='number' id='" + AnalyteMultiplier + "' name='tbAnalyteMultiplier' style='width:100%; text-align:center;'/>" +
                            "</div>" +
                            "<div style='height:40px; float:left; font-size:xx-large'>&nbsp;mg)</div>" +
                        "</div>" +     
                        "<div style='width:5%; float:left; margin-left: -14px;'>" +
                            '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveAnalyteNameTextBox(' + id + ')" width="58" height="40" />' +
                        "</div>" +  
                    "</div>" +                    

                    "<section style='width:91%; padding-left: 0px; clear:both; padding-top:0px;'>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:50px;'>" +
                            "Parameter" +
                        "</div>" +
                        "<div style='width:17%; float:left; border: 1px solid #D9D9D9; height:50px'>" +
                            "Test*" +
                        "</div>" +
                        "<div style='width:17%; float:left; border: 1px solid #D9D9D9; height:50px'>" +
                            "Reference" +
                        "</div>" +
                        "<div style='width:29%; float:left; border: 1px solid #D9D9D9; height:50px'>" +
                            "% Ratio of Geometric Means" +
                        "</div>" +
                        "<div style='width:23%; float:left; border: 1px solid #D9D9D9; height:50px'>" +
                            "Confidence Interval #" +
                        "</div>   " +
                    "</section>" +

                   "<div style='width:91%; padding-left: 0px; clear:both; '>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
                           "AUCT +-(units)" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + AUCTTest + "' name='tbAUCTTest'></textarea>" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + AUCTRefe + "' name='tbAUCTReference'></textarea>" +
                        "</div>" +
                        "<div style='width:29%; float:left;'>" +
                             "<textarea id='" + AUCTPerc + "' name='tbAUCTPercentRatio'></textarea>" +
                        "</div>" +
                        "<div style='width:23%; float:left;'>" +
                             "<textarea id='" + AUCTConf + "' name='tbAUCTConfidenceInterval'></textarea>" +
                        "</div>" +
                    "</div>" +
                                          
                    
                    "<div style='width:91%; padding-left: 0px; clear:both; '>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
                           "AUCI (units)" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + AUCITest + "' name='tbAUCITest'></textarea>" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + AUCIRefe + "' name='tbAUCIReference'></textarea>" +
                        "</div>" +
                        "<div style='width:29%; float:left;'>" +
                             "<textarea id='" + AUCIPerc + "' name='tbAUCIPercentRatio'></textarea>" +
                        "</div>" +
                        "<div style='width:23%; float:left;'>" +
                             "<textarea id='" + AUCIConf + "' name='tbAUCIConfidenceInterval'></textarea>" +
                        "</div>" +
                    "</div>" + 
                    
                    "<div style='width:91%; padding-left: 0px; clear:both; '>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
                           "CMAX (units)" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + CMAXTest + "' name='tbCMAXTest'></textarea>" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + CMAXRefe + "' name='tbCMAXReference'></textarea>" +
                        "</div>" +
                        "<div style='width:29%; float:left;'>" +
                             "<textarea id='" + CMAXPerc + "' name='tbCMAXPercentRatio'></textarea>" +
                        "</div>" +
                        "<div style='width:23%; float:left;'>" +
                             "<textarea id='" + CMAXConf + "' name='tbCMAXConfidenceInterval'></textarea>" +
                        "</div>" +
                    "</div>" +

                    "<div style='width:91%; padding-left: 0px; clear:both; '>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
                           "TMAX (h)" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + TMAXTest + "' name='tbTMAXTest'></textarea>" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + TMAXRefe + "' name='tbTMAXReference'></textarea>" +
                        "</div>" +
                        "<div style='width:29%; float:left;'>" +
                             "<textarea id='" + TMAXPerc + "' name='tbTMAXPercentRatio'></textarea>" +
                        "</div>" +
                        "<div style='width:23%; float:left;'>" +
                             "<textarea id='" + TMAXConf + "' name='tbTMAXConfidenceInterval'></textarea>" +
                        "</div>" +
                    "</div>" +

                    "<div style='width:91%; padding-left: 0px; clear:both; '>" +
                        "<div style='width:13%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
                           "T1/2 (h)" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + THalfTest + "' name='tbTHalfTest'></textarea>" +
                        "</div>" +
                        "<div style='width:17%; float:left;'>" +
                             "<textarea id='" + THalfRefe + "' name='tbTHalfReference'></textarea>" +
                        "</div>" +
                        "<div style='width:29%; float:left;'>" +
                             "<textarea id='" + THalfPerc + "' name='tbTHalfPercentRatio'></textarea>" +
                        "</div>" +
                        "<div style='width:23%; float:left;'>" +
                             "<textarea id='" + THalfConf + "' name='tbTHalfConfidenceInterval'></textarea>" +
                        "</div>" +
                    "</div>";

    }
   

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
    <asp:Menu ClientIDMode="Static" ID="submenutabs" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
            <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
        </Items>
    </asp:Menu>
</div>

<div class="mrgn-tp-md">
    <asp:Button ID="btnSave" class=" btn btn-primary" runat="server" Text="Save draft" OnClick="btnSave_Click" />
</div>

<div>
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>

<div><h2 id="PartII" ><asp:Label ID="lblPartII" runat="server"></asp:Label></h2></div>

<details class="margin-top-medium">
    <summary><asp:Label ID="lblSumPharmInfo" runat="server"></asp:Label></summary>
    <div class="form-group">
        <div class="row text-left">
            <div class="col-xs-10">
                <h4><asp:Label ID="lblDrugSub" runat="server"></asp:Label></h4>
            </div>
            <div class="col-xs-2 mrgn-tp-md">
                <img class="pull-right" style="cursor: pointer !important;" src="images/btnAdd.png" onclick="AddDrugSubstanceTextBox()" id="btnAddDrugSubstance" width="58" height="40" />
            </div>
        </div>

        <div id="DrugSubstance0" class="brdr-bttm brdr-tp brdr-lft brdr-rght">
            <div class="row">
                <div class="col-xs-10 text-left">
                    <input type="text" id="tbSciInfoProperName0" name="tbSciInfoProperName" readonly="readonly" />
                </div>
                <div class="col-xs-2 pull-right">
                    <img class="pull-right" style="cursor: pointer !important;" src="images/btnRemove.png" onclick="RemoveDrugSubstanceTextBox(0)" width="58" height="40" />
                </div>
            </div>

            <div class="form-group">
                <div class="margin-top-medium">
                    <asp:Label AssociatedControlID="tbSciInfoChemicalname0" ID="lblChemicalname" CssClass="control-label" runat="server"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-xs-10 text-left">
                        <textarea id="tbSciInfoChemicalname0" name="tbSciInfoChemicalname" class="textarea form-control" runat="server"></textarea>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="margin-top-medium">
                    <asp:Label AssociatedControlID="tbSciInfoMolecularformula0" ID="lblMolecularformula" CssClass="control-label" runat="server"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-xs-10 text-left">
                        <textarea id="tbSciInfoMolecularformula0" name="tbSciInfoMolecularformula" class="textarea form-control" runat="server"></textarea>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="margin-top-medium">
                    <asp:Label AssociatedControlID="tbSciInfoMolecularmass0" ID="lblMolecularmass" CssClass="control-label" runat="server"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-xs-10 text-left">
                        <textarea id="tbSciInfoMolecularmass0" name="tbSciInfoMolecularmass" class="textarea form-control" runat="server"></textarea>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="margin-top-medium">
                    <asp:Label AssociatedControlID="fustrucform0" ID="lblStructuraform" CssClass="control-label" runat="server"></asp:Label>
                </div>
                <div class="row margin-top-medium margin-bottom-medium mrgn-lft-sm">
                    <div class="col-xs-10 symbolbrand">
                        <div>
                            <input type="file" id="fustrucform0" runat="server" onchange="loadFile('fustrucform0','fuimage0','tbfuimagename0','tbfuimagebasesixtyfour0')" />
                        </div>
                        <div class="margin-top-medium" style="border: 1px solid #D9D9D9; width: 103px; height: 103px;">
                            <img id="fuimage0" src="images/x.png" />
                            <input type="text" id="tbfuimagename0" name="tbfuimagename" class="hidden" />
                            <input type="text" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour" class="hidden" />
                        </div>
                    </div>
               </div>
            </div>
                <div class="form-group">
                    <div class="margin-top-medium">
                        <asp:Label AssociatedControlID="tbPhysicochemicalproperties0" ID="lblPhysicochemicalproperties" CssClass="control-label" runat="server"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="col-xs-10 text-left">
                            <textarea id="tbPhysicochemicalproperties0" name="tbPhysicochemicalproperties" class="textarea form-control" runat="server"></textarea>
                        </div>
                    </div>
                </div>         
            </div>

        <div id="dvExtraDrugSubstance"></div>
    </div>
</details>

<details class="margin-top-medium">
    <summary><asp:Label ID="lblSumCT" runat="server"></asp:Label></summary>

    <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label ID="lblClinicalTrials" AssociatedControlID="tbClinicalTrialsOverview" CssClass="control-label" runat="server"></asp:Label>
            </div>
             <div class="row margin-top-medium">   
                 <div class="col-xs-10 text-left">                               
                    <textarea id="tbClinicalTrialsOverview" name="tbClinicalTrialsOverview" runat="server"></textarea>
                 </div>
             </div>                            
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-sm-4">
                <label for="tbSelectedClinicalTrials" class="control-label hidden">Selected clinical trials</label>
                <input type="text" id="tbSelectedClinicalTritextals" class="form-control" />
            </div>
            <div class="col-sm-1">
                <img style="cursor: pointer !important;" src="images/btnAdd.png" onclick="AddClinicalTrialsOuterSection()" id="" width="58" height="40" />
            </div>
        </div>
    </div>
    <div id="dvExtraClinicalTrialsOuter"></div>  

    <div class="form-group">
        <div class="row margin-top-large">
            <div class="col-xs-10 text-left">
                <h4><asp:Label ID="lblBioStudy" runat="server"></asp:Label></h4>
            </div>
            <div class="col-xs-2 mrgn-tp-md">
                <img class="pull-right" style="cursor: pointer !important;" src="images/btnAdd.png" onclick="AddAnalyteNameTextBox()" id="btnAddAnalyteName" width="58" height="40" />
            </div>
        </div>
    
        <section class="panel panel-default" id="AnalyteName0">
            <header class="panel-heading">
                <div class="row text-center"> <asp:Label ID="lblAnalyteName" runat="server"></asp:Label></div>
                <div class="row text-center">                    
                    (            
                <input type="number" id="tbAnalyteMultiplicand0" name="tbAnalyteMultiplicand" />
                    &nbsp;&nbsp;X             
                <input type="number" id="tbAnalyteMultiplier0" name="tbAnalyteMultiplier" />
                    &nbsp;mg)                                 
                <img class="pull-right" style="cursor: pointer !important;" src="images/btnRemove.png" onclick="RemoveAnalyteNameTextBox(0)" width="58" height="40" />
                </div>
            </header>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2 text-right">
                        <asp:Label ID="lblParameter" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-2 brdr-lft">
                        <asp:Label ID="lblTest" runat="server"></asp:Label>*
                    </div>
                    <div class="col-xs-2 brdr-lft">
                         <asp:Label ID="lblReference" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                        % <asp:Label ID="lblRGM" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                        <asp:Label ID="lblConfInter" runat="server"></asp:Label> #
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        AUCT +-(units) 
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCTTest0" name="tbAUCTTest"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCTReference0" name="tbAUCTReference"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCTPercentRatio0" name="tbAUCTPercentRatio"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCTConfidenceInterval0" name="tbAUCTConfidenceInterval"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        AUCI (units)
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">

                        <textarea id="tbAUCITest0" title="AUCI test" name="tbAUCITest"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCIReference0" title="AUCI reference" name="tbAUCIReference"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCIPercentRatio0" title="AUCI percent ratio" name="tbAUCIPercentRatio"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCIConfidenceInterval0" title="AUCI confidence interval" name="tbAUCIConfidenceInterval"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        CMAX (units)
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbCMAXTest0" title="CMAX test" name="tbCMAXTest"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbCMAXReference0" title="CMAX reference" name="tbCMAXReference"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbCMAXPercentRatio0" title="CMAX percent ratio" name="tbCMAXPercentRatio"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbCMAXConfidenceInterval0" title="CMAX confidence interval" name="tbCMAXConfidenceInterval"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        TMAX (h)
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbTMAXTest0" title="TMAX test" name="tbTMAXTest"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbTMAXReference0" title="TMAX reference" name="tbTMAXReference"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbTMAXPercentRatio0" title="TMAX percent ratio" name="tbTMAXPercentRatio"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbTMAXConfidenceInterval0" title="TMAX confidence interval" name="tbTMAXConfidenceInterval"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        T1/2 (h)
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfTest0" title="Half test" name="tbTHalfTest"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfReference0" title="Half reference" name="tbTHalfReference"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfPercentRatio0" title="Half percent ratio" name="tbTHalfPercentRatio"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfConfidenceInterval0" title="Half confidence interval" name="tbTHalfConfidenceInterval"></textarea>
                    </div>
                </div>
            </div>
        </section>
    
    <div id="dvExtraAnalyteName" class="hidden">
    </div>

    <div class="text-left">*	<asp:Label ID="lblNote1" runat="server"></asp:Label></div>
    <div class="text-left">†	<asp:Label ID="lblNote2" runat="server"></asp:Label></div>
    <div class="text-left">‡	<asp:Label ID="lblNote3" runat="server"></asp:Label></div>
    <div class="text-left">§	<asp:Label ID="lblNote4" runat="server"></asp:Label></div>
    <div class="text-left">[]	<asp:Label ID="lblNote5" runat="server"></asp:Label></div>
    <div class="text-left">#	<asp:Label ID="lblNote6" runat="server"></asp:Label></div>
</div>
</details>

<details class="margin-top-medium">
<summary><asp:Label ID="lblSumPharmacology" runat="server"></asp:Label></summary>
     <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label ID="lblDetailedPharma" AssociatedControlID="tbDetailedPharma" CssClass="control-label" runat="server"></asp:Label>
            </div>
             <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                                 
                     <textarea id="tbDetailedPharma" name="tbDetailedPharma" runat="server"></textarea> 
                </div>                           
             </div>
    </div>
</details>

<details class="margin-top-medium">
    <summary><asp:Label ID="lblSumMicrobiology" runat="server"></asp:Label></summary>    
     <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label ID="lblMicrobiology" AssociatedControlID="tbMicrobiology" CssClass="control-label" runat="server"></asp:Label>
            </div>
             <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                     
                    <textarea id="tbMicrobiology" name="tbMicrobiology" runat="server"></textarea> 
                 </div> 
             </div>
    </div>
</details>

<details class="margin-top-medium">
    <summary><asp:Label ID="lblSumToxicology" runat="server"></asp:Label></summary>
    <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label ID="lblToxicology" AssociatedControlID="tbToxicology" CssClass="control-label" runat="server"></asp:Label>
            </div>
             <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                              
                    <textarea id="tbToxicology" name="tbToxicology" runat="server"></textarea> 
                </div>
             </div>                           
     </div>
</details>

<details class="margin-top-medium">
    <summary><asp:Label ID="lblSumRef" runat="server"></asp:Label></summary>
    <div class="form-group">
            <div class="margin-top-medium">
                <asp:Label ID="lblRef" AssociatedControlID="tbReferences" CssClass="control-label" runat="server"></asp:Label>
            </div>
             <div class="row margin-top-medium">
                <div class="col-xs-10 text-left">                         
                    <textarea id="tbReferences" name="tbReferences" runat="server"></textarea>   
                </div>                         
             </div>
    </div>
</details>


<div class="margin-top-large">
    <asp:Menu ClientIDMode="Static" ID="submenutabsbottom" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle VerticalPadding="10px" />
        <StaticMenuItemStyle HorizontalPadding="35px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
            <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
        </Items>
    </asp:Menu>
</div>
<asp:HiddenField runat="server" ID="hdAnalyteName" ClientIDMode="Static" />


</asp:Content>