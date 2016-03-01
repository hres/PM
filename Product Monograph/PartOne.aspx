<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartOne.aspx.cs" Inherits="Product_Monograph.PartOne" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <br />
<script type="text/javascript">   
    $(document).ready(function () {
        $("#tooltipINDICATIONS").attr('title', 'Brief discussion of any relevant clinical information - if applicable\nDistribution restrictions - if applicable\nWhen the product is not recommended - if applicable');
        $("#tooltipCONTRAINDICATIONS").attr('title', 'Patients who are hypersensitive to this drug or to any ingredient in the formulation or component of the container. For a complete listing, see the Dosage Forms, Composition and Packaging section of the product monograph. [if applicable]');
        $("#tooltipSeriousWarnings").attr('title', 'Clinically significant or serious life-threatening warnings should be placed in the warning box. Generally not to exceed 20 lines');
        $("#tooltipSeriousWarningsHeadings").attr('title', 'Headings to be included as applicable');
        $("#tooltipDosingConsiderations").attr('title', 'include all situations that may affect dosing of the drug');
        $("#tooltipRecommendedDose").attr('title', 'Include for each indication, route of administration or dosage form');
      
        $.get('ControlledList.xml', function (xmlcontolledlist) {
            $(xmlcontolledlist).find('reaction').each(function () {
                var $option = $(this).text();
                $('<option style="width: 500px; height:40px;">' + $option + '</option>').appendTo('#dladversereactions')
            });
        }).done(function () {
            $('#dladversereactions option').each(function () {
                //this does not work
                if ($(this).html() == 'Select') { $(this).attr('selected', 'selected'); return; }
                //hardcode
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
                //hardcode
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
                //hardcode
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
                               // '<img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddPharmacokineticsInnerTextBox(' + id + ')" width="23.5" height="23.5" alt="Add"/>' +
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
                    //'<img style="cursor:pointer !important;" src="images/minus_icon.png"  onclick="RemovePharmacokineticsOuterSection(' + id + ')" width="22" height="22" alt="Remove"/>' +
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

        //alert($("#tbSelectedDrugInteraction").val());
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
                               // '<img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddDrugInteractionsInnerTextBox(' + id + ')" width="23" height="23" alt="Add new row" />' +
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
                    //'<img style="cursor:pointer !important;" src="images/minus_icon.png"  onclick="RemoveDrugInteractionsOuterSection(' + id + ')" width="22" height="22" alt="Removw this row"/>' +
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
                           // '<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveDrugInteractionsInnerTextBox(' + innerid + ')" width="22" height="22" alt="Remove this row"/>' +
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
        //"input[name^='news']" 
        //alert( $("div[id^='AdverseReactionsOuter']").length );

        AdverseReactionsOuterSection = AdverseReactionsOuterSection + 1;
        counter = AdverseReactionsOuterSection;
        //alert("outer: " + counter);

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

        //$("#lblSelectedHeader" + counter).val($('#ddAdvReactions option:selected').val());
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
                        //'<div style="width:90%; float:left;">' +
                        //    '<h4>Table details:</h4>' +
                        //'</div>' +
                        "<div style='width:90%; text-align:center; float:left; border: 1px solid #D9D9D9;'>" +
                            "Table&nbsp;<&nbsp;<input type='number' id='nmTableNumber" + id + "' name='nmTableNumber' style='width:55px; text-align:center;'/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type='text' id='tbTableText" + id + "' name='tbTableText' style='width:55px; text-align:center;'/>&nbsp;>" +
                        "</div>" +

                        '<div style="width:5%; float:left;">' +
                                       '<div style="float:left;">' +
                                     '<input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddAdverseReactionsInnerTextBox(' + id + ')" id="btnAddAdverseReactionsInnerTextBox(' + id + ')" />' +
                               // '<img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddAdverseReactionsInnerTextBox(' + id + ')" width="23" height="23" alt="Add new row" />' +
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
            <asp:MenuItem Text="Form instructions" Value="PMForm" ToolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
            <asp:MenuItem Text="Cover page" Value="Coverpage" ToolTip="Cover page of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne" ToolTip="Part I of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo" ToolTip="Part II of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree" ToolTip="Part III of the form"></asp:MenuItem>
          </Items>
</asp:Menu>
<asp:Button ID="btnSaveDraftPart1" runat="server" cssclass="btn btn-default form-control paddingTop floatLeft" Text="Save draft" OnClick="btnSave_Click" ToolTip="Please save your form data in a draft file." /> 
</div>
<!-- Main Content For Submenu Item of "Part I" and Use WET Standard -->
<div class="row">
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>

<div class="row">
    <h2 ID="lblPartITitle" runat="server" class="siteSubHeader">Part I: Health Professional Information</h2>
</div>

<div class="row">
   <h4><asp:Label ID="lblBrandName" runat="server">Brand name</asp:Label></h4>
</div>

<div class="row">
   <h4><asp:Label ID="lblProprietaryProperName" runat="server">Proper name</asp:Label></h4>
</div>

<ul class="list-unstyled">
	<li>
    <details class="margin-top-medium">
        <summary id="SumSummaryProductInformation" runat="server">Summary Product Information</summary>
        <div style="width:90.20%; padding: 8px 4px 4px 0px; clear:both;">
            <div style="width:23.5%; float:left; border: 1px solid #D9D9D9; height:50px;">
                <label id="lblRouteOfAdministration" runat="server">Route of administration</label>
            </div>
            <div style="width:23.5%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblDosageForm2" runat="server">Dosage form</label>
            </div>
            <div style="width:23.5%; float:left; border: 1px solid #D9D9D9; height:50px">
               <label id="lblStrength2" runat="server">Strength</label>
            </div>
            <div style="width:23.5%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblIngredients" runat="server">Clinically relevant nonmedicinal ingredients</label>
            </div>
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddRouteOfAdminTextBox()" id="btnAddExtraRouteOfAdmin" runat="server"/>
            </div>   
        </div>    
        <div id="dvExtraRouteOfAdmin" style="width:90%; padding-left:0px; clear:both;">
        </div>
    </details>
    </li>
	<li> 
    <details class="margin-top-medium">
        <summary id="SUM_INDICATIONS" runat="server" >Indications and clinical use</summary>
        <div style="width:89.75%; text-align:center; clear:both; padding: 8px 4px 4px 0px;">
            <div style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px">
                    <asp:Label ID="lblBrandName3" runat="server" CssClass="text-info">Brand name</asp:Label>
                    &nbsp;(<asp:Label ID="lblICProperName" runat="server">Proper name is indicated for:</asp:Label>) 
                    <img id="tooltipINDICATIONS" src="images/qmark.jpg" style="width: 15px; height: 15px;" alt="Help Message" /></div> 
                <div style="width:94.5%; float:left;">
                       <textarea id="tbBrandNameIndicatedFor" name="tbBrandNameIndicatedFor" class="textarea form-control" runat="server" title="Brief discussion of any relevant clinical information - if applicable"></textarea> 
                   </div>                             
            </div>
        </div>

        <div style="width:90%; text-align:center; clear:both; padding-left:0px; padding-top: 20px;">
            <div id="divTextBox16" style="text-align:left;">              
                <div style="padding: 4px 4px 4px 0px">
                    <div style="float:left;"><label id="lblGeriatrics" runat="server">Geriatrics</label> ( >&nbsp;</div>
                    <div title="X" style="float:left;"><input type="number" id="tbGeriatricXvalue" name="tbGeriatricXvalue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div>
                    <div style="float:left;"><label id="lblYearsOfAge" runat="server">years of age</label>):</div>              
                </div>    
                <div style="width:94%; float:left;">
                    <textarea id="tbICUGeriatrics" name="tbICUGeriatrics" runat="server" class="textarea form-control"></textarea>
                </div>                         
            </div>
        </div>

        <div style="width:90%; text-align:center; clear:both; padding-left:0px; padding-top: 20px;">
            <div id="divTextBox86" style="text-align:left;">              
                <div style="padding: 4px 4px 4px 0px">
                    <div style="float:left;"><label id="lblPediatrics" runat="server">Pediatrics</label> (&nbsp;</div>
                    <div style="float:left;" title="X"><input type="number" id="tbPediatricsXvalue" name="tbPediatricsXvalue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div>
                    <div style="float:left;">-&nbsp;</div>
                    <div style="float:left;" title="Y"><input type="number" id="tbPediatricsYvalue" name="tbPediatricsYvalue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div> 
                    <div style="float:left;"><label id="lblYearsOfAgeOr" runat="server">years of age) or</label> (&nbsp;<&nbsp;</div>   
                    <div style="float:left;"><input type="number" id="tbYrsofAgeValue" name="tbYrsofAgeValue" runat="server" style="width:55px; text-align:center;"/>&nbsp;</div> 
                    <div style="float:left;"><label id="lblYearsOfAge2" runat="server">years of age</label>):</div> 
                </div>
                <div style="width:94%; float:left;">
                    <textarea id="tbICUPediatrics" name="tbICUPediatrics" runat="server" class="textarea form-control"></textarea>
                </div>                         
            </div>
        </div>
    
    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_CONTRAINDICATIONS" runat="server">Contraindications</summary>
        <div style="padding: 8px 4px 4px 0px; padding-left:0px; width:90%;">
            <div style="width:94%; float:left;"><label id="lblContraindications" runat="server">Contraindications</label>&nbsp;<img id="tooltipCONTRAINDICATIONS" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" alt="Help Message of CONTRAINDICATIONS" /></div>
            <div style="width:5%; float:left; padding-left:4px; display:none;">
                <input class="btn btn-default btn-xs" type="button" value="Add" runat="server" onclick="AddContraindicationsTextBox()" id="btnAddExtraContraindications" />
               </div> 
        </div>  
        <div id="Cntrndctns0" style="width:90%; padding-left: 0px; clear:both;">
            <div style="width:94%; float:left;">
                <textarea id="tbContraindicationsDynamic0" name="tbContraindicationsDynamic"></textarea>
            </div>   
            <div style="width:5%; float:left; display:none;">
                <input class="btn btn-default btn-xs" type="button" value="Remove" runat="server" onclick="RemoveContraindicationsTextBox(0)" id="btnRemoveContraindications" />
               </div>     
        </div>  
        <div id="dvExtraContraindications" style="width:90%; padding-left: 0px; clear:both;">
        </div>
    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_WARNINGS" runat="server">Warnings and precaution</summary>
        <div style="padding: 8px 4px 4px 0px; padding-left:0px; width:90%;">
            <div style="width:94%; float:left; clear:both;"><label id="lblSerious" runat="server">Serious warnings and precautions</label> <img id="tooltipSeriousWarnings" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" alt="Help Message of Serious warnings"/></div>          
            <div style="width:5%; float:left;padding-left:4px; display:none;">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddSeriousWarningsPrecautionsTextBox()" id="btnAddExtraSeriousWarningsPrecautions" runat="server" />
                   </div>      
        </div> 

        <div id="SrsWrngPrctns0" style="width:90%; padding-left: 0px; clear:both;">
            <div style="width:94%; float:left;">
                <textarea id="tbSeriousWarningsPrecautions0" name="tbSeriousWarningsPrecautions" class="textarea form-control"></textarea>
            </div>  
            <div style="width:5%; float:left; display:none;">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveSeriousWarningsPrecautionsTextBox(0)" id="btnRemoveSeriousWarningsPrecautions" runat="server" />
                 </div> 
        </div> 
        <div id="dvExtraSeriousWarningsPrecautions" style="width:90%; padding-left:0px; clear:both;">
        </div>

        <div style="width:90%; padding-left: 0px; clear:both; padding-top: 40px; padding-bottom:4px;">
            <div style="width:94%; float:left; clear:both;">
                <label id="lblHeadings" runat="server">Headings</label>&nbsp;<img id="tooltipSeriousWarningsHeadings" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" alt="Help Message of Headings" />
            </div>     
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddHeadingSelection()" runat="server" id="btnAddExtraAddHeadingSelection" />
             </div>       
        </div>
        <div id="dvExtraHeadingSelection" style="width:90%; padding-left: 0px; clear:both;"></div>
    </details>    
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_ADVERSE" runat="server">Adverse reactions</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; text-align:left;">
            <div style="padding: 4px 4px 4px 0px"><label id="lblAdverse" runat="server">Adverse drug reaction overview</label></div>                         
            <textarea id="tbAdverseDrugReactOverview" name="tbAdverseDrugReactOverview" runat="server" class="textarea form-control"></textarea>                            
        </div>

        <div style="clear:both; width:100%; padding: 25px 0px 0px 0px;"></div>
        <div style="width:46%; float:left;">        
            <input type="text" list="dladversereactions" id="tbSelectedAdverseReaction" style="width: 500px; height:40px;"/>
            <datalist id="dladversereactions"></datalist>
        </div>       
        <div style="width:5%; float:left;">
            <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddAdverseReactionsOuterSection()" runat="server" id="btnAddAdverseReactionsOuterSection" />
            </div> 
        <div style="float:left; display:none;">
            <img id="tooltipSelectedAdverseReaction" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" alt="Help Message of Selected Adverse Reaction" />
        </div>  
        <div id="dvExtraAdverseReactionsOuter" style="clear:both; width:100%">
        </div>  

    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_DRUG_INTERACTIONS" runat="server">Drug interations</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; text-align:left; padding-top:20px;">
            <div style="padding: 4px 4px 4px 0px"><label id="lblOverview" runat="server">Overview</label></div>                         
            <textarea id="tbDrugInteractionsOverview" name="tbDrugInteractionsOverview" runat="server" class="textarea form-control"></textarea>                            
        </div>

        <div style="clear:both; width:100%; padding: 25px 0px 0px 0px;"></div>
        <div style="width:46%; float:left;">        
            <input type="text" list="dldruginteractions" id="tbSelectedDrugInteraction" style="width: 500px; height:40px;"/>
            <datalist id="dldruginteractions"></datalist>
        </div>     
        <div style="width:5%; float:left;">
            <input type="button" value="Add" onclick="AddDrugInteractionsOuterSection()" runat="server" id="btnAddDrugInteractionsOuterSection" class="btn btn-default btn-xs" />
        </div> 
        <div id="dvExtraDrugInteractionsOuter" style="clear:both; width:100%">
        </div>  

    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_DOSAGE" runat="server">Dosage and administration</summary>

        <div style="padding: 20px 0px 4px 0px; padding-left: 0px; width:90%;">
            <div style=" width:94%; float:left;"><label id="lblDosing" runat="server">Dosing considerations</label>&nbsp;<img id="tooltipDosingConsiderations" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" alt="Help Message of Dosing Considerations"/>            
            </div>  
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Add" runat="server" onclick="AddDosingConsiderationsTextBox()" id="btnAddExtraDosingConsiderations" />
            </div>        
        </div> 

        <div id="DosingConsiderations0" style="width:90%; padding-left: 0px; clear:both;">
            <div style="width:94%; float:left;">
                <textarea id="tbDosingConsiderations0" name="tbDosingConsiderations" class="textarea form-control"></textarea>
            </div>  
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveDosingConsiderationsTextBox(0)" id="btnRemoveDosingConsiderations" runat="server" />
            </div> 
        </div>

        <div id="dvExtraDosingConsiderations" style="width:90%; padding-left: 0px; clear:both;">
        </div>

        <div style="padding-left: 0px; padding-top: 20px; clear:both;">
            <label id="lblRecommended" runat="server">Recommended dose and dosage adjustment</label>&nbsp;<img id="tooltipRecommendedDose" src="images/qmark.jpg" style="width:15px; height:15px; cursor:pointer !important;" />        
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:4px;">
            <div id="divTextBox18" style="text-align:left;">                        
                <textarea id="tbRecommendedDose" name="tbRecommendedDose" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px;">
            <div id="divTextBox14" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblMissed" runat="server">Missed dose</label></div>                         
                <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px;">
            <div id="divTextBox17" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblAdministration" runat="server">Administration</label></div>                         
                <textarea id="tbAdministration" name="tbAdministration" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>

        <div style="padding-left: 0px;">
            <label id="lblReconstitution" runat="server">Reconstitution</label>  
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px;">
            <div id="divTextBox15" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblOral" runat="server">Oral solutions</label>:</div>                         
                <textarea id="tbOralSolutions" name="tbOralSolutions" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>      

        <section style="width:90%; padding-left: 0px; clear:both; padding-top:20px;">
            <asp:Label ID="lblParenteralProducts" runat="server">Parenteral products:</asp:Label>
        </section>

        <section style="width:90%; padding-left: 0px; clear:both; padding-top:4px;">
            <div style="width:14%; float:left; border: 1px solid #D9D9D9; height:50px;">
                <label id="lblVialSize" runat="server">Vial size</label>
            </div>
            <div style="width:32%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblVolume" runat="server">Volume of diluent to be added to vial</label>
            </div>
            <div style="width:24%; float:left; border: 1px solid #D9D9D9; height:50px">
                 <label id="lblApproximate" runat="server">Approximate available volume</label>
            </div>
            <div style="width:24%; float:left; border: 1px solid #D9D9D9; height:50px">
                <label id="lblNominal" runat="server">Nominal concentration per mL</label>
            </div>
            <div style="width:5%; float:left;">
                <input class="btn btn-default btn-xs" type="button" value="Add"  onclick="AddParenteralProductsTextBox()" runat="server" id="btnAddParenteralProducts" />
           </div>   
        </section>

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
                <!--<img style="cursor:pointer !important;" src="images/minus_icon.png"  onclick="RemoveParenteralProductsTextBox(0)" id="btnRemoveParenteralProducts" width="22" height="22" alt="Remove"/>-->                                                          
            </div>    
        </div>

        <div id="dvExtraParenteralProducts" style="width:90%; padding-left: 0px; clear:both;">
        </div>

        <section style="width:100%; padding-left: 0px; clear:both; padding-top:2px;">
            <asp:Label ID="lblAnySpecific" runat="server">Any specific precautions, storage periods and incompatibilities</asp:Label>
        </section>
    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_OVERDOSAGE" runat="server">Overdosage</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div id="divTextBox9" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblOverdosage" runat="server">Overdosage</label></div>                         
                <textarea id="tbOverdosage" name="tbOverdosage" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
        <section style="width:100%; padding-left: 0px; clear:both; padding-top:2px; display:none;">
            <asp:Label ID="lblForManagement" runat="server">For management of a suspected drug overdose, contact your regional Poison Control Centre</asp:Label>
        </section>
    
        

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px; display:none;">
            <div id="divTextBox11" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblForAnti" runat="server">
                    For anti-infective products: a brief description of action against micro-organisms
                 </label>
                </div>                         
                <textarea id="tbAntiInfectiveDescription" name="tbAntiInfectiveDescription" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_ACTION" runat="server">Action and clinical pharmacology</summary>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div id="divTextBox10" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblMechanism" runat="server">Mechanism of action</label></div>                         
                <textarea id="tbMechanismOfAction" name="tbMechanismOfAction" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div id="divTextBox111" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblPharmacodynamics" runat="server">Pharmacodynamics</label></div>                         
                <textarea id="tbPharmacodynamics" name="tbPharmacodynamics" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>

        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div id="divTextBox109" style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblPHARMACOKINETICS" runat="server">Pharmacokinetics</label></div>                                              
            </div>
        </div>
        
        <div style="width:46%; float:left;">
            <input type="text" list="dlpharmacokinetics" id="tbSelectedPharmacokinetics" style="width: 500px; height:40px;"/>
            <datalist id="dlpharmacokinetics" ></datalist> 
        </div>     
        <div style="width:5%; float:left;">
            <input class="btn btn-default btn-xs" type="button" value="Add" runat="server" onclick="AddPharmacokineticsOuterSection()" id="btnAddPharmacokineticsOuterSection" />
          </div> 

        <div id="dvExtraPharmacokineticsOuter" style="clear:both; width:100%">
        </div>  

    </details> 
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_STORAGE" runat="server">Storage and stability</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblStorage" runat="server">Storage and stability</label></div>                         
                <textarea id="tbStorageStability" name="tbStorageStability" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
    </details>
    </li>
	<li>
    <details class="margin-top-medium">
        <summary id="SUM_SPECIAL_HANDLING" runat="server">Special handling instruction</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblSpecialHandling" runat="server">Special handling instruction</label></div>                         
                <textarea id="tbSpecialHandling" name="tbSpecialHandling" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
    </details>
    </li>
    <li>
    <details class="margin-top-medium margin-bottom-small">
        <summary id="SUM_DOSAGEFORMS" runat="server">Dosage forms, composition and packaging</summary>
        <div style="width:84.5%; text-align:center; clear:both; padding-left: 0px; padding-top:20px;">
            <div style="text-align:left;">  
                <div style="padding: 4px 4px 4px 0px"><label id="lblDosageForms" runat="server">Dosage forms, composition and packaging</label></div>                         
                <textarea id="tbDosageFormsComposition" name="tbDosageFormsComposition" runat="server" class="textarea form-control"></textarea>                            
            </div>
        </div>
    </details>
   </li>
</ul>
<div style="clear:both; padding-top:20px;">
<asp:Menu ClientIDMode="Static" ID="submenutabsbottom" cssclass="wet-boew-menubar floatLeft" runat="server" Orientation="Horizontal" OnMenuItemClick="submenutabsbottom_MenuItemClick">
   <StaticMenuStyle VerticalPadding="5px" />
   <StaticMenuItemStyle HorizontalPadding="25px" />
      <Items>
            <asp:MenuItem Text="Form instructions" Value="PMForm" ToolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
            <asp:MenuItem Text="Cover page" Value="Coverpage" ToolTip="Cover page of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part I" Value="PartOne" ToolTip="Part I of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part II" Value="PartTwo" ToolTip="Part II of the form"></asp:MenuItem>
            <asp:MenuItem Text="Part III" Value="PartThree" ToolTip="Part III of the form"></asp:MenuItem>
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
