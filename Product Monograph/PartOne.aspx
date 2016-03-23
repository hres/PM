<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartOne.aspx.cs" Inherits="Product_Monograph.PartOne" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">    
   $(document).ready(function () {
     $("#tooltipINDICATIONS").attr('title', 'Brief discussion of any relevant clinical information - if applicable\nDistribution restrictions - if applicable\nWhen the product is not recommended - if applicable');
     $("#tooltipCONTRAINDICATIONS").attr('title', 'Patients who are hypersensitive to this drug or to any ingredient in the formulation or component of the container. For a complete listing, see the Dosage Forms, Composition and Packaging section of the product monograph. [if applicable]');
     $("#tooltipSeriousWarnings").attr('title', 'Clinically significant or serious life-threatening warnings should be placed in the warning box. Generally not to exceed 20 lines');
     $("#tooltipSeriousWarningsHeadings").attr('title', 'Headings to be included as applicable');
     $("#tooltipDosingConsiderations").attr('title', 'include all situations that may affect dosing of the drug');
     $("#tooltipRecommendedDose").attr('title', 'Include for each indication, route of administration or dosage form');
     $("#tooltipAdverseReaction").attr('title', 'An overview of the ADR information that may affect prescribing decision, it should contain: serious and important ADRs; the most frequent ADRs and ADRs that...');
     $("#tooltipDrugInteraction").attr('title', 'It should include the following information: interactions suspected based on the pharmacokinetic or pharmacologic profile of the drug (forr example, cytochrome P45C)');
     $("#tooltipMechanismOfAction").attr('title', 'For anti-infective products:a brief description of action against micro-organisms');

        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('reaction').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#dladversereactions')
            });
        }).done(function () {
            $('#dladversereactions option').each(function () {
                //this does not work
                if ($(this).html() == 'Select') { $(this).attr('selected', 'selected'); return; }
                $('#tbSelectedAdverseReaction').val("Select");
            });
        });
        $("#tbSelectedAdverseReaction").click(function () {
            $('#tbSelectedAdverseReaction').val("");
        });

       $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('interaction').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#dldruginteractions')
            });
       }).done(function () {
            $('#dldruginteractions option').each(function () {
                //this does not work
                if ($(this).html() == 'Select') { $(this).attr('selected', 'selected'); return; }
                $('#tbSelectedDrugInteraction').val("Select");
            });
        });
        $("#tbSelectedDrugInteraction").click(function () {
            $('#tbSelectedDrugInteraction').val("");
        });


        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('kinetics').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#dlpharmacokinetics')
            });
        }).done(function () {
            $('#dlpharmacokinetics option').each(function () {
                //this does not work
                if ($(this).html() == 'Select') { $(this).attr('selected', 'selected'); return; }
                $('#tbSelectedPharmacokinetics').val("Select");
            });
        });
        $("#tbSelectedPharmacokinetics").click(function () {
            $('#tbSelectedPharmacokinetics').val("");
        });


        //$.get('ControlledList.xml', function (xmlcontolledlist) {
        //    $(xmlcontolledlist).find('warning').each(function () {
        //        var $option = $(this).text();
        //        $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#ddHeadingSelections0')
        //    });
        //});

        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('route').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic0');
            });
        });
        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('dosageform').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbDosageFormDynamic0');
            });
        });
    });

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

    function GetAddRouteOfAdminTextBoxDynamicTextBox(id) {
        var roa = "tbRouteOfAdminDynamic" + id.toString();
        var dfd = "tbDosageFormDynamic" + id.toString();
        var sd = "tbStrengthDynamic" + id.toString();
        var crn = "tbClinicallyRelevantNonmedicinalIngredientsDynamic" + id.toString();
        
        return "<div style='width:23.5%; float:left;'><select id='" + roa + "' name='tbRouteOfAdminDynamic' style='width:100%; height:38px;'></select></div>" +
               "<div style='width:23.5%; float:left;'><select id='" + dfd + "' name='tbDosageFormDynamic' style='width:100%; height:38px;'></select></div>" +
               "<div style='width:23.5%; float:left;'><textarea id='" + sd + "' name='tbStrengthDynamic'></textarea></div>" +
               "<div style='width:23.5%; float:left;'><textarea id='" + crn + "' name='tbClinicallyRelevantNonmedicinalIngredientsDynamic'></textarea></div>" +
               "<div style='width:5%; float:left; padding-left:0px;'>" +
                  '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveRouteOfAdminTextBox(' + id + ')" id="btnRemoveRouteOfAdminTextBox(' + id + ')" />' +
               "</div>";
    }

    function GetAddContraindicationsTextBoxDynamicTextBox(id) {
        var con = "tbContraindicationsDynamic" + id.toString();
        return "<div style='width:94%; float:left;'><textarea id='" + con + "' name='tbContraindicationsDynamic'></textarea></div>" +
               "<div style='width:5%; float:left;'>" +
                  '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveContraindicationsTextBox(' + id + ')" id="btnRemoveContraindicationsTextBox(' + id + ')" />' +
               "</div>";
    }

    var RouteOfAdminCounter = 0;
    var ContraindicationsCounter = 0;
    var SeriousWarningsPrecautionsCounter = 0;
    var HeadingSelectionsCounter = 0;
    var CTADrugReactionsCounter = 0;
    var SeriousDrugInteractionsCounter = 0;
    var DrugDrugInteractionsCounter = 0;
    var DrugInteractionsCounter = 0;
    var DosingConsiderationsCounter = 0;
    var ParenteralProductsCounter = 0;
    var PharmacokineticParametersCounter = 0;
    var PharmacokineticsCounter = 0;

    //AddPharmacokineticsOuterSection
    var PharmacokineticsOuterSection = 0;

    function RemovePharmacokineticsOuterSection(i) {
        var rowid = "#PharmacokineticsOuter" + i;
        $(rowid).remove();
    }

    function AddPharmacokineticsOuterSection() {
      
        PharmacokineticsOuterSection = PharmacokineticsOuterSection + 1;
        counter = PharmacokineticsOuterSection;
      
        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "PharmacokineticsOuter" + counter;
        styling.value = "width:100%;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddPharmacokineticsOuterSection(counter);
        document.getElementById("dvExtraPharmacokineticsOuter").appendChild(div);

        setup();

        $("#lblSelectedHeaderPharmacokinetics" + counter).val($('#tbSelectedPharmacokinetics').val());
    }

    function GetAddPharmacokineticsOuterSection(id) {
        return '<div style="width:90%; padding-left: 0px; border:1px solid #D9D9D9; height:auto; margin-top:10px; float:left;">' +
                    '<div style="width:40%; float:left; clear:both; margin:4px;">' +
                        '<input type="text" id="lblSelectedHeaderPharmacokinetics' + id + '" name="lblSelectedHeaderPharmacokinetics" style="width:95%; border:0px; height:27px;" readonly="true"/>' +
                        '<input type="text" id="lblSelectedHeaderCountPharmacokinetics' + id + '" name="lblSelectedHeaderCountPharmacokinetics" value="' + id + '" style="display:none;"/>' +
                    '</div>' +

                    '<div style="width:100%; text-align:center; clear:both; text-align:left; border: 1px solid #D9D9D9;">' +
                        "<textarea id='tbSelectedHeaderPharmacokinetics" + id + "' name='tbSelectedHeaderPharmacokinetics'></textarea>" +
                    '</div>' +
                    '<div style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">' +
                       
                        "<div style='width:90%; text-align:center; float:left; border: 1px solid #D9D9D9;'>" +
                            "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumberPharmacokinetics" + id + "' name='nmTableNumberPharmacokinetics' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableTextPharmacokinetics" + id + "' name='tbTableTextPharmacokinetics' style='width:55px; text-align:center;'/>&nbsp;>" +
                        "</div>" +

                        '<div style="width:initial; float:left;">' +
                            '<div style="float:left;">' +
                                  '<input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddPharmacokineticsInnerTextBox(' + id + ')" id="btnAddPharmacokineticsInnerTextBox(' + id + ')" />' +
                            '</div>' +
                        '</div>' +
                    '</div>' +                   

                    '<div id="dvExtraPharmacokineticsInner' + id + '" style="width:100%; padding-left: 0px; clear:both;">' +
                    '</div>' +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbSelectedHeaderDescPharmacokinetics' + id + '" name="tbSelectedHeaderDescPharmacokinetics"></textarea>' +
                    '</div>' +
                '</div>' +
                '<div style="width:5%; float:left; margin-top:10px;">' +
                        '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemovePharmacokineticsOuterSection(' + id + ')" id="btnRemovePharmacokineticsOuterSection(' + id + ')" />' +
                        '</div>';

    }

    var PharmacokineticsInnerCounter = 0;

    function RemovePharmacokineticsInnerTextBox(i) {
        var rowid = "#PharmacokineticsInner" + i;
        $(rowid).remove();
    }

    function AddPharmacokineticsInnerTextBox(id) {
       
        PharmacokineticsInnerCounter = PharmacokineticsInnerCounter + 1;
        counter = PharmacokineticsInnerCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "PharmacokineticsInner" + counter;
        styling.value = "padding-top:6px;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddPharmacokineticsInnerTextBoxDynamicTextBox(counter, id);
        document.getElementById("dvExtraPharmacokineticsInner" + id).appendChild(div);

        setup();
    }

    function GetAddPharmacokineticsInnerTextBoxDynamicTextBox(innerid, outerid) {

        return '<div style="width:90%; float:left;">' +                   
                    "<div id='headerdiv' style='width:100%; text-align:center; clear:both; text-align:center;'>" +
                        "<div style='width:50%; float:left; border: 1px solid #D9D9D9;'>" +
                           '<input type="text" id="tbHeadOnePharmacokinetics' + outerid + "_" + innerid + '" name="tbHeadOnePharmacokinetics' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<input type="text" id="tbHeadTwoPharmacokinetics' + outerid + "_" + innerid + '" name="tbHeadTwoPharmacokinetics' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                    "</div>" +
                    '<div id="bodydiv" style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyOnePharmacokinetics' + outerid + "_" + innerid + '" name="tbBodyOnePharmacokinetics' + outerid + '"></textarea>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyTwoPharmacokinetics' + outerid + "_" + innerid + '" name="tbBodyTwoPharmacokinetics' + outerid + '"></textarea>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbNarrativePharmacokinetics' + outerid + "_" + innerid + '" name="tbNarrativePharmacokinetics' + outerid + '"></textarea>' +
                    "</div>" +
                '</div>' +
                '<div style="width:5%; float:left; padding-top:6px;">' +
                    '<div style="height:70px; width:70px;">' +
                        '<div style="float:left;">' +
                            '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemovePharmacokineticsInnerTextBox(' + innerid + ')" id="btnRemovePharmacokineticsInnerTextBox(' + innerid + ')" />' +
                            '</div>' +
                    '</div>' +
                    '<div style="height:70px; width:70px; display:none;">' +
                        '<div style="float:left;">' +
                             '<input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddPharmacokineticsColumn()()" id="btnAddPharmacokineticsColumn" />' +
                        '</div>' +
                    '</div>' +
                '</div>';
    }

    var pharmacolumn = 0;
    function AddPharmacokineticsColumn()
    {
        pharmacolumn = pharmacolumn + 1;

        var hdiv = document.createElement('DIV');
        var hstyling = document.createAttribute("style");
        hstyling.value = "width:50%; float:left; border: 1px solid #D9D9D9;";
        hdiv.setAttributeNode(hstyling);
        hdiv.innerHTML = AddDynamicHeaderColumn(pharmacolumn);
        document.getElementById("headerdiv").appendChild(hdiv);

        var bdiv = document.createElement('DIV');
        var bstyling = document.createAttribute("style");
        bstyling.value = "width:50%; float:left; border: 1px solid #D9D9D9;";
        bdiv.setAttributeNode(bstyling);
        bdiv.innerHTML = AddDynamicBodyColumn(pharmacolumn);
        document.getElementById("bodydiv").appendChild(bdiv);

        var columncount = $("#headerdiv > div").length;
        var wd;
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

        $("#headerdiv > div").each(function () {
            $(this).css("width", wd);
        });
        $("#bodydiv > div").each(function () {
            $(this).css("width", wd);
        });

        setup();
    }

    function AddDynamicHeaderColumn(id)
    {
        return '<input type="text" id="tbHeadTwoPharmacokinetics' + id + '" name="tbHeadTwoPharmacokinetics" style="width:95%; text-align:center; font-weight:bold;"/>';
    }

    function AddDynamicBodyColumn(id) {
        return '<textarea id="tbBodyTwoPharmacokinetics' + id + '" name="tbBodyTwoPharmacokinetics"></textarea>';
    }

    var DrugInteractionsOuterSection = 0;

    function RemoveDrugInteractionsOuterSection(i) {
        var rowid = "#DrugInteractionsOuter" + i;
        $(rowid).remove();
    }
   
    function AddDrugInteractionsOuterSection()
    {
        DrugInteractionsOuterSection = DrugInteractionsOuterSection + 1;
        counter = DrugInteractionsOuterSection;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "DrugInteractionsOuter" + counter;
        styling.value = "width:100%;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddDrugInteractionsOuterSection(counter);
        document.getElementById("dvExtraDrugInteractionsOuter").appendChild(div);

        setup();
        $("#lblSelectedHeaderDrugInt" + counter).val($('#tbSelectedDrugInteraction').val());
    }

    function GetAddDrugInteractionsOuterSection(id) {
        return '<div style="width:90%; padding-left: 0px; border:1px solid #D9D9D9; height:auto; margin-top:10px; float:left;">' +
                    '<div style="width:40%; float:left; clear:both; margin:4px;">' +
                        '<input type="text" id="lblSelectedHeaderDrugInt' + id + '" name="lblSelectedHeaderDrugInt" style="width:95%; border:0px; height:27px;" readonly="true"/>' +
                        '<input type="text" id="lblSelectedHeaderCountDrugInt' + id + '" name="lblSelectedHeaderCountDrugInt" value="' + id + '" style="display:none;"/>' +
                    '</div>' +
                    //'<div style="width:100%; text-align:center; clear:both; text-align:left; border: 1px solid #D9D9D9;">' +
                    //    "<textarea id='tbSelectedHeaderDrugInt" + id + "' name='tbSelectedHeaderDrugInt'></textarea>" +
                    //'</div>' +
                    '<div style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">' +
                    
                        "<div style='width:90%; text-align:center; float:left; border: 1px solid #D9D9D9;'>" +
                            "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumberDrugInt" + id + "' name='nmTableNumberDrugInt' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableTextDrugInt" + id + "' name='tbTableTextDrugInt' style='width:55px; text-align:center;'/>&nbsp;>" +
                        "</div>" +

                        '<div style="width:5%; float:left;">' +
                            '<div style="float:left;">' +
                                '<input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddDrugInteractionsInnerTextBox(' + id + ')" id="btnAddDrugInteractionsInnerTextBox(' + id + ')" />' +
                               '</div>' +
                        '</div>' +
                    '</div>' +

                    '<div id="dvExtraDrugInteractionsInner' + id + '" style="width:100%; padding-left: 0px; clear:both;">' +
                    '</div>' +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbSelectedHeaderDescDrugInt' + id + '" name="tbSelectedHeaderDescDrugInt"></textarea>' +
                    '</div>' +
                '</div>' +
                '<div style="width:5%; float:left; margin-top:10px;">' +
                            '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDrugInteractionsOuterSection(' + id + ')" id="btnRemoveDrugInteractionsOuterSection(' + id + ')" />' +
                         '</div>';

    }

    var DrugInteractionsInnerCounter = 0;

    function RemoveDrugInteractionsInnerTextBox(i) {
        var rowid = "#DrugInteractionsInner" + i;
        $(rowid).remove();
    }

    function AddDrugInteractionsInnerTextBox(id) {
       
        DrugInteractionsInnerCounter = DrugInteractionsInnerCounter + 1;
        counter = DrugInteractionsInnerCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "DrugInteractionsInner" + counter;
        styling.value = "padding-top:6px;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddDrugInteractionsInnerTextBoxDynamicTextBox(counter, id);
        document.getElementById("dvExtraDrugInteractionsInner" + id).appendChild(div);

        setup();
    }

    function GetAddDrugInteractionsInnerTextBoxDynamicTextBox(innerid, outerid) {
        return '<div style="width:90%; float:left;">' +
                   
                    "<div style='width:100%; text-align:center; clear:both; text-align:center;'>" +
                        "<div style='width:50%; float:left; border: 1px solid #D9D9D9;'>" +
                           '<input type="text" id="tbHeadOneDrugInt' + outerid + "_" + innerid + '" name="tbHeadOneDrugInt' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<input type="text" id="tbHeadTwoDrugInt' + outerid + "_" + innerid + '" name="tbHeadTwoDrugInt' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyOneDrugInt' + outerid + "_" + innerid + '" name="tbBodyOneDrugInt' + outerid + '"></textarea>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyTwoDrugInt' + outerid + "_" + innerid + '" name="tbBodyTwoDrugInt' + outerid + '"></textarea>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbNarrativeDrugInt' + outerid + "_" + innerid + '" name="tbNarrativeDrugInt' + outerid + '"></textarea>' +
                    "</div>" +
                '</div>' +
                '<div style="width:initial; float:left; padding-top:6px;">' +
                    '<div style="height:70px; width:70px;">' +
                        '<div style="float:left;">' +
                           '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDrugInteractionsInnerTextBox(' + innerid + ')" id="btnRemoveDrugInteractionsInnerTextBox(' + innerid + ')" />' +
                           '</div>' +
                    '</div>' +
                '</div>';
    }

    var AdverseReactionsOuterSection = 0;

    function RemoveAdverseReactionsOuterSection(i) {
        var rowid = "#AdverseReactionsOuter" + i;
        $(rowid).remove();
    }

    function AddAdverseReactionsOuterSection()
    {

        AdverseReactionsOuterSection = AdverseReactionsOuterSection + 1;
        counter = AdverseReactionsOuterSection;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "AdverseReactionsOuter" + counter;
        styling.value = "width:100%;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddAdverseReactionsOuterSection(counter);
        document.getElementById("dvExtraAdverseReactionsOuter").appendChild(div);

        setup();

        $("#lblSelectedHeader" + counter).val($('#tbSelectedAdverseReaction').val());        
    }
  
    function GetAddAdverseReactionsOuterSection(id)
    {
        return '<div style="width:90%; padding-left: 0px; border:1px solid #D9D9D9; height:auto; margin-top:10px; float:left;">' +
                    '<div style="width:40%; float:left; clear:both; margin:4px;">' +
                        '<input type="text" id="lblSelectedHeader' + id + '" name="lblSelectedHeader" style="width:95%; border:0px; height:27px;" readonly="true"/>' +
                        '<input type="text" id="lblSelectedHeaderCount' + id + '" name="lblSelectedHeaderCount" value="' + id + '" style="display:none;"/>' +
                    '</div>' +

                    '<div style="width:100%; text-align:center; clear:both; text-align:left; border: 1px solid #D9D9D9;">' +
                        "<textarea id='tbSelectedHeader" + id + "' name='tbSelectedHeader'></textarea>" +
                    '</div>' +
                    '<div style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">' +
                      
                        "<div style='width:90%; text-align:center; float:left; border: 1px solid #D9D9D9;'>" +
                            "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumber" + id + "' name='nmTableNumber' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableText" + id + "' name='tbTableText' style='width:55px; text-align:center;'/>&nbsp;>" +
                        "</div>" +

                        '<div style="width:5%; float:left;">' +
                                       '<div style="float:left;">' +
                                     '<input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddAdverseReactionsInnerTextBox(' + id + ')" id="btnAddAdverseReactionsInnerTextBox(' + id + ')" />' +
                                       '</div>' +
                        '</div>' +
                    '</div>' +

                    //'<div id="AdverseReactionsInner' + id + '" style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">' +                   

                    //    '<div style="width:90%; float:left;">' +
                    //        '<div style="width:100%; text-align:center; clear:both; text-align:center; border: 1px solid #D9D9D9; padding-top:6px;">' +
                    //            'Table&nbsp;<&nbsp;<input type="number" id="nmTableNumber' + id + '" name="nmTableNumber' + id + '" style="width:55px; text-align:center;"/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type="text" id="tbTableText' + id + '" name="tbTableText' + id + '" style="width:55px; text-align:center;"/>&nbsp;>' +
                    //        '</div>' +
                    //        '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                    //            '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                    //               '<input type="text" id="tbHeadOne' + id + '" name="tbHeadOne' + id + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                    //            '</div>' +
                    //            '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                    //                '<input type="text" id="tbHeadTwo' + id + '" name="tbHeadTwo' + id + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                    //            '</div>' +
                    //        '</div>' +
                    //        '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                    //            '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                    //                '<textarea id="tb0BodydOne' + id + '" name="tbBodydOne' + id + '"></textarea>' +
                    //            '</div>' +
                    //            '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +                    
                    //                '<textarea id="tb0BodydTwo' + id + '" name="tbBodydTwo' + id + '"></textarea>' +
                    //            '</div>' +
                    //        '</div>' +
                    //        '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                    //            '<textarea id="tb0Narrative' + id + '" name="tbNarrative' + id + '"></textarea>' +
                    //        '</div>' +    
                    //    '</div>' +

                    //    '<div style="width:5%; float:left; padding-top:6px;">' +
                    //        '<div style="">' +
                    //            '<div style="float:left;">' +
                    //                '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveAdverseReactionsInnerTextBox(' + id + ')" width="58" height="40" />' +
                    //            '</div>' +
                    //        '</div>' +
                    //    '</div>' +
                    //'</div>' +   

                    '<div id="dvExtraAdverseReactionsInner' + id + '" style="width:100%; padding-left: 0px; clear:both;">' +
                    '</div>' +    
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbSelectedHeaderDesc' + id + '" name="tbSelectedHeaderDesc"></textarea>' +
                    '</div>' +
                '</div>' +
                '<div style="width:5%; float:left; margin-top:10px;">' +
                       '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveAdverseReactionsOuterSection(' + id + ')" id="btnRemoveAdverseReactionsOuterSection(' + id + ')" />' +
                    //'<img style="cursor:pointer !important;" src="images/minus_icon.png"  onclick="RemoveAdverseReactionsOuterSection(' + id + ')" width="22" height="22" alt="Remove this row"/>' +
                '</div>';
            
    }

    var AdverseReactionsInnerCounter = 0;

    function RemoveAdverseReactionsInnerTextBox(i) {
        var rowid = "#AdverseReactionsInner" + i;
        $(rowid).remove();
    }

    function AddAdverseReactionsInnerTextBox(id)
    {
        //alert("outer index:" + id + " inner count: " + $("#dvExtraAdverseReactionsInner" + id + " div[id^='AdverseReactionsInner']").length);

        AdverseReactionsInnerCounter = AdverseReactionsInnerCounter + 1;
        counter = AdverseReactionsInnerCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        var styling = document.createAttribute("style");
        att.value = "roadynarow";
        identity.value = "AdverseReactionsInner" + counter;
        styling.value = "padding-top:6px;";
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.setAttributeNode(styling);
        div.innerHTML = GetAddAdverseReactionsInnerTextBoxDynamicTextBox(counter, id);
        document.getElementById("dvExtraAdverseReactionsInner" + id).appendChild(div);

        setup();
    }

    function GetAddAdverseReactionsInnerTextBoxDynamicTextBox(innerid, outerid) {
        //var roa = "tbRouteOfAdminDynamic" + id.toString();
        //var dfd = "tbDosageFormDynamic" + id.toString();
        //var sd = "tbStrengthDynamic" + id.toString();
        //var crn = "tbClinicallyRelevantNonmedicinalIngredientsDynamic" + id.toString();
        
        return '<div style="width:90%; float:left;">' +
                    //"<div style='width:100%; text-align:center; clear:both; text-align:center; border: 1px solid #D9D9D9;'>" +
                    //    "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumber" + outerid + "_" + innerid + "' name='nmTableNumber" + outerid + "' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableText" + outerid + "_" + innerid + "' name='tbTableText" + outerid + "' style='width:55px; text-align:center;'/>&nbsp;>" +
                    //"</div>" +
                    "<div style='width:100%; text-align:center; clear:both; text-align:center;'>" +
                        "<div style='width:50%; float:left; border: 1px solid #D9D9D9;'>" +
                           '<input type="text" id="tbHeadOne' + outerid + "_" + innerid + '" name="tbHeadOne' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<input type="text" id="tbHeadTwo' + outerid + "_" + innerid + '" name="tbHeadTwo' + outerid + '" style="width:95%; text-align:center; font-weight:bold;"/>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyOne' + outerid + "_" + innerid + '" name="tbBodyOne' + outerid + '"></textarea>' +
                        "</div>" +
                        '<div style="width:50%; float:left; border: 1px solid #D9D9D9;">' +
                            '<textarea id="tbBodyTwo' + outerid + "_" + innerid + '" name="tbBodyTwo' + outerid + '"></textarea>' +
                        "</div>" +
                    "</div>" +
                    '<div style="width:100%; text-align:center; clear:both; text-align:center;">' +
                        '<textarea id="tbNarrative' + outerid + "_" + innerid + '" name="tbNarrative' + outerid + '"></textarea>' +
                    "</div>" +
                '</div>' +
                '<div style="width:5%; float:left; padding-top:6px;">' +
                    '<div style="height:70px; width:70px;">' +
                        '<div style="float:left;">' +
                             '<input class="btn btn-default btn-xs" type="Button" value="Remove" onclick="RemoveAdverseReactionsInnerTextBox(' + innerid + ')" id="btnRemoveAdverseReactionsInnerTextBox(' + innerid + ')" />' +
                          //  '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveAdverseReactionsInnerTextBox(' + innerid + ')" width="22" height="22" alt="Remove this row"/>' +
                        '</div>' +
                    '</div>' +
                '</div>';
    }


    function AddRouteOfAdminTextBox() {

        RouteOfAdminCounter = RouteOfAdminCounter + 1;
        counter = RouteOfAdminCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "RouteOfAdmin" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddRouteOfAdminTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraRouteOfAdmin").appendChild(div);
        
        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('route').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic' + counter)
            });
        });
        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('dosageform').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbDosageFormDynamic' + counter)
            });
        });

        setup();
    }

    function AddRouteOfAdminTextBoxLoadFromXML() {

        RouteOfAdminCounter = RouteOfAdminCounter + 1;
        counter = RouteOfAdminCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "RouteOfAdmin" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddRouteOfAdminTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraRouteOfAdmin").appendChild(div);

        //$.get('ControlledList.xml', function (xmlcontolledlist) {
        //    $(xmlcontolledlist).find('route').each(function () {
        //        var $option = $(this).text();
        //        $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic' + counter)
        //    });
        //});
        //$.get('ControlledList.xml', function (xmlcontolledlist) {
        //    $(xmlcontolledlist).find('dosageform').each(function () {
        //        var $option = $(this).text();
        //        $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#tbDosageFormDynamic' + counter)
        //    });
        //});

        setup();
    }

    function AddContraindicationsTextBox()
    {
        ContraindicationsCounter = ContraindicationsCounter + 1;
        counter = ContraindicationsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "Cntrndctns" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddContraindicationsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraContraindications").appendChild(div);

        setup();
    }

    function RemoveRouteOfAdminTextBox(i) {
        var rowid = "#RouteOfAdmin" + i;
        $(rowid).remove();
    }

    function RemoveContraindicationsTextBox(i) {
        var rowid = "#Cntrndctns" + i;
        $(rowid).remove();
    }
    
    function RemoveSeriousWarningsPrecautionsTextBox(i) {
        var rowid = "#SrsWrngPrctns" + i;
        $(rowid).remove();
    }

    function RemoveHeadingSelectionTextBox(i) {
        var rowid = "#HeadingSelections" + i;
        $(rowid).remove();
    }

    function RemoveCTADrugReactionsTextBox(i) {
        var rowid = "#CTADrugReactions" + i;
        $(rowid).remove();
    }

    function RemoveSeriousDrugInteractionsTextBox(i)
    {
        var rowid = "#SrsDrgIntactns" + i;
        $(rowid).remove();
    }

    function RemoveDrugDrugInteractionsTextBox(i) {
        var rowid = "#DrugDrugInt" + i;
        $(rowid).remove();
    }

    function RemoveDrugInteractionsTextBox(i) {
        var rowid = "#DrugInteractions" + i;
        $(rowid).remove();
    }

    function RemoveDosingConsiderationsTextBox(i) {
        var rowid = "#DosingConsiderations" + i;
        $(rowid).remove();
    }

    function RemoveParenteralProductsTextBox(i) {
        var rowid = "#ParenteralProducts" + i;
        $(rowid).remove();
    }

    function RemovePharmacokineticParametersTextBox(i) {
        var rowid = "#PharmacokineticParameters" + i;
        $(rowid).remove();
    }

    function RemovePharmacokineticsTextBox(i) {
        var rowid = "#Pharmacokinetics" + i;
        $(rowid).remove();
    }    
    
    function AddSeriousWarningsPrecautionsTextBox() {

        SeriousWarningsPrecautionsCounter = SeriousWarningsPrecautionsCounter + 1;
        counter = SeriousWarningsPrecautionsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "SrsWrngPrctns" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddSeriousWarningsPrecautionsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraSeriousWarningsPrecautions").appendChild(div);

        setup();
    }

    function GetAddSeriousWarningsPrecautionsTextBoxDynamicTextBox(id) {
        var swp = "tbSeriousWarningsPrecautions" + id.toString();
        return "<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbSeriousWarningsPrecautions'></textarea></div>" +
               "<div style='width:5%; float:left;'>" +
               '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" id="btnRemoveSeriousWarningsPrecautionsTextBox(' + id + ')" />' +
                  //  '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveSeriousWarningsPrecautionsTextBox(' + id + ')" width="22" height="22" alt="Remove" />' +
               "</div>";
    }

    function AddHeadingSelection() {

        HeadingSelectionsCounter = HeadingSelectionsCounter + 1;
        counter = HeadingSelectionsCounter;
        
        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "HeadingSelections" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddHeadingSelectionDynamicSelection(counter);
        document.getElementById("dvExtraHeadingSelection").appendChild(div);
        
        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('warning').each(function () {
                var $option = $(this).text();
                if ($option == "Pregnant Women" || $option == "Nursing Women" || $option == "Pediatrics (x - y years of age)" || $option == "Geriatrics (> x years of age)" || $option == "Monitoring and Laboratory Tests")
                {
                    $('<option label="' + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + $option + '" value="' + $option + '"/>').appendTo('#dlheadingselections' + counter)
                }
                else
                {
                    $('<option label="' + $option + '" value="' + $option + '"/>').appendTo('#dlheadingselections' + counter)
                }
                //$('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#dlheadingselections' + counter)                
            });
        }).done(function () {
            $('#dlheadingselections' + counter + ' option').each(function () {                
                $('#ddHeadingSelections' + counter ).val("Select");
            });
        });
        $('#ddHeadingSelections' + counter).click(function () {
            $('#ddHeadingSelections' + counter).val("");
        });

        setup();
    }

    function AddHeadingSelectionLoadFromXML() {

        HeadingSelectionsCounter = HeadingSelectionsCounter + 1;
        counter = HeadingSelectionsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "HeadingSelections" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddHeadingSelectionDynamicSelection(counter);
        document.getElementById("dvExtraHeadingSelection").appendChild(div);
        
        setup();
    }

    function GetAddHeadingSelectionDynamicSelection(id) {
        var hsdd = "ddHeadingSelections" + id.toString();
        var hstb = "tbddHeadingSelections" + id.toString();
        return "<div style='width:94%; float:left; border:1px solid #D9D9D9; padding: 4px 3px 4px 4px; margin-top:4px;'>" +
                    '<input type="text" list="dlheadingselections' + id + '" id="ddHeadingSelections' + id + '" name="ddHeadingSelections" style="width: 320px; margin-bottom: 5px;"/>' +
                    '<datalist id="dlheadingselections' + id +'"></datalist>' +
                     "<textarea id='" + hstb + "' name='tbddHeadingSelections'></textarea>" +
                "</div>" +
                "<div style='width:5%; float:left;'>" +
                '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveHeadingSelectionTextBox(' + id + ')" id="btnRemoveHeadingSelectionTextBox(' + id + ')" />' +
                   // '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveHeadingSelectionTextBox(' + id + ')" width="22" height="22" alt="Remove" />' +
               "</div>";
    }

    //function AddCTADrugReactions() {

    //    CTADrugReactionsCounter = CTADrugReactionsCounter + 1;
    //    counter = CTADrugReactionsCounter;
        
    //    var div = document.createElement('DIV');
    //    var att = document.createAttribute("class");
    //    var identity = document.createAttribute("id");
    //    att.value = "roadynarow";
    //    identity.value = "CTADrugReactions" + counter;
    //    div.setAttributeNode(att);
    //    div.setAttributeNode(identity);
    //    div.innerHTML = GetCTADrugReactionsDynamicTextBox(counter);
    //    document.getElementById("dvExtraCTADrugReactions").appendChild(div);
        
    //    setup();
    //}

    //function GetCTADrugReactionsDynamicTextBox(id) {
    //    var ctadr = "ddCTADrugReactions" + id.toString();
    //    var drugname = "tbCTADrugReactionsDrugname" + id.toString();
    //    var placebo = "tbCTADrugReactionsPlacebo" + id.toString();
    //    return "<div style='width:31.5%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
    //                "<select id='" + ctadr + "' name='ddCTADrugReactions' style='width: 100%; margin-bottom: 5px;'>" +
    //                    "<option value='Select'>Select</option>" +
    //                    "<option value='Cardiovascular'>Cardiovascular</option>" +
    //                    "<option value='Digestive'>Digestive</option>" +
    //                    "<option value='Gastrointestinal'>Gastrointestinal</option>" +
    //                "</select>" +
    //            "</div>" +
    //            "<div style='width:31.5%; float:left;'>" +
    //                 "<textarea id='" + drugname + "' name='tbCTADrugReactionsDrugname'></textarea>" +
    //            "</div>" +
    //            "<div style='width:31%; float:left;'>" +
    //                 "<textarea id='" + placebo + "' name='tbCTADrugReactionsPlacebo'></textarea>" +
    //            "</div>" + 
    //            "<div style='width:5%; float:left; padding-left:2px;'>" +
    //                '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveCTADrugReactionsTextBox(' + id + ')" width="58" height="40" />' +
    //           "</div>";
    //}

    function AddSeriousDrugInteractionsTextBox() {

        SeriousDrugInteractionsCounter = SeriousDrugInteractionsCounter + 1;
        counter = SeriousDrugInteractionsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "SrsDrgIntactns" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddSeriousDrugInteractionsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraSeriousDrugInteractions").appendChild(div);

        setup();
    }

    function GetAddSeriousDrugInteractionsTextBoxDynamicTextBox(id) {
        var swp = "tbSeriousDrugInteractions" + id.toString();
        return "<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbSeriousDrugInteractions'></textarea></div>" +
               "<div style='width:5%; float:left;'>" +
              '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveSeriousDrugInteractionsTextBox(' + id + ')" id="btnRemoveSeriousDrugInteractionsTextBox(' + id + ')" />' +
                  //  '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveSeriousDrugInteractionsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
               "</div>";
    }
   
    function AddDrugDrugInteractionsTextBox() {

        DrugDrugInteractionsCounter = DrugDrugInteractionsCounter + 1;
        counter = DrugDrugInteractionsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "DrugDrugInt" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddDrugDrugInteractionsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraDrugDrugInteractions").appendChild(div);

        setup();
    }

    function GetAddDrugDrugInteractionsTextBoxDynamicTextBox(id) {
        var prop = "tbPropername" + id.toString();
        var ref = "tbReference" + id.toString();
        var eff = "tbEffect" + id.toString();
        var clin = "tbClinicalcomment" + id.toString();
        return "<div style='width:20%; float:left;'><textarea id='" + prop + "' name='tbPropername'></textarea></div>" +
               "<div style='width:25%; float:left;'><textarea id='" + ref + "' name='tbReference'></textarea></div>" +
               "<div style='width:21%; float:left;'><textarea id='" + eff + "' name='tbEffect'></textarea></div>" +
               "<div style='width:28%; float:left;'><textarea id='" + clin + "' name='tbClinicalcomment'></textarea></div>" +
               "<div style='width:5%; float:left; padding-left:2px;'>" +
               '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDrugDrugInteractionsTextBox(' + id + ')" id="btnRemoveDrugDrugInteractionsTextBox(' + id + ')" />' +
                   // '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveDrugDrugInteractionsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
               "</div>";
    }

    //function AddDrugInteractions() {

    //    DrugInteractionsCounter = DrugInteractionsCounter + 1;
    //    counter = DrugInteractionsCounter;

    //    var div = document.createElement('DIV');
    //    var att = document.createAttribute("class");
    //    var identity = document.createAttribute("id");
    //    att.value = "roadynarow";
    //    identity.value = "DrugInteractions" + counter;
    //    div.setAttributeNode(att);
    //    div.setAttributeNode(identity);
    //    div.innerHTML = GetAddDrugInteractionsDynamicSelection(counter);
    //    document.getElementById("dvExtraDrugInteractions").appendChild(div);

    //    setup();
    //}

    //function GetAddDrugInteractionsDynamicSelection(id) {
    //    var hsdd = "ddDrugInteractions" + id.toString();
    //    var hstb = "tbddDrugInteractions" + id.toString();
    //    return "<div style='width:94%; float:left; border:1px solid #D9D9D9; padding: 4px 4px 4px 4px; margin-top:4px;'>" +
    //                "<select id='" + hsdd + "' name='ddDrugInteractions' style='width: 220px; margin-bottom: 5px;'>" +
    //                    "<option value='Drug-Food Interactions'>Drug-Food Interactions</option>" +
    //                    "<option value='Drug-Herb Interactions'>Drug-Herb Interactions</option>" +
    //                    "<option value='Drug-Laboratory Interactions'>Drug-Laboratory Interactions</option>" +
    //                    "<option value='Drug-Lifestyle Interactions'>Drug-Lifestyle Interactions</option>" +
    //                 "</select>" +
    //                 "<textarea id='" + hstb + "' name='tbddDrugInteractions'></textarea>" +
    //            "</div>" +
    //            "<div style='width:5%; float:left;'>" +
    //                '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemoveDrugInteractionsTextBox(' + id + ')" width="58" height="40" />' +
    //            "</div>";
    //}

    function AddDosingConsiderationsTextBox() {

        DosingConsiderationsCounter = DosingConsiderationsCounter + 1;
        counter = DosingConsiderationsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "DosingConsiderations" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddDosingConsiderationsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraDosingConsiderations").appendChild(div);

        setup();
    }

    function GetAddDosingConsiderationsTextBoxDynamicTextBox(id) {
        var swp = "tbDosingConsiderations" + id.toString();
        return "<div style='width:94%; float:left;'><textarea id='" + swp + "' name='tbDosingConsiderations'></textarea></div>" +
                "<div style='width:5%; float:left;'>" +
              '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDosingConsiderationsTextBox(' + id + ')" id="btnRemoveDosingConsiderationsTextBox(' + id + ')" />' +
                   // '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveDosingConsiderationsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
                "</div>";
    }

    function AddParenteralProductsTextBox() {

        ParenteralProductsCounter = ParenteralProductsCounter + 1;
        counter = ParenteralProductsCounter;

        var div = document.createElement('DIV');
        var att = document.createAttribute("class");
        var identity = document.createAttribute("id");
        att.value = "roadynarow";
        identity.value = "ParenteralProducts" + counter;
        div.setAttributeNode(att);
        div.setAttributeNode(identity);
        div.innerHTML = GetAddParenteralProductsTextBoxDynamicTextBox(counter);
        document.getElementById("dvExtraParenteralProducts").appendChild(div);

        setup();
    }

    function GetAddParenteralProductsTextBoxDynamicTextBox(id) {
        var vs = "tbVialSize" + id.toString();
        var vd = "tbVolumeOfDiluent" + id.toString();
        var aa = "tbApproxAvailable" + id.toString();
        var nc = "tbNominalConcentration" + id.toString();
        return "<div style='width:14%; float:left;'><textarea id='" + vs + "' name='tbVialSize'></textarea></div>" +
               "<div style='width:32%; float:left;'><textarea id='" + vd + "' name='tbVolumeOfDiluent'></textarea></div>" +
               "<div style='width:24%; float:left;'><textarea id='" + aa + "' name='tbApproxAvailable'></textarea></div>" +
               "<div style='width:24%; float:left; padding-right:2px;'><textarea id='" + nc + "' name='tbNominalConcentration'></textarea></div>" +
                "<div style='width:5%; float:left;'>" +
               '<input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveParenteralProductsTextBox(' + id + ')" id="btnRemoveParenteralProductsTextBox(' + id + ')" />' +
                   // '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveParenteralProductsTextBox(' + id + ')" width="22" height="22" alt="Remove"/>' +
                "</div>";
    }

    //function AddPharmacokineticParametersTextBox() {

    //    PharmacokineticParametersCounter = PharmacokineticParametersCounter + 1;
    //    counter = PharmacokineticParametersCounter;

    //    var div = document.createElement('DIV');
    //    var att = document.createAttribute("class");
    //    var identity = document.createAttribute("id");
    //    att.value = "roadynarow";
    //    identity.value = "PharmacokineticParameters" + counter;
    //    div.setAttributeNode(att);
    //    div.setAttributeNode(identity);
    //    div.innerHTML = GetPharmacokineticParametersDynamicTextBox(counter);
    //    document.getElementById("dvExtraPharmacokineticParameters").appendChild(div);

    //    setup();
    //}

    //function GetPharmacokineticParametersDynamicTextBox(id) {
    //    var cmax = "tbCmax" + id.toString();
    //    var thalf = "tbtHalfH" + id.toString();
    //    var auco = "tbAUCOFour" + id.toString();
    //    var clear = "tbClearance" + id.toString();
    //    var vold = "tbVolumeDistribution" + id.toString();

    //    return "<div style='width:20%; float:left; border: 1px solid #D9D9D9; height:118px;'>" +
    //               "Single dose mean" +
    //            "</div>" +
    //            "<div style='width:14%; float:left;'>" +
    //                 "<textarea id='" + cmax + "' name='tbCmax'></textarea>" +
    //            "</div>" +
    //            "<div style='width:14%; float:left;'>" +
    //                 "<textarea id='" + thalf + "' name='tbtHalfH'></textarea>" +
    //            "</div>" +
    //            "<div style='width:14%; float:left;'>" +
    //                 "<textarea id='" + auco + "' name='tbAUCOFour'></textarea>" +
    //            "</div>" +
    //            "<div style='width:14%; float:left;'>" +
    //                 "<textarea id='" + clear + "' name='tbClearance'></textarea>" +
    //            "</div>" +
    //            "<div style='width:18%; float:left; padding-right:4px;'>" +
    //                 "<textarea id='" + vold + "' name='tbVolumeDistribution'></textarea>" +
    //            "</div>" +
    //            "<div style='width:5%; float:left;'>" +
    //                '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemovePharmacokineticParametersTextBox(' + id + ')" width="58" height="40" />' +
    //            "</div>";
    //}

    //function AddPharmacokinetics() {

    //    PharmacokineticsCounter = PharmacokineticsCounter + 1;
    //    counter = PharmacokineticsCounter;

    //    var div = document.createElement('DIV');
    //    var att = document.createAttribute("class");
    //    var identity = document.createAttribute("id");
    //    att.value = "roadynarow";
    //    identity.value = "Pharmacokinetics" + counter;
    //    div.setAttributeNode(att);
    //    div.setAttributeNode(identity);
    //    div.innerHTML = GetAddPharmacokineticsDynamicSelection(counter);
    //    document.getElementById("dvExtraPharmacokinetics").appendChild(div);

    //    setup();
    //}

    //function GetAddPharmacokineticsDynamicSelection(id) {
    //    var hsdd = "ddPharmacokinetics" + id.toString();
    //    var hstb = "tbddPharmacokinetics" + id.toString();
    //    return "<div style='width:94%; float:left; border:1px solid #D9D9D9; padding: 4px 4px 4px 4px; margin-top:4px;'>" +
    //                "<select id='" + hsdd + "' name='ddPharmacokinetics' style='width: 280px; margin-bottom: 5px;'>" +
    //                    "<option value='Absorption'>Absorption</option>" +
    //                    "<option value='Distribution'>Distribution</option>" +
    //                    "<option value='Metabolism'>Metabolism</option>" +
    //                    "<option value='Excretion'>Excretion</option>" +
    //                    "<option value='Special Populations and Conditions'>Special Populations and Conditions</option>" +
    //                    "<option value='Pediatrics'>Pediatrics</option>" +
    //                    "<option value='Geriatrics'>Geriatrics</option>" +
    //                    "<option value='Gender'>Gender</option>" +
    //                    "<option value='Race'>Race</option>" +
    //                    "<option value='Hepatic Insufficiency'>Hepatic Insufficiency</option>" +
    //                    "<option value='Renal Insufficiency'>Renal Insufficiency</option>" +
    //                    "<option value='Genetic Polymorphism'>Genetic Polymorphism</option>" +
    //                 "</select>" +
    //                 "<textarea id='" + hstb + "' name='tbddPharmacokinetics'></textarea>" +
    //            "</div>" +
    //            "<div style='width:5%; float:left;'>" +
    //                '<img style="cursor:pointer !important;" src="images/btnRemove.png" onclick="RemovePharmacokineticsTextBox(' + id + ')" width="58" height="40" />' +
    //            "</div>";
    //}

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Sub Menu Item of "Part I" for DHPR Form -->
<div class="row">
</div>
<div class="row">
<asp:Menu ClientIDMode="Static" ID="submenutabs" cssclass="floatLeft" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick"> 
   <StaticMenuStyle VerticalPadding="5px" />
   <StaticMenuItemStyle HorizontalPadding="25px" />
      <Items>
         <asp:MenuItem Value="PMForm"></asp:MenuItem>
         <asp:MenuItem Value="Coverpage"></asp:MenuItem>
         <asp:MenuItem Value="PartOne"></asp:MenuItem>
         <asp:MenuItem Value="PartTwo"></asp:MenuItem>
         <asp:MenuItem Value="PartThree"></asp:MenuItem></Items>
</asp:Menu>
</div>   
<div class="row mrgn-tp-md">
   <asp:Button ID="btnSaveDraftPart1" runat="server" cssclass="btn btn-primary" Text="Save draft" OnClick="btnSave_Click" ToolTip="Please save your form data in a draft file." /> 
</div>
<!-- Main Content For Submenu Item of "Part I" and Use WET Standard -->
<div class="row">
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>
<div class="row margin-top-medium">
    <asp:Label ID="lblPartITitle" runat="server" CssClass="h2"></asp:Label>
</div>
<div class="row margin-top-medium">
    <asp:Label ID="lblProprietaryBrandName" runat="server" CssClass="h4"></asp:Label>
</div>
<div class="row">
    <asp:Label ID="lblProperName" runat="server" CssClass="h4"></asp:Label>
</div>
<ul class="list-unstyled">
	<li>
<details class="margin-top-medium">
   <summary id="SumSummaryProductInformation" runat="server"></summary>
     <div class="form-group">
          <div class="row mrgn-lft-sm">
            <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                <asp:Label id="lblRouteOfAdministration" runat="server" CssClass="Control-Label text-primary"></asp:Label>
            </div>
             <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                <asp:Label id="lblDosageForm" runat="server" CssClass="Control-Label text-primary">Dosage form</asp:Label>
            </div>
            <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                <asp:Label id="lblStrength" runat="server" CssClass="Control-Label text-primary">Strength</asp:Label>
            </div>
           <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">
                <asp:Label id="lblClinicallyRelevantNonmedicinalIngredients" runat="server" CssClass="Control-Label text-primary">Clinically relevant nonmedicinal ingredients</asp:Label>
            </div>
            <div class="col-xs-1 brdr-tp brdr-lft brdr-rght brdr-bttm">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddRouteOfAdminTextBox()" id="btnAddExtraRouteOfAdmin" />
           </div>   
        </div>    
        <div id="dvExtraRouteOfAdmin" class="row mrgn-lft-sm">
        </div>
      </div>
    </details>
     </li>
	<li> 
    <details class="margin-top-medium">
      <summary id="SUM_INDICATIONS" runat="server"></summary>
         <div class="form-group">
           <div class="mrgn-lft-sm mrgn-tp-md">
                <asp:Label ID="lblBrandName" runat="server" CssClass="text-info"></asp:Label>
                    &nbsp;(<asp:Label ID="lblICProperName" runat="server" CssClass="text-info"></asp:Label>&nbsp;
                   <asp:Label ID="lblIsIndicatedFor" runat="server" CssClass="text-info"></asp:Label>:) 
                    <img id="tooltipINDICATIONS" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" alt="Help Message" />
           </div> 
           <div class="row"> 
              <div class="col-xs-10">
                  <textarea id="tbBrandNameIndicatedFor" name="tbBrandNameIndicatedFor" class="textarea form-control" runat="server" title="Brief discussion of any relevant clinical information - if applicable"></textarea>                           
              </div>    
           </div>
         <div class="form-group"> 
            <div id="divTextBox16" class="row mrgn-lft-sm mrgn-tp-md">           
               <div class="pull-left"><asp:Label id="lblGeriatrics" AssociatedControlID="tbICUPediatrics" runat="server" CssClass="control-label"></asp:Label>&nbsp;&#40;&nbsp;</div>
               <div title="X" class="pull-left"><input type="number" id="tbGeriatricXvalue" name="tbGeriatricXvalue" runat="server" class="width_52px" min="0" max="150" />&nbsp;&nbsp;</div>   
               <div class="pull-left"><asp:Label id="lblYearsOfAge" runat="server" CssClass="Control-label"></asp:Label>&#41;&#58;</div>  
            </div>    
            <div class="row">
               <div class="col-xs-10">
                  <textarea id="tbICUGeriatrics" name="tbICUGeriatrics" runat="server"></textarea>
               </div>
            </div>                         
        </div>
        </div>   
        <div class="form-group"> 
            <div id="divTextBox86" class="mrgn-tp-md">    
               <div class="pull-left"><asp:Label id="lblPediatrics" runat="server" CssClass="control-label"></asp:Label> (&nbsp;</div>
               <div class="pull-left" title="X"><input type="number" id="tbPediatricsXvalue" name="tbPediatricsXvalue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div>
               <div class="pull-left">-&nbsp;</div>
               <div class="pull-left" title="Y"><input type="number" id="tbPediatricsYvalue" name="tbPediatricsYvalue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div> 
               <div class="pull-left"><asp:Label id="lblYearsOfAgeOr" runat="server" CssClass="control-label"></asp:Label> (&nbsp;<&nbsp;</div>   
               <div class="pull-left"><input type="number" id="tbYrsofAgeValue" name="tbYrsofAgeValue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div> 
               <div class="pull-left"><asp:Label id="lblYearsOfAge2" CssClass="control-label" runat="server"></asp:Label>):</div> 
            </div>
            <div class="row">
                 <div class="col-xs-10">
                    <textarea id="tbICUPediatrics" name="tbICUPediatrics" runat="server"></textarea>
                 </div>                         
            </div>
         </div> 
    </details>
    </li>
	<li> 
    <details class="margin-top-medium">
        <summary id="SUM_CONTRAINDICATIONS" runat="server"></summary>
       <div class="form-group">
           <div class="row margin-top-medium mrgn-bttm-sm">
              <div class="col-xs-10">
                  <strong><asp:Label id="lblContraindications" runat="server" CssClass="control-label"></asp:Label></strong>&nbsp;<img id="tooltipCONTRAINDICATIONS" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of CONTRAINDICATIONS" /></div>
            <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddContraindicationsTextBox()" id="btnAddExtraContraindications" />
               <!-- <img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddContraindicationsTextBox()" id="btnAddExtraContraindications" width="23" height="23" alt="Add"/>    -->                                                      
            </div> 
        </div>  
        <div id="Cntrndctns0" class="row">
            <div class="col-xs-10">
                <textarea id="tbContraindicationsDynamic0" name="tbContraindicationsDynamic"></textarea>
            </div>   
            <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveContraindicationsTextBox(0)" id="btnRemoveContraindications" />
               <!-- <img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveContraindicationsTextBox(0)" id="btnRemoveContraindications" width="22" height="22" alt="Remove"/> -->                                                         
            </div>     
        </div>  
        <div id="dvExtraContraindications" class="row">
        </div>
      </div>
    </details>
   </li>
	<li> 
    <details class="margin-top-medium">
      <summary id="SUM_WARNINGS" runat="server"></summary>
        <div class="form-group">
          <div class="row margin-top-medium mrgn-bttm-sm">
             <div class="col-xs-10">
               <strong><asp:Label id="lblSerious" runat="server" CssClass="control-label"></asp:Label></strong>&nbsp;<img id="tooltipSeriousWarnings" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Serious warnings"/>         
             </div>
             <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddSeriousWarningsPrecautionsTextBox()" id="btnAddExtraSeriousWarningsPrecautions" />
             </div>      
          </div> 
        <div id="SrsWrngPrctns0" class="row">
            <div class="col-xs-10">
                <textarea id="tbSeriousWarningsPrecautions0" name="tbSeriousWarningsPrecautions" class="textarea form-control"></textarea>
            </div>  
            <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveSeriousWarningsPrecautionsTextBox(0)" id="btnRemoveSeriousWarningsPrecautions" />
            </div> 
        </div> 
        <div id="dvExtraSeriousWarningsPrecautions" class="row">
        </div>
      </div>
      <div class="form-group">
           <div class="row margin-top-medium mrgn-bttm-sm">
               <div class="col-xs-10">
                 <strong><asp:Label id="lblHeadings" runat="server" CssClass="control-label"></asp:Label></strong>&nbsp;<img id="tooltipSeriousWarningsHeadings" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Headings" />
              </div>   
          </div>  
           <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddHeadingSelection()" id="btnAddExtraAddHeadingSelection" />
           </div>       
           <div id="dvExtraHeadingSelection" class="row">
           </div>
     </div>
     <div class="form-group">
        <div class="margin-top-medium mrgn-lft-sm">
           <asp:Label id="lblAdditional" AssociatedControlID="tbAdditionalWarning" runat="server" CssClass="control-label"></asp:Label>
        </div> 
        <div class="row"> 
           <div class="col-xs-10">                           
              <textarea id="tbAdditionalWarning" name="tbAdditionalWarning" runat="server" class="textarea form-control"></textarea>                            
           </div>
        </div>
      </div>
    </details>    
    </li>
	<li> 
    <details class="margin-top-medium">
      <summary id="SUM_ADVERSE" runat="server"></summary>
        <div class="form-group">
            <div class="margin-top-medium mrgn-lft-sm">
                <asp:Label id="lblAdverse" AssociatedControlID="tbAdverseDrugReactOverview" runat="server" CssClass="control-label"></asp:Label>
                &nbsp;<img id="tooltipAdverseReaction" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Adverse Reaction" />
            </div> 
            <div class="row">
                <div class="col-xs-10">
                    <textarea id="tbAdverseDrugReactOverview" name="tbAdverseDrugReactOverview" runat="server" class="textarea form-control"></textarea>                            
               </div>
           </div>
        </div>
       <div class="form-group">
           <div class="row margin-top-large">
               <div class="col-xs-10">   
                 <input type="text" list="dladversereactions" id="tbSelectedAdverseReaction" style="width: 500px; height:40px;"/>
                 <datalist id="dladversereactions"></datalist>
                   &nbsp;<img id="tooltipSelectedAdverseReaction" src="images/qmark.jpg" style="width:24px; height:24px; cursor:pointer !important;" alt="Help Message of Selected Adverse Reaction" />
               </div>                
              <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddAdverseReactionsOuterSection()" id="btnAddAdverseReactionsOuterSection" />
              </div> 
          </div>  
        <div id="dvExtraAdverseReactionsOuter" class="row">
        </div>  
     </div>
    </details>
    </li>
	<li> 
    <details class="margin-top-medium">
       <summary id="SUM_DRUG_INTERACTIONS" runat="server"></summary>  
       <div class="form-group">
          <div class="mrgn-lft-sm margin-top-medium">
              <asp:Label id="lblOverview" AssociatedControlID="tbDrugInteractionsOverview" runat="server" CssClass="control-label"></asp:Label>
              &nbsp;<img id="tooltipDrugInteraction" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Drug Interaction" />
          </div>
          <div class="row"> 
            <div class="col-xs-10">                        
              <textarea id="tbDrugInteractionsOverview" name="tbDrugInteractionsOverview" runat="server" class="textarea form-control"></textarea>                            
           </div>
         </div>
       </div>
        <div class="form-group">
           <div class="row mrgnin-top-medium mrgn-bttm-sm">
               <div class="col-xs-10">   
            <input type="text" list="dldruginteractions" id="tbSelectedDrugInteraction" style="width: 500px; height:40px;"/>
            <datalist id="dldruginteractions"></datalist>
        </div>     
        <div  class="col-xs-1">
            <input type="button" value="Add" onclick="AddDrugInteractionsOuterSection()" id="btnAddDrugInteractionsOuterSection" class="btn btn-default btn-xs" />
        </div> 

        <div id="dvExtraDrugInteractionsOuter" class="row mrgn-lft-sm">
        </div>  
      </div>
    </details>
 </li>
	<li> 
    <details class="margin-top-medium">
        <summary id="SUM_DOSAGE" runat="server"></summary>
        <div class="form-group">
          <div class="row margin-top-large mrgn-bttm-sm">
             <div class="col-xs-10">
                 <strong><asp:Label id="lblDosing" runat="server" CssClass="control-label"></asp:Label></strong>&nbsp;<img id="tooltipDosingConsiderations" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Dosing Considerations"/>            
             </div>  
             <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddDosingConsiderationsTextBox()" id="btnAddExtraDosingConsiderations" />
             </div>        
          </div> 
          <div id="DosingConsiderations0" class="row">
            <div class="col-xs-10">
                <textarea id="tbDosingConsiderations0" name="tbDosingConsiderations" class="textarea form-control"></textarea>
            </div>  
            <div class="col-xs-1">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDosingConsiderationsTextBox(0)" id="btnRemoveDosingConsiderations" />
            </div> 
        </div>
        <div id="dvExtraDosingConsiderations" class="row">
        </div>
       </div>
       <div class="form-group">
          <div class="mrgn-lft-sm margin-top-medium">
             <asp:Label id="lblRecommended" AssociatedControlID="tbRecommendedDose" runat="server" CssClass="control-label"></asp:Label>&nbsp;<img id="tooltipRecommendedDose" src="images/qmark.jpg" class="imgQMark_style" />        
          </div>
          <div class="row">
            <div id="divTextBox18" class="col-xs-10">                        
                <textarea id="tbRecommendedDose" name="tbRecommendedDose" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
      </div>
       <div class="form-group">
          <div id="divTextBox14" class="mrgn-lft-sm margin-top-medium">
             <asp:Label id="lblMissed" AssociatedControlID="tbMissedDose" runat="server" CssClass="control-label"></asp:Label>
          </div>
          <div class="row"> 
             <div class="col-xs-10">
                <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea form-control"></textarea>                            
            </div>
         </div>
      </div>
      <div class="form-group">
          <div id="divTextBox17" class="mrgn-lft-sm margin-top-medium"> 
              <asp:Label id="lblAdministration" AssociatedControlID="tbAdministration" runat="server" CssClass="control-label"></asp:Label>
          </div>
          <div class="row"> 
             <div class="col-xs-10">                         
                <textarea id="tbAdministration" name="tbAdministration" runat="server" class="textarea form-control"></textarea>                            
            </div>
         </div>
        <div class="row mrgn-lft-sm margin-top-medium">
            <strong><asp:Label id="lblReconstitution" runat="server"></asp:Label></strong>  
        </div>
     </div>
     <div class="form-group">
        <div id="divTextBox15" class="mrgn-lft-sm margin-top-medium"> 
           <asp:Label id="lblOral" AssociatedControlID="tbOralSolutions" runat="server" CssClass="text-primary"></asp:Label>:
        </div>                         
        <div class="row"> 
            <div class="col-xs-10">
                <textarea id="tbOralSolutions" name="tbOralSolutions" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>          
    </div>    
    <div class="form-group">
        <div class="margin-top-medium mrgn-bttm-sm"> 
           <strong><asp:Label ID="lblParenteralProducts" runat="server" CssClass="text-primary"></asp:Label></strong>
        </div>

      <div class="row mrgn-tp-md"> 
            <div style="width:14%; float:left; border: 1px solid #D9D9D9; height:50px;">
                <label id="lblVialSize" lang="en">Vial size</label>
            </div>
            <div style="width:32%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblVolume" lang="en">Volume of diluent to be added to vial</label>
            </div>
            <div style="width:24%; float:left; border: 1px solid #D9D9D9; height:50px">
                 <label id="lblApproximate" lang="en">Approximate available volume</label>
            </div>
            <div style="width:24%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblNominal" lang="en">Nominal concentration per mL</label>
            </div>
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Add"  onclick="AddParenteralProductsTextBox()" id="btnAddParenteralProducts" />
             </div>   
        </div>

        <div id="ParenteralProducts0" style="width:90%; padding-left: 0px; clear:both;">
            <div style="width:14%; float:left;">
                <textarea id="tbVialSize0" name="tbVialSize" class="textarea form-control"></textarea>                
            </div>  
            <div style="width:32%; float:left;">
                <textarea id="tbVolumeOfDiluent0" name="tbVolumeOfDiluent" class="textarea form-control"></textarea>                
            </div> 
            <div style="width:24%; float:left;">
                <textarea id="tbApproxAvailable0" name="tbApproxAvailable" class="textarea form-control"></textarea>                
            </div>
            <div style="width:24%; float:left; padding-right:2px;">
                <textarea id="tbNominalConcentration0" name="tbNominalConcentration" class="textarea form-control"></textarea>                
            </div>   
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveParenteralProductsTextBox(0)" id="btnRemoveParenteralProducts" />
            </div>    
        </div>

        <div id="dvExtraParenteralProducts" class="row">
        </div>

        <div class="row mrgn-lft-sm mrgn-tp-md">
            <asp:Label ID="lblAnySpecific" runat="server" CssClass="control-label"></asp:Label>
        </div>
      </div>
    </details>
 </li>
	<li> 
    <details class="margin-top-medium">
       <summary id="SUM_OVERDOSAGE" runat="server"></summary>
       <div class="form-group">
            <div id="divTextBox19" class="mrgn-lft-sm margin-top-medium">
                 <asp:Label id="lblOverdosage" AssociatedControlID="tbOverdosage" runat="server" CssClass="control-label wb-inv"></asp:Label>
            </div>  
            <div class="row"> 
               <div class="col-xs-10">                        
                <textarea id="tbOverdosage" name="tbOverdosage" runat="server" class="textarea form-control"></textarea>                            
              </div>
           </div>
           <div class="row"> 
              <div class="col-xs-10 margin-top-medium"> 
                <asp:Label ID="lblForManagement" runat="server" CssClass="control-label text-info"></asp:Label>
              </div>
          </div>
       </div>
     <div class="form-group">
         <div id="divTextBox11" class="mrgn-lft-sm margin-top-large" > 
            <asp:Label id="lblForAnti" AssociatedControlID="tbAntiInfectiveDescription" runat="server" CssClass="alert-info"></asp:Label>
         </div>
         <div class="row"> 
            <div class="col-xs-10">                            
               <textarea id="tbAntiInfectiveDescription" name="tbAntiInfectiveDescription" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
     </div>
    </details>
 </li>
	<li> 
    <details class="margin-top-medium">
       <summary id="SUM_ACTION" runat="server"></summary>
       <div class="form-group">
          <div id="divTextBox10" class="mrgn-lft-sm margin-top-large"> 
              <asp:Label id="lblMechanism" AssociatedControlID="tbMechanismOfAction" runat="server" CssClass="control-label"></asp:Label>
                &nbsp;<img id="tooltipMechanismOfAction" src="images/qmark.jpg" class="imgQMark_style" alt="Help Message of Mechanism Of Action"/>
          </div> 
          <div class="row"> 
              <div class="col-xs-10"> 
                   <textarea id="tbMechanismOfAction" name="tbMechanismOfAction" runat="server" class="textarea form-control"></textarea>                            
              </div>
          </div>
      </div>
      <div class="form-group">
         <div id="divTextBox111" class="mrgn-lft-sm margin-top-medium">  
            <asp:Label id="lblPharmacodynamics" AssociatedControlID="tbPharmacodynamics" runat="server" CssClass="control-label"></asp:Label>
         </div> 
         <div class="row"> 
             <div class="col-xs-10">                         
                <textarea id="tbPharmacodynamics" name="tbPharmacodynamics" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
     </div>
      <div class="form-group">
         <div id="divTextBox109" class="mrgn-lft-sm margin-top-large">  
            <asp:Label id="lblPHARMACOKINETICS" runat="server" CssClass="control-label"></asp:Label>                                              
         </div>                                              
         <div class="row">
            <div class="col-xs-10">
            <input type="text" list="dlpharmacokinetics" id="tbSelectedPharmacokinetics" class="list-group" />
            <datalist id="dlpharmacokinetics" ></datalist> 
           </div>     
            <div class="col-xs-1">
             <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddPharmacokineticsOuterSection()" id="btnAddPharmacokineticsOuterSection" />
           </div> 
        </div>
         <div id="dvExtraPharmacokineticsOuter" class="row"></div>  
     </div>
    </details> 
 </li>
	<li> 
    <details class="margin-top-medium">
      <summary id="SUM_Special_Popu_Condition" runat="server"></summary>
      <div class="form-group">
           <div class="mrgn-lft-sm mrgn-tp-md">
               <asp:Label id="lblSpecialPopuCondition" AssociatedControlID="tbSpecialHandling" runat="server" CssClass="control-label wb-inv"></asp:Label>
           </div> 
           <div class="row"> 
             <div class="col-xs-10">                       
                <textarea id="tbSpecialPopuCondition" name="tbSpecialPopuCondition" runat="server" class="textarea form-control"></textarea>                            
            </div>
           </div>
       </div>
    </details>
 </li>
	<li>
    <details class="margin-top-medium">
      <summary id="SUM_STORAGE" runat="server"></summary>
      <div class="form-group">
           <div class="mrgn-lft-sm mrgn-tp-md">
             <asp:Label id="lblStorage" runat="server" AssociatedControlID="tbStorageStability" CssClass="control-label wb-inv"></asp:Label>
           </div> 
           <div class="row"> 
             <div class="col-xs-10">                          
                <textarea id="tbStorageStability" name="tbStorageStability" runat="server" class="textarea form-control"></textarea>                            
             </div>
           </div>
      </div>
    </details>
    </li> 
	<li> 
    <details class="margin-top-medium">
       <summary id="SUM_SPECIAL_HANDLING" runat="server"></summary>
       <div class="form-group">
           <div class="mrgn-lft-sm mrgn-tp-md">
              <asp:Label id="lblSpecialHandling" AssociatedControlID="tbSpecialHandling" runat="server" CssClass="control-label wb-inv"></asp:Label>
           </div>                         
           <div class="row"> 
              <div class="col-xs-10">   
               <textarea id="tbSpecialHandling" name="tbSpecialHandling" runat="server" class="textarea form-control"></textarea>                            
             </div>
          </div>
       </div>
    </details>
 </li>
    
	<li> 
   <details class="margin-top-medium margin-bottom-small">
       <summary id="SUM_DOSAGEFORMS" runat="server"></summary>
       <div class="form-group">
            <div class="mrgn-lft-sm mrgn-tp-md">
               <asp:Label id="lblDosageForms" AssociatedControlID="tbDosageFormsComposition" runat="server" CssClass="control-label wb-inv"></asp:Label>
            </div>
            <div class="row"> 
              <div class="col-xs-10">                        
                 <textarea id="tbDosageFormsComposition" name="tbDosageFormsComposition" runat="server" class="textarea form-control"></textarea>                            
              </div>
            </div>
        </div>
    </details>
  </li>
</ul>
<div class="row margin-top-medium">
<asp:Menu ClientIDMode="Static" ID="submenutabsbottom" cssclass="wet-boew-menubar floatLeft" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
   <StaticMenuStyle VerticalPadding="5px" />
   <StaticMenuItemStyle HorizontalPadding="25px" />
      <Items>
         <asp:MenuItem Value="PMForm"></asp:MenuItem>
         <asp:MenuItem Value="Coverpage"></asp:MenuItem>
         <asp:MenuItem Value="PartOne"></asp:MenuItem>
         <asp:MenuItem Value="PartTwo"></asp:MenuItem>
         <asp:MenuItem Value="PartThree"></asp:MenuItem>
      </Items>
</asp:Menu>
</div>

<asp:HiddenField runat="server" ID="hdParenteralProducts" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdPharmacokineticParameters" ClientIDMode="Static" />

<asp:HiddenField runat="server" ID="hdDrugDrugInteractCount" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdDosingConsiderations" ClientIDMode="Static" />

<asp:HiddenField runat="server" ID="hdCTADrugReactions" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdSeriousDrugInt" ClientIDMode="Static" />

<asp:HiddenField runat="server" ID="hdSeriousWarnPrecau" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdHeadingSelections" ClientIDMode="Static" />

<asp:HiddenField runat="server" ID="hdRouteCount" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdContraCount" ClientIDMode="Static" />
</asp:Content>
