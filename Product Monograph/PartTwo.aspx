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
                            '<input class="btn btn-default btn-xs" onclick="AddClinicalTrialsInnerTextBox(' + id + ')" type="button" value="Add" />' +
                               // '<img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddClinicalTrialsInnerTextBox(' + id + ')" width="58" height="40" />' +
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
                '<input class="btn btn-default btn-xs" onclick="RemoveClinicalTrialsOuterSection(' + id + ')" id="btnRemoveClinicalTrialsOuterSection(' + id + ')" type="button" value="Remove" />' +
                    // '<img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveClinicalTrialsOuterSection(' + id + ')" width="58" height="40" />' + 
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
                          '<input class="btn btn-default btn-xs" id="btnRemoveClinicalTrialsInnerTextBox(' + innerid + ')" onclick="RemoveClinicalTrialsInnerTextBox(' + innerid + ')" type="button" value="Remove" />' +
                          //  '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveClinicalTrialsInnerTextBox(' + innerid + ')" width="58" height="40" />' +
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
        styling.value = "border:1px solid #D9D9D9; margin-bottom:20px; width:90%; clear:both;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
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

        return "<div style='width:94%; text-align:center; padding-left: 0px; float:left;'>" +
                   "<div style='text-align:left;'>" +
                       //"<textarea id='" + tbSciInfoProperName + "' name='tbSciInfoProperName'></textarea>" +
                         '<input type="text" id="' + tbSciInfoProperName + '" name="tbSciInfoProperName" style="border:0px; height:27px;" readonly="true"/>' +
                   "</div>" +
               "</div>" +
               "<div style='width:5%; float:left; margin-left: -8px;'>" +
               '<input class="tbn btn-default btn-xs" onclick="RemoveDrugSubstanceTextBox(' + id + ')" id="btnRemoveDrugSubstanceTextBox(' + id + ')" type="button" value="Remove"/>' +
                    //'<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveDrugSubstanceTextBox(' + id + ')" width="58" height="40" />' +
                "</div>" +
               "<div style='width:94%; text-align:center; clear:both; padding-left: 0px;'>" +
                   "<div style='text-align:left;'>" +
                       "<div style='padding: 20px 4px 4px 0px'>Chemical name</div>" +
                       "<textarea id='" + tbSciInfoChemicalname + "' name='tbSciInfoChemicalname'></textarea>" +
                   "</div>" +
               "</div>" +
               "<div style='width:94%; text-align:center; clear:both; padding-left: 0px;'>" +
                    "<div style='text-align:left;'>" +
                        "<div style='padding: 20px 4px 4px 0px'>Molecular formula</div>" +
                        "<textarea id='" + tbSciInfoMolecularformula + "' name='tbSciInfoMolecularformula'></textarea>" +
                    "</div>" +
                "</div>" +
                "<div style='width:94%; text-align:center; clear:both; padding-left: 0px;'>" +
                    "<div style='text-align:left;'>" +
                        "<div style='padding: 20px 4px 4px 0px'>Molecular mass</div>" +
                        "<textarea id='" + tbSciInfoMolecularmass + "' name='tbSciInfoMolecularmass'></textarea>" +
                    "</div>" +
                "</div>" +
                "<div style='width:94%; clear:both; padding-left: 0px;'>" +
                    "<div class='symbolbrand' style='width:500px;'>" +
                        "<div style='padding: 20px 4px 0px 0px; float:left;'>Structural formula</div>" +
                        '<div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file"  id=' + fustrucform + ' style="width:400px;" onchange="loadFile(\'' + fustrucform + '\',\'' + fuimage + '\',\'' + tbfuimagename + '\',\'' + tbfuimagebasesixtyfour + '\')"/></div>' +
                        "<div style='clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;'>" +
                            "<img  id='" + fuimage + "' src='images/x.png'/>" +
                            "<input type='text' id='" + tbfuimagename + "' name='tbfuimagename' style='display:none;' />" +
                            "<input type='text' id='" + tbfuimagebasesixtyfour + "' name='tbfuimagebasesixtyfour' style='display:none;' />" +
                        "</div>" +
                    "</div>" +
                "</div>" +
                "<div style='width:94%; text-align:center; clear:both; padding-left: 0px;'>" +
                    "<div style='text-align:left;'>" +
                        "<div style='padding: 20px 4px 4px 0px'>Physicochemical properties</div>" +
                            "<textarea id='" + tbPhysicochemicalproperties + "' name='tbPhysicochemicalproperties'></textarea>" +
                    "</div>" +
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
                        '<input class="btn btn-defaul;t btn-xs" id="btnRemoveAnalyteNameTextBox(' + id + ')" onclick="RemoveAnalyteNameTextBox(' + id + ')" type="button" value="Remove" />' +
                           // '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveAnalyteNameTextBox(' + id + ')" width="58" height="40" />' +
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

<div style="clear:both; padding-top: 10px;">
    <asp:Menu ClientIDMode="Static" ID="submenutabs" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick">
        <StaticMenuStyle VerticalPadding="5px" />
        <StaticMenuItemStyle HorizontalPadding="25px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage" toolTip="Cover Page"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne" toolTip="Part I"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo" toolTip="Part II"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree" toolTip="Part III"></asp:MenuItem>
            <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
        </Items>
    </asp:Menu>
</div>

<section style="clear:both; text-align:left; padding-left:0px; padding-top: 8px;">
    <asp:Button class="btn btn-default" ID="btnSave" runat="server" Text="Save draft" OnClick="btnSave_Click" />
</section>

<div style="float:left; padding:10px 10px 10px 0px; clear:both;">
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>

<section style="width:100%; padding-left: 0px; clear:both;">
    <h4 style="border: 0px !important;"><asp:Label ID="Label2" runat="server">Part II:  Science Information</asp:Label></h4>
</section>

<details style="clear:both;">
     <summary id="SUM_PHARMACEUTICAL" lang="en">Pharmaceutical information</summary>  
    
    <div style="padding-left: 0px; padding-top:20px; clear:both; width:91%;">    
            <div style="width:93%; float:left; clear:both;">
                <h4 id="DRUG" lang="en">Drug substance</h4>
            </div>  
            <div style="width:5%; float:left; margin-left: -8px;">
                     <input type="button" value="Add" onclick="AddDrugSubstanceTextBox()" id="btnAddDrugSubstance" class="btn btn-default btn-xs" />
         
             <!--   <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddDrugSubstanceTextBox()" id="btnAddDrugSubstance" width="58" height="40" /> -->                                                         
            </div>   
    </div>

    <div id="DrugSubstance0" style="border:1px solid #D9D9D9; margin-bottom:20px; width:90%; clear:both;">
    
        <div style="width:94%; text-align:center; padding-left: 0px; float:left;">
            <div style="text-align:left;">          
                <input type="text" id="tbSciInfoProperName0" name="tbSciInfoProperName" style="border:0px; height:27px;" readonly="true"/>
            </div>
        </div>
        <div style="width:5%; float:left; margin-left: -8px;">
               <input type="button" value="Remove" onclick="RemoveDrugSubstanceTextBox(0)" id="btnRemoveDrugSubstanceTextBox" class="btn btn-default btn-xs" />
     
           <!-- <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveDrugSubstanceTextBox(0)" width="58" height="40" /> -->                                                         
        </div>  

        <div style="width:94%; text-align:center; clear:both; padding-left: 0px;">
            <div style="text-align:left;">          
                <div style="padding: 20px 4px 4px 0px">Chemical name</div>                    
                    <textarea id="tbSciInfoChemicalname0" name="tbSciInfoChemicalname"></textarea>                                 
            </div>
        </div>

        <div style="width:94%; text-align:center; clear:both; padding-left: 0px;">
            <div style="text-align:left;">          
                <div style="padding: 20px 4px 4px 0px">Molecular formula</div>       
                    <textarea id="tbSciInfoMolecularformula0" name="tbSciInfoMolecularformula"></textarea>                                     
            </div>
        </div> 
        
        <div style="width:94%; text-align:center; clear:both; padding-left: 0px;">
            <div style="text-align:left;">          
                <div style="padding: 20px 4px 4px 0px">Molecular mass</div>       
                    <textarea id="tbSciInfoMolecularmass0" name="tbSciInfoMolecularmass"></textarea>                                     
            </div>
        </div>       

        <div style="width:94%; clear:both; padding-left: 0px;">
            <div class="symbolbrand" style="width:500px;">
                <div style="padding: 20px 4px 0px 0px; float:left;">Structural formula</div>
                <div style="clear:both; width:100%; padding: 4px 4px 4px 0px;"><input type="file" id="fustrucform0" style="width:400px;" onchange="loadFile('fustrucform0','fuimage0','tbfuimagename0','tbfuimagebasesixtyfour0')"/></div>            
                <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
                    <img id="fuimage0" src="images/x.png" width="100" height="100" />
                    <input type="text" id="tbfuimagename0" name="tbfuimagename" style="display:none;" />
                    <input type="text" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour" style="display:none;" />
                </div>                      
            </div>
        </div>

        <div style="width:94%; text-align:center; clear:both; padding-left: 0px;">
            <div style="text-align:left;">          
                <div style="padding: 20px 4px 4px 0px">Physicochemical properties</div>      
                    <textarea id="tbPhysicochemicalproperties0" name="tbPhysicochemicalproperties"></textarea>                                                 
            </div>
        </div>

    </div>

    <div id="dvExtraDrugSubstance" style="width:100%">
        </div>
</details>

<details style="clear:both; padding-top: 20px;">
      <summary id="SUM_CLINICAL_TRIALS" lang="en">Clinical trials</summary>

    <div style="width:84.5%; text-align:center; clear:both;; padding-left: 0px; text-align:left;">
        <div style="padding: 4px 4px 4px 0px"><label id="lblClinical" lang="en">Clinical trials</label></div>                         
        <textarea id="tbClinicalTrialsOverview" name="tbClinicalTrialsOverview" runat="server"></textarea>                            
    </div>

    <div style="width:46%; float:left; padding: 25px 0px 0px 0px;">
        <input type="text" id="tbSelectedClinicalTrials" style="width: 500px; height:40px;"/>
    </div>     
    <div style="width:5%; float:left; padding: 25px 0px 0px 0px;">
      <input type="button" value="Add" onclick="AddClinicalTrialsOuterSection()" id="btnAddClinicalTrialsOuterSection" class="btn btn-default btn-xs" />
   
        <!--<img style="cursor:pointer !important;" src="images/btnAdd.png" onclick="AddClinicalTrialsOuterSection()" id="" width="58" height="40" /> -->                                                         
    </div> 

    <div id="dvExtraClinicalTrialsOuter" style="clear:both; width:100%">
    </div>  


    <div style="padding-left: 0px; padding-top:20px; clear:both; width:90%; display:none">    
        <div style="width:93%; float:left; clear:both;">
               <h4 id="Comparative" lang="en">Comparative bioavailability studies</h4>
        </div>  
        <div style="width:5%; float:left; margin-left: -14px;">
               <input type="button" value="Add" onclick="AddAnalyteNameTextBox()" id="btnAddAnalyteName" class="btn btn-default btn-xs" />
       
           <!-- <img style="cursor:pointer !important;" src="images/btnAdd.png"  onclick="AddAnalyteNameTextBox()" id="btnAddAnalyteName" width="58" height="40" />-->                                                          
        </div>   
    </div>

    <div id="AnalyteName0" style="display:none">
        <div style="padding-left: 0px; padding-top:0px; clear:both;">
              <label id="lblAnalyteName" lang="en">Analyte name</label>
        </div> 
        <div style="width:90%; padding-left: 0px; clear:both;">
            <div style="width:94.5%; float:left; clear:both;">
                <div style="height:40px; float:left; font-size:xx-large">(</div>
                <div style="height:40px; width:90px; float:left; padding-top:6px;">
                    <input type="number" id="tbAnalyteMultiplicand0" name="tbAnalyteMultiplicand" style="width:100%; text-align:center;"/>
                </div>
                <div style="height:40px; float:left; font-size:xx-large">&nbsp;&nbsp;X</div>
                <div style="height:40px; width:90px; float:left; padding-top:6px;">
                    <input type="number" id="tbAnalyteMultiplier0" name="tbAnalyteMultiplier" style="width:100%; text-align:center;"/>
                </div>
                <div style="height:40px; float:left; font-size:xx-large">&nbsp;mg)</div>
            </div>
            <div style="width:5%; float:left; margin-left: -14px;">
                      <input type="button" value="Remove" onclick="RemoveAnalyteNameTextBox(0)" id="RemoveAnalyteNameTextBox" class="btn btn-default btn-xs" />
         
              <!--  <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveAnalyteNameTextBox(0)" width="58" height="40" /> -->                                                         
            </div>  
        </div>
        <section style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:50px;">
                 <label id="lblParameter" lang="en">Parameter</label>
            </div>
            <div style="width:17%; float:left; border: 1px solid #D9D9D9; height:50px">
                 <label id="lblTest" lang="en">Test</label>*
            </div>
            <div style="width:17%; float:left; border: 1px solid #D9D9D9; height:50px">
                 <label id="lblReference" lang="en">Reference</label>
            </div>
            <div style="width:29%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblRatio" lang="en">% Ratio of geometric means</label>
            </div>
            <div style="width:23%; float:left; border: 1px solid #D9D9D9; height:50px">
               <label id="lblConfidence" lang="en">Confidence interval #</label>
            </div>   
        </section>
        <div style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:118px;">
                AUCT +-(units) 
            </div>  
            <div style="width:17%; float:left;">
                <textarea id="tbAUCTTest0" name="tbAUCTTest"></textarea>                
            </div> 
            <div style="width:17%; float:left;">
                <textarea id="tbAUCTReference0" name="tbAUCTReference"></textarea>                
            </div>
            <div style="width:29%; float:left;">
                <textarea id="tbAUCTPercentRatio0" name="tbAUCTPercentRatio"></textarea>                
            </div> 
            <div style="width:23%; float:left; padding-right:2px;">
                <textarea id="tbAUCTConfidenceInterval0" name="tbAUCTConfidenceInterval"></textarea>                
            </div>    
        </div>
        <div style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:118px;">
                AUCI (units)
            </div>  
            <div style="width:17%; float:left;">
                <textarea id="tbAUCITest0" name="tbAUCITest"></textarea>                
            </div> 
            <div style="width:17%; float:left;">
                <textarea id="tbAUCIReference0" name="tbAUCIReference"></textarea>                
            </div>
            <div style="width:29%; float:left;">
                <textarea id="tbAUCIPercentRatio0" name="tbAUCIPercentRatio"></textarea>                
            </div> 
            <div style="width:23%; float:left;">
                <textarea id="tbAUCIConfidenceInterval0" name="tbAUCIConfidenceInterval"></textarea>                
            </div>     
        </div>
        <div style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:118px;">
                CMAX (units)
            </div>  
            <div style="width:17%; float:left;">
                <textarea id="tbCMAXTest0" name="tbCMAXTest"></textarea>                
            </div> 
            <div style="width:17%; float:left;">
                <textarea id="tbCMAXReference0" name="tbCMAXReference"></textarea>                
            </div>
            <div style="width:29%; float:left;">
                <textarea id="tbCMAXPercentRatio0" name="tbCMAXPercentRatio"></textarea>                
            </div> 
            <div style="width:23%; float:left;">
                <textarea id="tbCMAXConfidenceInterval0" name="tbCMAXConfidenceInterval"></textarea>                
            </div>     
        </div>
        <div style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:118px;">
                TMAX (h)
            </div>  
            <div style="width:17%; float:left;">
                <textarea id="tbTMAXTest0" name="tbTMAXTest"></textarea>                
            </div> 
            <div style="width:17%; float:left;">
                <textarea id="tbTMAXReference0" name="tbTMAXReference"></textarea>                
            </div>
            <div style="width:29%; float:left;">
                <textarea id="tbTMAXPercentRatio0" name="tbTMAXPercentRatio"></textarea>                
            </div> 
            <div style="width:23%; float:left;">
                <textarea id="tbTMAXConfidenceInterval0" name="tbTMAXConfidenceInterval"></textarea>                
            </div>     
        </div>
        <div style="width:91%; padding-left: 0px; clear:both;">
            <div style="width:13%; float:left; border: 1px solid #D9D9D9; height:118px;">
                T1/2 (h)
            </div>  
            <div style="width:17%; float:left;">
                <textarea id="tbTHalfTest0" name="tbTHalfTest"></textarea>                
            </div> 
            <div style="width:17%; float:left;">
                <textarea id="tbTHalfReference0" name="tbTHalfReference"></textarea>                
            </div>
            <div style="width:29%; float:left;">
                <textarea id="tbTHalfPercentRatio0" name="tbTHalfPercentRatio"></textarea>                
            </div> 
            <div style="width:23%; float:left;">
                <textarea id="tbTHalfConfidenceInterval0" name="tbTHalfConfidenceInterval"></textarea>                
            </div>   
        </div>
    </div>
    
    <div id="dvExtraAnalyteName" style="display:none">
    </div>

    <div style="clear:both; padding-left: 0px; display:none">*	Identity of the test product.</div>
    <div style="clear:both; padding-left: 0px; display:none">†	Identity of the reference product, including the manufacturer, and origin (country of purchase).</div>
    <div style="clear:both; padding-left: 0px; display:none">‡	For drugs with a half-life greater than 24 hours AUCT should be replaced with AUC0-72.</div>
    <div style="clear:both; padding-left: 0px; display:none">§	Expressed as either the arithmetic mean (CV%) or the median (range) only.</div>
    <div style="clear:both; padding-left: 0px; display:none">[]	Expressed as the arithmetic mean (CV%) only.</div>
    <div style="clear:both; padding-left: 0px; display:none">#	Indicate % Confidence Interval (i.e., 90% or 95%) in the column heading and list for the AUCT, AUCI and CMAX (if required).</div>
</details>

<details style="clear:both; padding-top: 20px;">
<summary id="SUM_DETAILED" lang="en">Detailed pharmacology</summary>
    <div style="width:90%; text-align:center; clear:both; padding-left: 0px;">
        <div style="text-align:left;">  
            <div style="padding: 20px 4px 4px 0px"><label id="lblDetailed" lang="en">Detailed pharmacolory</label></div>                         
            <textarea id="tbDetailedPharma" name="tbClinicalTrials" runat="server"></textarea>                            
        </div>
    </div>
</details>

<details style="clear:both; padding-top: 20px;">
    <summary id="SUM_MICROBIOLOGY" lang="en">Microbiology</summary>      
    <div style="width:90%; text-align:center; clear:both; padding-left: 0px;">
        <div style="text-align:left;">  
            <div style="padding: 20px 4px 4px 0px"><label id="lblMicrobiology" lang="en">Microbiology</label></div>                         
            <textarea id="tbMicrobiology" name="tbMicrobiology" runat="server"></textarea>                            
        </div>
    </div>
</details>

<details style="clear:both; padding-top: 20px;">
   <summary id="SUM_TOXICOLOGY" lang="en">Toxicology</summary>
    <div style="width:90%; text-align:center; clear:both; padding-left: 0px;">
        <div style="text-align:left;">  
            <div style="padding: 20px 4px 4px 0px"><label id="lblToxicology" lang="en">Toxicology</label></div>                         
            <textarea id="tbToxicology" name="tbToxicology" runat="server"></textarea>                            
        </div>
    </div>
</details>

<details style="clear:both; padding-top: 20px;">
    <summary id="SUM_REFERENCES" lang="en">References</summary>
    <div style="width:90%; text-align:center; clear:both; padding-left: 0px;">
        <div style="text-align:left;">  
            <div style="padding: 20px 4px 4px 0px"><label id="lblReferences" lang="en">References</label></div>                         
            <textarea id="tbReferences" name="tbReferences" runat="server"></textarea>                            
        </div>
    </div>
</details>

<section>
    <asp:Menu ClientIDMode="Static" ID="submenutabsbottom" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle VerticalPadding="5px" />
        <StaticMenuItemStyle HorizontalPadding="25px" />
        <Items>
            <asp:MenuItem Text="Cover page" Value="Coverpage"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree"></asp:MenuItem>
            <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
        </Items>
    </asp:Menu>
</section>
<asp:HiddenField runat="server" ID="hdAnalyteName" ClientIDMode="Static" />
</asp:Content>

