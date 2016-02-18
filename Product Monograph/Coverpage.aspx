<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="Coverpage.aspx.cs" Inherits="Product_Monograph.Coverpage" ValidateRequest="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">    
        tinymce.init({
            //selector: "textarea",
            mode : "specific_textareas",
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
                }),
                theEditor.on('keyup', function (ed, e) {
                   //not applicable
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
                    theEditor.on('keyup', function (ed, e) {
                        //not applicable
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

        var BrandProperDosageCounter = 0;

        function RemoveBrandProperDosageTextBox(i) {
            var rowid = "#BrandProperDosage" + i;
            if (counter <= 1) {
                //  lblError.Text = " ";
                alert("We could not delete all the rows");
            }
            else
               $(rowid).remove();
        }

        function AddBrandProperDosageTextBox() {

            BrandProperDosageCounter = BrandProperDosageCounter + 1;
            counter = BrandProperDosageCounter;

            var div = document.createElement('DIV');
            var att = document.createAttribute("class");
            var identity = document.createAttribute("id");
            att.value = "roadynarow";
            identity.value = "BrandProperDosage" + counter;
            div.setAttributeNode(att);
            div.setAttributeNode(identity);
            div.innerHTML = GetAddBrandProperDosageTextBoxDynamicTextBox(counter);
            document.getElementById("dvExtraBrandProperDosage").appendChild(div);

            //table - start
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('dosageform').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbDosage' + counter);
                });
            });
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('unit').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbStrengthUnit' + counter); //tbUnitofMeasure
                });
            });
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('unit').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit' + counter);
                });
            });
            //table - end

            setup();
        }

        function AddBrandProperDosageTextBoxLoadFromXML() {

            BrandProperDosageCounter = BrandProperDosageCounter + 1;
            counter = BrandProperDosageCounter;

            var div = document.createElement('DIV');
            var att = document.createAttribute("class");
            var identity = document.createAttribute("id");
            att.value = "roadynarow";
            identity.value = "BrandProperDosage" + counter;
            div.setAttributeNode(att);
            div.setAttributeNode(identity);
            div.innerHTML = GetAddBrandProperDosageTextBoxDynamicTextBox(counter);
            document.getElementById("dvExtraBrandProperDosage").appendChild(div);

            ////table - start
            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('dosage').each(function () {
            //        var $option = $(this).text();
            //        $('<option>' + $option + '</option>').appendTo('#tbDosage' + counter);
            //    });
            //});
            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('unit').each(function () {
            //        var $option = $(this).text();
            //        $('<option>' + $option + '</option>').appendTo('#tbUnitofMeasure' + counter);
            //    });
            //});
            ////table - end

            setup();
        }

        function GetAddBrandProperDosageTextBoxDynamicTextBox(id) {
    //        <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
    //    Brand name
    //</div>
    //<div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
    //    Proper name
    //</div>
    //<div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
    //    Dosage Form
    //</div>
    //<div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
    //    <div style="clear:both; width:100%; padding:2px;">Strength</div>
    //    <div style="width:50%; float:left; padding:2px;">Value</div>
    //    <div style="width:50%; float:left; padding:2px;">Unit</div>
    //</div>
    //<div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
    //    <div style="clear:both; width:100%; padding:2px;">Strength per Dosage</div>
    //    <div style="width:50%; float:left; padding:2px;">Value</div>
    //    <div style="width:50%; float:left; padding:2px;">Unit</div>
    //</div>
    //<div style="width:5%; float:left; padding-left:0px;">  
    //    <input style="cursor:pointer !important; width:58px; height:40px; font-size:12px;" onclick="AddBrandProperDosageTextBox()" id="btnAddBrandProperDosage"  type="button" value="ADD"/>
    //</div>  
            var bn = "tbBrandName" + id.toString();
            var pn = "tbProperName" + id.toString();
            var dos = "tbDosage" + id.toString();
            var stv = "tbStrengthValue" + id.toString();
            var stu = "tbStrengthUnit" + id.toString();
            var stpdv = "tbStrengthperDosageValue" + id.toString();
            var stpdu = "tbStrengthperDosageUnit" + id.toString();
            return '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<input type="text" id="' + bn + '" name="tbBrandName" style="width:100%; border:0px; height:40px;" />' +
                    '</div>' +  
                    '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<input type="text" id="' + pn + '" name="tbProperName" style="width:100%; border:0px; height:40px;" />' +
                    '</div>' + 
                    '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<select id="' + dos + '" name="tbDosage" style="width:100%; height:40px; border:0px;" ></select>' +
                    '</div>' +  
                    '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<div style="width:49%; float:left; border:1px solid #D9D9D9;">' +
                            '<input type="number" id="' + stv + '" name="tbStrengthValue" style="width:100%; border:0px; height:38px;" />' +
                        '</div>' +
                        '<div style="width:49%; float:left; border:1px solid #D9D9D9;">' +
                            '<select id="' + stu + '" name="tbStrengthUnit" style="width:100%; height:38px; border:0px;" ></select>' +
                        '</div>' +
                    '</div>' + 
                    '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<div style="width:49%; float:left; border:1px solid #D9D9D9;">' +
                            '<input type="number" id="' + stpdv + '" name="tbStrengthperDosageValue" style="width:100%; border:0px; height:38px;" />' +
                        '</div>' +
                        '<div style="width:49%; float:left; border:1px solid #D9D9D9;">' +
                            '<select id="' + stpdu + '" name="tbStrengthperDosageUnit" style="width:100%; height:38px; border:0px;" ></select>' +
                        '</div>' +
                    '</div>' +  
                    '<div style="width:5%; float:left; padding-left: 0px;">' +
                         '<input class="btn btn-default btn-xs" onclick="RemoveBrandProperDosageTextBox(' + id + ')" id="btnRemoveBrandProperDosageTextBox(' + id + ')" type="button" value="Remove" />' +
                      //  '<input style="cursor:pointer !important; width:58px; height:40px; font-size:12px; padding-left:2px;" onclick="RemoveBrandProperDosageTextBox(' + id + ')" type="button" value="REMOVE" />' +
                    '</div>';  

            //"<div style='width:31.6%; float:left;  border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'><textarea id='" + bn + "' name='tbBrandName' style='width:318px; border:0px;'></textarea></div>" +
            //"<div style='width:31.6%; float:left;  border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'><textarea id='" + pn + "' name='tbProperName' style='width:317px; border:0px;'></textarea></div>" +
            //"<div style='width:31%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'><textarea id='" + ds + "' name='tbDosageAndStrength' style='width:312px;  border:0px;'></textarea></div>" +
            //"<div style='width:5%; float:left; padding-left: 0px;'>" +
            //    //'<img style="cursor:pointer !important;" src="images/minus_icon.png" onclick="RemoveBrandProperDosageTextBox(' + id + ')" width="50" height="50" />' +
            //    '<input style="cursor:pointer !important; width:58px; height:40px; font-size:12px; padding-left:2px;" onclick="RemoveBrandProperDosageTextBox(' + id + ')" type="button" value="REMOVE" />' +
            //"</div>";

            
        }
        //Setup default values on first row of Dosage Form --- created by Ching Chang on Feb 8, 2016
        var countTBL = 0
        function AddBrandProperDosageDefaultRow() {

         //   BrandProperDosageCounter = BrandProperDosageCounter;
       //     counter = BrandProperDosageCounter;

            countTBL = countTBL + 1;
            //alert("call AddBrandProperDosageDefaultRow");
            //first row of table - start
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('routeofadmin').each(function () {
                    var $option = $(this).text();
                    var $val = $(this).attr("value");
                  
                    $('<option" value="' + $val + '">' + $option + '</option>').appendTo('#tbDosageIn' + countTBL);
                  //  alert("DosageDefaultRow counter:" + counter);
                });
            });

            //get strength value
            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('value').each(function () {
            //        var $option = $(this).text();
            //        $('<option>' + $option + '</option>').appendTo('#tbStrengthValueIn' + counter); //tbUnitofMeasure
            //        //
            //        $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageValueIn' + counter);
            //    });
            //});

            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('value').each(function () {
            //        var $option = $(this).text();
            //        $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageValueIn' + counter);
            //    });
            //});

           

            //setup();
        }
        //end of setup default values on first row
        $(function () {
            $("#Button3").click(function () {
                $("div.mce-toolbar").hide();
            });
            $("#Button4").click(function () {
                $("div.mce-toolbar").show();
            });
        })

        var selectedschedulingsymbol;

        $(document).ready(function () {

            //reset image on change of dropdown list
            $("#tbSchedulingSymbol").change(function () {
                $('#imgSymbol').attr("src", "images/x.png");
            });

            //populate dropdown list
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('schedule').each(function () {
                    var $option = $(this).text();
                    var $val = $(this).attr("value");
                    $('<option style="width: 500px; height:40px;" value="' + $val + '">' + $option + '</option>').appendTo('#tbSchedulingSymbol');
                });
            }).done(function () {
                //if LoadFromXML assigned value to selectedschedulingsymbol
                $('#tbSchedulingSymbol option').each(function () { if ($(this).html() == selectedschedulingsymbol) { $(this).attr('selected', 'selected'); return; } });
            });

            //ching test table default row--work!
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('dosageform').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbDosageIn');
                }).done(function () {
                    $('#tbDosageIn').val("Select");
                 });
            });
           
         
         
            //get strength Unit
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('unit').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbStrengthUnitIn');
                }).done(function () {
                    $('#tbStrengthUnitIn').val("Select");
                });
            });
            //get strength per Dosage Unit
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find('unit').each(function () {
                    var $option = $(this).text();
                    $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnitIn');
                }).done(function () {
                    $('#tbStrengthperDosageUnitIn').val("Select");
                });
            });

        });

        function ApplySchedulingSymbol()
        {
            var selectedsymbol = $('#tbSchedulingSymbol').val();
            $.get('ControlledList.xml', function (xmlcontolledlist) {
                $(xmlcontolledlist).find(selectedsymbol).each(function () {    
                    $('#imgSymbol').attr("src", "scheduling symbol\\" + $(this).text());
                    $("#tbxmlimgnameSymbol").val($('#tbSchedulingSymbol option:selected').text());
                    $("#tbxmlimgfilenameSymbol").val($(this).text());
                });
            });
        }

        function testfucntion()
        {
            $('#tbSchedulingSymbol option').each(function () { if ($(this).html() == 'schedule 3') { $(this).attr('selected', 'selected'); return; }});
        }

</script> 
</asp:Content>

<asp:Content id="Content2" contentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<div class="row">
   <asp:Menu clientIDMode="Static" id="submenutabs" runat="server" Orientation="Horizontal" OnMenuItemClick="menutabs_MenuItemClick">
      <StaticMenuStyle VerticalPadding="5px" />
      <StaticMenuItemStyle HorizontalPadding="25px" />
      <Items>
          <asp:MenuItem text="Cover page" value="Coverpage" toolTip="Cover page"></asp:MenuItem>
          <asp:MenuItem text="Part I" value="PartOne" toolTip="Part I"></asp:MenuItem>
          <asp:MenuItem text="Part II" value="PartTwo" toolTip="Part II"></asp:MenuItem>
          <asp:MenuItem text="Part III" value="PartThree" toolTip="Part III"></asp:MenuItem>
          <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
      </Items>
   </asp:Menu>
</div>
<div class="row mrgn-tp-md">
    <asp:Button id="btnSaveDraft" runat="server" text="Save draft" onClick="btnSaveDraft_Click" cssClass="btn btn-default" ToolTip="Save draft file"/>
</div>
<!-- Main Content For Submenu Item of "Cover Page" and Use WET Standard -->
<div class="row">
   <h2 id="CoverPage" class="siteSubHeader" lang="en">Cover Page</h2>
</div>
<div class="row">
   <asp:Label runat="server" id="lblError" clientIDMode="Static" foreColor="Red"></asp:Label>
</div>
<div class="row hidden">       
   <input id="Button3" type="button" value="Hide" />
   <input id="Button4" type="button" value="Show" />
</div>       
<div class="row">
   <h3 class="h5" id="lblSchedulingSymbol" lang="en">Scheduling symbol</h3>
   <div class="col-lg-12">
       <select id="tbSchedulingSymbol" style="width: 220px; height:40px;"/>
       <input class="btn btn-default form-control mrgn-lft-sm" onclick="ApplySchedulingSymbol()" type="button" value="Apply symbol"/>
   </div>
</div>

<div class="row">
   <div class="symbolbrand" style="width:500px;">
       <h3 class="h5 text-hide" id="lblSchedulingSymbol2" lang="en">Scheduling symbol</h3>
       <div class="hidden"><asp:FileUpload id="fuBrnandSymbol" runat="server" width="400px"/></div>
       <div class="hidden"><asp:Button id="btnApplySumbol" runat="server" text="Apply symbol" width="130px" onClick="btnApplySumbol_Click" /></div>
       <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
          <img id="imgSymbol" src="images/x.png" width="100" height="100"/>
       </div>                      
       <input type="text" id="tbxmlimgnameSymbol" name="tbxmlimgnameSymbol" class="hidden" />
       <input type="text" id="tbxmlimgfilenameSymbol" name="tbxmlimgfilenameSymbol" class="hidden" />
    </div>
</div>
<!--Brand Table, Ching add test table -->
<section class="margin-top-medium"> 
<div class="form-group">
    <input class="btn btn-default btn-xs" type="button" value="Append Row" onclick="addRow('dataTable')" />
    <input class="btn btn-default btn-xs" type="button" value="Delete Row" onclick="deleteRow('dataTable')" />
    <span class="col-lg-3">&nbsp;</span>
    <input type="text" id="txtColumnName" placeholder="Please enter Column name" maxlength="100" />
    <input class="btn btn-default btn-xs" type="button" value="Append Column" id="btnAddCol" />
    <input class="btn btn-default btn-xs" type="button" value="Delete Last Column" id="btnDelCol" onClick="delCol('dataTable')"/> 
</div>
<div class="row table-responsive">
   <table id="dataTable" class="wb-tables table table-striped table-hover" data-wb-tables='{ "ordering": false; "bLengthChange": false;"bFilter": true;}'
       summary ="The Table of The Brand Dosage Form" title="The Brand Dosage Form">
        <thead>
            <tr>
                <th style="width: 26px"></th>
                <th style="width: 28px"></th>
                <th id="thBrandName" title="BrandName" style="width: 120px"><label id="tbBName">Brand name</label><br />&nbsp;</th>
                <th id="thProperName" title="ProperName" style="width: 120px"><label id="tbPName">Proper name</label><br />&nbsp;</th>
                <th id="thDosageForm" title="DosageForm" style="width: 121px"><label id="tbDForm">Dosage form</label><br />&nbsp;</th>
                <th id="thStrength" title="Strength" style="width: 158px"><label id="tbStrength"> Strength</label><br /><label id="tbSValue">Value</label> | <label id="tbSUnit">Unit</label></th>
                <th id="thStrengthPerDosage" title="StrengthPerDosage" style="width: 158px"><label id="">Strength per dosage</label><br /><label id="tbDValue">Value</label> | <label id="tbDUnit">Unit</label></th>   
            </tr>
        </thead>
        <tbody>
           <tr>
               <td style="width: 26px"><input type="checkbox" id="tbChkRemove" /></td>
               <td style="width: 28px"><input type="button" id="tbBtnRemove" class="btn btn-default btn-xs" onclick="deleteRowBtnRow(this)" name="btnDelete" value="X" /></td>   
               <th headers="thBrandName" style="width: 120px"><input type="text" id="tbBrandnameIn" /></th>
               <td headers="thProperName" style="width: 120px"><input type="text" id="tbPropernameIn" /></td>
               <td headers="thDosageForm" style="width: 121px">
                    <select id="tbDosageIn" style="width: 120px">
                    </select></td>                
               <td headers="thStrength" style="width: 158px">
                   <input type="number" id="tbStrengthValue" value="0" style="width: 52px"/>
                 
                                    <select id="tbStrengthUnitIn" style="width: 90px">             
                                    </select>
                                
               </td>
               <td headers="thStrengthPerDosage" style="width: 158px">
                   <input type="number" id="tbStrengthperDosageValue" value="0" style="width: 52px"/>                     
                                  
                                    <select id="tbStrengthperDosageUnitIn" style="width: 90px">
                                    </select>                               
                    </td>
          </tr>
       </tbody>
   </table> 
</div>
</section>
<section class="margin-top-medium table-response hidden">
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <label id="lblBrandname" lang="en" class="text-info">Brand name</label>
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <label id="lblPropername" lang="en" class="text-info">Proper name</label>
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <label id="lblDosageForm" lang="en" class="text-info">Dosage form</label>
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <div style="clear:both; width:100%; padding:2px;"><label id="lblStrength" lang="en" class="text-info">Strength</label></div>
        <div style="width:49%; float:left; padding:2px;"><label id="lblValue1" lang="en" class="text-info">Value</label></div>
        <div style="width:49%; float:left; padding:2px;"><label id="lblUnit" lang="en" class="text-info">Unit</label></div>
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <div style="clear:both; width:100%; padding:2px;"><label id="lblStrengthPerDosage" lang="en" class="text-info">Strength per Dosage</label></div>
        <div style="width:49%; float:left; padding:2px;"><label id="lblValue2" lang="en" class="text-info">Value</label></div>
        <div style="width:49%; float:left; padding:2px;"><label id="lblUnit2" lang="en" class="text-info">Unit</label></div>
    </div>
    <div style="width:initial; float:left; padding-left:0px;">  
        <input class="btn btn-default btn-xs" onclick="AddBrandProperDosageTextBox()" id="btnAddBrandProperDosage"  type="button" value="Add"/>
    </div> 
</section>
<section  class="margin-bottom-small">
  <div id="dvExtraBrandProperDosage" style="clear:both;">

   </div>   
</section>
<!--End of Brand Table -->
<section class="margin-top-medium">  
    <div>    
        <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="PharmaceuticalStandard">Pharmaceutical standard (if applicable)</h3></div>                             
        <asp:TextBox id="tbPharmaceuticalStandard" runat="server" Width="400" CausesValidation="True" MaxLength="200"></asp:TextBox>                                
    </div>
</section>
<section>
    <div>          
        <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="TherapeuticClassification">Therapeutic classification</h3></div>                       
        <asp:TextBox id="tbTherapeuticClassifications" runat="server" Width="400"></asp:TextBox>                                
    </div>
</section>
<section>
    <div>
        <div>    
            <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="lblSponsorName" lang="en">Sponsor name</h3></div>                                    
            <asp:TextBox runat="server" id="tbSponsorName" width="400"></asp:TextBox>                                
        </div>
        <div>                                        
            <div style="padding: 20px 4px 4px 0px; display:inline-block; width:400px;">
                <h3 class="h5" id="lblSponsorAddress" lang="en">Sponsor address</h3>&nbsp;&nbsp;&nbsp;
                <div style="float:left; color:red; font-weight:bold; width:400px;"></div>
           </div><div style="width:600px">
                <textarea runat="server" id="tbSponsorAddress" class="textarea" lang="en" style="Width:400px"></textarea>
            </div>
        </div>
    </div>
</section>
<section>
   <div style="float:left; width:340px; height:40px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;"><h3 class="h5" id="lblDateOfPreparation" lang="en">Date of preparation</h3></div>
        <asp:TextBox runat="server" id="tbDatePrep" width="250" readonly="true"></asp:TextBox>
        <cc1:CalendarExtender id="tbDatePrep_CalendarExtender" runat="server" targetControlID="tbDatePrep" format="yyyy-MM-dd"/>
        &nbsp;&nbsp;<label lang="en" id="lblAndOr">and/or</label> 
   </div>
   <div style="float:left; width:270px; height:30px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;"><h3 class="h5" id="lblDateOfRevision" lang="en">Date of revision</h3></div>
        <asp:TextBox runat="server" id="tbDateRev" width="250" readonly="true"></asp:TextBox>
        <cc1:CalendarExtender id="CalendarExtender2" runat="server" targetControlID="tbDateRev" format="yyyy-MM-dd" />
   </div>
   <div style="float:left; width:600px; clear:both; display:block; padding-top:40px;">
       <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="SubmissionControlNo">Submission Control No:</h3></div>              
       <asp:TextBox id="tbControNum" runat="server" maxLength="6" width="250"></asp:TextBox>
       <cc1:FilteredTextBoxExtender id="tbControNum_FilteredTextBoxExtender" filterType="Numbers" runat="server" targetControlID="tbControNum" />
   </div>
   <div style="float:left; width:600px; clear:both; display:block;">                                                    
       <div style="padding: 20px 4px 4px 0px; display:inline-block; width:400px; margin-top: 0px;">
           <h3 class="h5" id="footnote">Footnote</h3>&nbsp;&nbsp;&nbsp;</div>
           <div style="float:left; color:red; font-weight:bold; width:200px;"></div>           
           <textarea id="tbFootnote" runat="server" class="textarea"></textarea>               
   </div>
</section>
<section>
    <asp:Menu clientIDMode="Static" id="submenutabsbottom" runat="server" orientation="Horizontal" onMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle verticalPadding="5px" />
        <StaticMenuItemStyle horizontalPadding="25px" />
        <Items>
            <asp:MenuItem text="Cover page" value="Coverpage" toolTip="Cover page"></asp:MenuItem>
            <asp:MenuItem text="Part I" value="PartOne" toolTip="Part I"></asp:MenuItem>
            <asp:MenuItem text="Part II" value="PartTwo" toolTip="Part II"></asp:MenuItem>
            <asp:MenuItem text="Part III" value="PartThree" toolTip="Part III"></asp:MenuItem>
            <asp:MenuItem text="Form instruction" value="PMForm" toolTip="Back to the main page of DHPR form with form Instruction"></asp:MenuItem>
        </Items>
    </asp:Menu>
</section>

    <SCRIPT>
        var newRowCount = 0;
        //Following functions are created by Ching Chang on Feb 8, 2016
        function addRow(tableID) {
            var table = document.getElementById(tableID);
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            var colCount = table.rows[1].cells.length;

            try {
                newRowCount = newRowCount + 1;
                if(newRowCount < 50) {
                    for (var i = 0; i < colCount; i++) {
                        var newcell = row.insertCell(i);
                        newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                     //   alert("id: " + newcell.childNodes[0].id);
                      //  newcell.childNodes[0].id = newcell.childNodes[0].id + newRowCount;
                        switch (newcell.childNodes[0].type) {
                            case "text":
                                newcell.childNodes[0].value = "";
                                break;
                            case "checkbox":
                                newcell.childNodes[0].checked = false;
                                break;
                            case "select-one":
                                newcell.childNodes[0].selectedIndex = 0;
                                break;
                            case "button":
                                newcell.childNodes[0].clicked = false;
                        }
                    }
                }              
                else
                {
                    alert("You reach Max row number 50, thanks!");
                } 
         
            } catch(e)
           {
               alert(e);
           }
        }
 
        function deleteRow(tableID) {
            var table = document.getElementById(tableID);
            var rowCount = table.rows.length;
            try {
               for(var i=0; i<rowCount; i++) {
                 var row = table.rows[i];
                 var chkbox = row.cells[0].childNodes[0];
               
                  if(null != chkbox && true == chkbox.checked) {
                    if(rowCount <= 1) {
                        alert("Cannot delete all the rows.");
                        break;
                    }
                    table.deleteRow(i);
                    rowCount--;
                    i--;
                 }
               }
            } catch(e) {
                alert(e);
            }
        }
        function deleteRowBtnRow(r) {
            var i = r.parentNode.parentNode.rowIndex;
            var row = document.getElementById("dataTable").rows[i];

            var chkbox = row.cells[0].childNodes[0];
            if (null != chkbox && true == chkbox.checked) {
                if (i < 1) {
                    alert("Cannot delete all the rows.");

                }
                else
                    document.getElementById("dataTable").deleteRow(i);

            }
        }
        function addCol(dTable) {
            var tbl = document.getElementById("dataTable"); // table reference
            var i;    // open loop for each row and append cell 
           
            for (i = 0; i < tbl.rows.length; i++) {        
                createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, 'txtColumnName');  //column name work!
            }
        }
        function delCol(dTable) {
           var tbl = document.getElementById("dataTable");
           var i, j;
           var rowCount = tbl.rows.length;
         
           var lastCol = tbl.rows[0].cells.length - 1;    // set the last column index
      
           for (j = 0; j < rowCount; j++) {
               var row = tbl.rows[j];
              //alert("row column length: " + row.cells.length);
              for (i = 0; i <= row.cells.length; i++) {
                 if (i == lastCol)
                    row.deletecell(i);
              }   
           }
         }
            
        //appendColumn() not put into use yet by Ching Chang   
        function appendColumn() {   
            var tbl = document.getElementById('datatable'); // table reference
            var colName = document.getElementById('txtColumnName');
                i;    // open loop for each row and append cell   
            for (i = 0; i < tbl.rows.length; i++) {
                if (i == 0)
                {

                    createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, colName.value());
                }
                else
                {
                    createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, colName.value());
                }
              //  createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, 'col');
            }
        }
        //JQUERY Add Column
        var columnCount = 0;
        $('#btnAddCol').click(function () {
           
            if ($('#txtColumnName').val()) {
                //check the new entry of column name, if it is same as the name in the last column, push the user to make a change...
               // if ($('#dataTable thead tr>td:last').val() == $('#txtColumnName').val())
                  //  alert("Please enter a new column name, not the same as existing column name");
                var noOfColumns = $('#dataTable thead tr th').length;
                //if the table column length is over 25, it stops adding
                if (columnCount < 25) {
                   $('#dataTable tr').append($("<td>"));

                   $('#dataTable thead tr>td:last').html($('#txtColumnName').val());  //this code is working
                    //add textbox count, then save it into XML

                   $('#dataTable tbody tr').each(function () { $(this).children('td:last').append($('<input type="textbox">')) });
                      columnCount = columnCount + 1;
                 } else
                    alert('Max Column number is 25');
                } else { alert('Enter Column name first'); }
            });
        //JQUERY Remove Column
        $('#btnDelCol').click(function () {
                //if table column length is over 7, it stops deleting

            if (columnCount > 0) {
                $("#dataTable th:last-child, #dataTable td:last-child").remove();
                columnCount = columnCount - 1;
            }     
            else
               alert('We should keep origial Columns.');
            });
       
    </SCRIPT>
<asp:HiddenField runat="server" id="hdBrandProperDosage" clientIDMode="Static" />
<!-- End of Main Content For Submenu Item of "Cover Page" -->
</asp:Content>

