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
        //excluded the cover page
        function RemoveBrandProperDosageTextBox(i) {
            var rowid = "#BrandProperDosage" + i;
            if (counter <= 1) {
               alert("We could not delete all the rows");
            }
            else
               $(rowid).remove();
        }
        //excluded the cover page
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
        //no use in cover page
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
            setup();
        }
        //no use in cover page
        function GetAddBrandProperDosageTextBoxDynamicTextBox(id) {
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
                    '</div>';    
        }
        //Setup default values on first row of Dosage Form --- created by Ching Chang on Feb 8, 2016
        var countTBL = 0
        function AddBrandProperDosageDefaultRow() {
           //first row of table - start
           $.get('ControlledList.xml', function (xmlcontolledlist) {
              $(xmlcontolledlist).find('dosageform').each(function () {
                 var $option = $(this).text();
                 $('<option>' + $option + '</option>').appendTo('#tbDosage');
              }).done(function () {
                 $('#tbDosageIn').val("Select");
              });
           });
          //get strength Unit
          $.get('ControlledList.xml', function (xmlcontolledlist) {
              $(xmlcontolledlist).find('unit').each(function () {
                 var $option = $(this).text();
                 $('<option>' + $option + '</option>').appendTo('#tbStrengthUnit');
              }).done(function () {
                 $('#tbStrengthUnitIn').val("Select");
              });
          });
          //get strength per Dosage Unit
          $.get('ControlledList.xml', function (xmlcontolledlist) {
             $(xmlcontolledlist).find('unit').each(function () {
                 var $option = $(this).text();
                 $('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit');
             }).done(function () {
                 $('#tbStrengthperDosageUnitIn').val("Select");
             });
         });
 
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

            //ching created table default row
            AddBrandProperDosageDefaultRow();
         
            $.webshims.polyfill('forms forms-ext');
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
          <asp:MenuItem value="PMForm"></asp:MenuItem>
          <asp:MenuItem value="Coverpage"></asp:MenuItem>
          <asp:MenuItem value="PartOne"></asp:MenuItem>
          <asp:MenuItem value="PartTwo"></asp:MenuItem>
          <asp:MenuItem value="PartThree"></asp:MenuItem>
      </Items>
   </asp:Menu>
</div>
<div class="row mrgn-tp-md">
   <asp:Button id="btnSaveDraft" runat="server" onClick="btnSaveDraft_Click" cssClass="btn btn-default" />
</div>
<!-- Main Content For Submenu Item of "Cover Page" and Use WET Standard -->
<div class="margin-top-medium">
   <asp:Label id="CoverPage" runat="server" CssClass="h2"></asp:Label>
</div>
<div class="row">
   <asp:Label runat="server" id="lblError" clientIDMode="Static" foreColor="Red" Visible="false" ></asp:Label>
</div>
<div class="row hidden">       
   <input id="Button3" type="button" value="Hide" />
   <input id="Button4" type="button" value="Show" />
</div>
<div class="form-group margin-top-medium">
  <div class="row">
  <div class="col-sm-2">
     <Label id="lblSchedulingSymbol" for="tbSchedulingSymbol" runat="server" >:</Label>
  </div>
  <div class="col-sm-2">
     <select ID="tbSchedulingSymbol" onchange="ApplySchedulingSymbol()" class="form-control width_120px"></select> 
  </div>
  <div class="col-sm-4">
     <div class="hidden">
        <asp:FileUpload id="fuBrnandSymbol" runat="server" />
        <asp:Button id="btnApplySumbol" runat="server" onClick="btnApplySumbol_Click" class="btn btn-default btn-sm" />
     </div>
       <img id="imgSymbol" src="images/x.png" width="100" height="100" alt="Apply symbol"/>                     
     <input type="text" id="tbxmlimgnameSymbol" name="tbxmlimgnameSymbol" class="hidden" />
     <input type="text" id="tbxmlimgfilenameSymbol" name="tbxmlimgfilenameSymbol" class="hidden" /> 
  </div>
</div>
</div>

<!--Brand  Dosage Form Table -->
<div class="margin-top-medium"> 
<div class="form-group left">
    <input class="btn btn-default btn-xs" type="button" runat="server" id="btnAppendRow" onclick="addRow('dataTable')" />
    <input class="btn btn-default btn-xs" type="button" runat="server" id="btnDeleteRow" onclick="deleteRow('dataTable')" />
    <label id="lblBrandMsg" class="text">&nbsp;</label>
    <!-- <input type="text" id="txtColumnName" name="txtColumnName" placeholder="Please enter Column name" maxlength="100" />
       <input class="btn btn-default btn-xs" type="button" value="Append Column" runat="server" id="btnAddCol" />
       <input class="btn btn-default btn-xs" type="button" value="Delete Last Column" runat="server" id="btnDelCol" onClick="delCol('dataTable')" /> 
       <input class="btn btn-default btn-xs" type="button" value="Save Your Column" runat="server" id="btnSaveCol" hidden onClick="saveCol('dataTable')" /> 
       <asp:HiddenField ID="ColNameList" runat="server" />
    -->
</div>
</div>
<div class="form-group left">
<div class="row table-responsive">
   <table id="dataTable" class="wb-tables table table-striped table-hover" data-wb-tables='{ "ordering": false; "bLengthChange": false;"bFilter": true;}'
        title="The Brand Dosage Form">
       <caption></caption>
        <thead>
            <tr>
                <th></th>
                <th></th>
                <th scope="col" id="thBrandName" title="BrandName"><Label id="tbBName" runat="server"></Label><br />&#32;</th>
                <th scope="col" id="thProperName" title="ProperName"><Label id="tbPName" runat="server"></Label><br />&#32;</th>
                <th scope="col" id="thDosageForm" title="DosageForm"><Label id="tbDForm" runat="server"></Label><br />&#32;</th>
                <th scope="col" id="thStrength" title="Strength"><Label id="tbStrength" runat="server"></Label><br /><label id="tbSValue" runat="server"></label> | <label id="tbSUnit" runat="server"></label></th>
                <th scope="col" id="thStrengthPerDosage" title="StrengthPerDosage" ><asp:Label id="lblStrengthperDosage" runat="server"></asp:Label><br /><label id="tbDValue" runat="server"></label> | <label id="tbDUnit" runat="server" ></label></th>   
            </tr>
        </thead>
        <tbody>
           <tr>
               <td><input type="checkbox" id="tbChkRemove" /></td>
               <td><input id="tbBtnRemove" type="button" onclick="deleteRowBtnRow(this)" name="btnDelete" value="X" class="btn btn-default btn-xs" /></td>   
               <th headers="thBrandName" data-required="true"><input type="text" id="tbBrandname" name="tbBrandname" class="form-control" /></th>
               <td headers="thProperName"><input type="text" id="tbPropername" name="tbPropername" class="form-control" /></td>
               <td headers="thDosageForm">
                   <select id="tbDosage" name="tbDosage" class="form-control" style="font-size: medium" >
                   </select></td>                
               <td headers="thStrength">
                   <input type="number" id="tbStrengthValue" name="tbStrengthValue" value="0" class="form-control" />
                   <select id="tbStrengthUnit" name="tbStrengthUnit" class="form-control" style="font-size: medium" >             
                   </select>            
               </td>
               <td headers="thStrengthPerDosage">
                   <input type="number" id="tbStrengthperDosageValue" name="tbStrengthperDosageValue" value="0" class="form-control" />                     
                   <select id="tbStrengthperDosageUnit" name="tbStrengthperDosageUnit" class="form-control" style="position: inherit; font-size: medium;" >
                   </select>                               
               </td>
          </tr>
       </tbody>
   </table> 
</div>
</div>
<!--<section class="margin-top-medium table-response hidden">
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
</section> -->
<!--End of Brand Table -->
<div class="form-group">
    <div class="margin-top-medium">  
         <asp:Label id="PharmaceuticalStandard"  AssociatedControlID="tbPharmaceuticalStandard" runat="server" CssClass="control-label"></asp:Label>                             
    </div>
    <div class="row"> 
         <div class="col-xs-10 text-left"> 
           <asp:TextBox id="tbPharmaceuticalStandard" runat="server" CausesValidation="True" MaxLength="200" CssClass="form-control"></asp:TextBox>                                
         </div>
    </div>
</div>
<div class="form-group">
    <div class="margin-top-medium">           
        <asp:Label id="TherapeuticClassification" AssociatedControlID="tbTherapeuticClassifications" runat="server" CssClass="control-label"></asp:Label>                       
    </div>
    <div class="row"> 
        <div class="col-xs-10 text-left"> 
          <asp:TextBox id="tbTherapeuticClassifications" runat="server" CausesValidation="True" MaxLength="200" CssClass="form-control"></asp:TextBox>    
        </div>                            
    </div>
</div>
<div class="form-group">
    <div class="margin-top-large">     
        <asp:Label id="lblSponsorName" AssociatedControlID="tbSponsorName" runat="server" CssClass="control-label"></asp:Label>  
    </div>
    <div class="row"> 
        <div class="col-xs-10 text-left">                                      
           <asp:TextBox id="tbSponsorName" runat="server" CausesValidation="True" MaxLength="200" CssClass="form-control"></asp:TextBox>                                
        </div>  
    </div>
    <div class="margin-top-medium">                                                 
        <asp:label ID="lblSponsorAddress" AssociatedControlID="tbSponsorAddress" runat="server" CssClass="control-label"></asp:label>           
    </div>
    <div class="row"> 
        <div class="col-xs-10 text-left">         
            <textarea id="tbSponsorAddress" name="tbSponsorAddress" runat="server" class="textarea form-control"></textarea>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row margin-top-medium">
       <div class="col-sm-3 left">
           <asp:Label ID="lblDateOfPreparation" AssociatedControlID="tbDatePrep" runat="server" CssClass="control-label"><span class="field-name"></span><span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span></asp:Label>
           <asp:TextBox runat="server" id="tbDatePrep" CssClass="form-control" type="date" data-rule-dateiso="true"></asp:TextBox>   
       </div>
       <div class="col-sm-1 text-left">
           <strong><asp:label id="lblAndOr" runat="server" CssClass="control-label"></asp:label></strong> 
       </div>
       <div class="col-sm-5 text-left">
           <asp:Label ID="lblDateOfRevision" AssociatedControlID="tbDateRev" runat="server" CssClass="control-label"><span class="field-name"></span><span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span></asp:Label>
           <asp:TextBox runat="server" id="tbDateRev" CssClass="form-control" type="date" data-rule-dateiso="true" ></asp:TextBox>
       </div>
   </div>
</div>
<div class="form-group">
   <div class="margin-top-medium">
       <asp:label id="SubmissionControlNo" runat="server" AssociatedControlID="tbControNum" CssClass="control-label"></asp:Label>
   </div>   
   <div class="row"> 
       <div class="col-xs-10 text-left">            
          <asp:TextBox id="tbControNum" runat="server" maxLength="6" CssClass="form-control"></asp:TextBox>
          <cc1:FilteredTextBoxExtender id="tbControNum_FilteredTextBoxExtender" filterType="Numbers" runat="server" targetControlID="tbControNum" />
       </div>
   </div>
</div>
<div class="form-group">
   <div class="margin-top-large">
       <asp:Label id="footnote" runat="server" AssociatedControlID="tbFootnote" CssClass="control-label"></asp:Label>
   </div>
   <div class="row"> 
       <div class="col-xs-10 text-left">           
           <textarea id="tbFootnote" name="tbFootnote" runat="server" class="textarea form-control"></textarea>               
      </div> 
   </div>
</div>
<div class="form-group">
  <div class="row margin-top-medium">
    <asp:Menu clientIDMode="Static" id="submenutabsbottom" runat="server" orientation="Horizontal" onMenuItemClick="submenutabsbottom_MenuItemClick">
        <StaticMenuStyle verticalPadding="5px" />
        <StaticMenuItemStyle horizontalPadding="25px" />
        <Items>
            <asp:MenuItem value="PMForm"></asp:MenuItem>
            <asp:MenuItem value="Coverpage"></asp:MenuItem>
            <asp:MenuItem value="PartOne"></asp:MenuItem>
            <asp:MenuItem value="PartTwo"></asp:MenuItem>
            <asp:MenuItem value="PartThree"></asp:MenuItem>
       </Items>
    </asp:Menu>
  </div>
</div>
   
    <SCRIPT>
        //Following functions are created by Ching Chang on Feb 8, 2016
        var newRowCount = 0;
        function addRow(tableID) {
            var table = document.getElementById(tableID);
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            var colCount = table.rows[1].cells.length;
            var selectCount = 0;
            try {
                newRowCount = newRowCount + 1;
                if(newRowCount < 50) {
                    for (var i = 0; i < colCount; i++) {
                        var newcell = row.insertCell(i);
                        newcell.innerHTML = table.rows[1].cells[i].innerHTML;  
                        newcell.type = table.rows[1].cells[i].nodeType;
                        switch (newcell.childNodes[0].type) {
                            case "text":
                                newcell.childNodes[0].value = "";
                                newcell.childNodes[0].id = newcell.childNodes[0].id + newRowCount;  //BrandName and ProperName textbox
                                break;
                            case "checkbox":
                                newcell.childNodes[0].checked = false;
                                break;
                            case "select-one":
                                newcell.childNodes[0].selectedIndex = 0;
                                break;
                            case "button":
                                newcell.childNodes[0].clicked = false;
                                break;                 
                        }
                        if (i == 4) 
                            newcell.childNodes[0].id = "tbDosage" + newRowCount;  //Dosage-Form  select
                        else if (i == 5)
                        {
                            newcell.childNodes[0].id = "tbStrengthValue" + newRowCount;   //first item in fifth column is spinner
                            newcell.childNodes[1].id = "tbStrengthUnit" + newRowCount;   //second item in fifth column is select    
                        }   
                        else if (i == 6)
                        {   
                            newcell.childNodes[0].id = "tbStrengthperDosageValue" + newRowCount;   //first item in sixth column is spinner
                            newcell.childNodes[1].id = "tbStrengthperDosageUnit" + newRowCount;   //second item in sixth column is select
                        }
                    }
                }              
                else
                {
                    alert("You reach Max row number 20, thanks!");
                } 
         
            } catch(e)
           {
               alert(e);
           }
        }
        //delete button on top -- delete multiple selected rows
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
        //delete Row icon action -- only delete one row
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
        //not use in the page
        function addCol(dTable) {
            var tbl = document.getElementById("dataTable"); // table reference
            var i;    // open loop for each row and append cell 
           
            for (i = 0; i < tbl.rows.length; i++) {        
                createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, 'txtColumnName');  //column name work!
            }
        }
        //not use in the page
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
        //appendColumn() not use  
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
            }
        }
        //JQUERY Add Column
        var columnCount = 0;
        var newColNames = {};
        $('#btnAddCol').click(function () {
            var IsBlock = false;
            var rowCountForCol = 0;
            var newColID = "";
            if ($('#txtColumnName').val()) {
                //check the new entry of column name, if it is same as the name in the last column, push the user to make a change...    
                $('#dataTable thead th').each(function () {
                    var Colname = $(this).text();
                    if ($.trim($('#txtColumnName').val()) == $.trim(Colname)) {
                        alert("Please enter a new column name, not the same as existing column name");
                        $('#txtColumnName').empty();
                        IsBlock = true;
                    }
                });
                if (IsBlock == false) {
                    newColNames[columnCount] = $('#txtColumnName').val();  
                    var noOfColumns = $('#dataTable thead tr th').length;
                    //if the table column length is over 25, it stops adding
                    if (columnCount < 25) {
                        $('#dataTable tr').append($("<td>"));
                        //add header text by input column name
                        $('#dataTable thead tr>td:last').html($('#txtColumnName').val()); 
                        $('#dataTable tbody tr').each(function () {                       
                            newColID = newColNames[columnCount] + rowCountForCol;  //append new column name with row count
                            $(this).children('td:last').append($('<input type="textbox"> id="' + newColID + '" name="' + newColID + '" ')) 
                            rowCountForCol = rowCountForCol + 1;
                            newColID = "";
                        });
                        //Test--pass new colcount to C# function -- SaveIntoMemoory()
                        //document.getElementById('<%=ColNameList.ClientID%>').value = columnCount;    
                        columnCount = columnCount + 1; //add column count
                    } else
                        alert('Max Column number is 25');
                }
            } else { alert('Enter Column name first'); }
            });
        //JQUERY Remove Column
        $('#btnDelCol').click(function () {
            //if table column length is over 7, it stops deleting
            if (columnCount > 1) {
                $("#dataTable th:last-child, #dataTable td:last-child").remove();
                newColNames[columnCount] = ""; //clear the last column name
                columnCount = columnCount - 1;
            }     
            else
               alert('We should keep origial Columns.');
        });
        //ching test save into XML file =-- in action
        $('#btnSaveCol').click(function () {
            var coldata = [];
            var noOfRow = $('#dataTable tbody tr').length;
            var j = 0;
          
            if (columnCount > 0) {
                for (j = 0; j < columnCount; j++) {
                    alert(newColNames[j]);
                   // alert($('#" + newColNames[j] + noOfRow + "' ).val());
                }
            }
            else
                alert('click Save btn');

        });
        //for test-- not in action
        function saveCol(tableID) {
            //get all values in the new columns and save into the XML file
            var tbl = document.getElementById(tableID); // table reference
            var colName = document.getElementById('txtColumnName');
            i;    // open loop for each row and append cell   
            //for (i = 0; i < tbl.rows.length; i++) {
            //    if (i == 0) {
            //        createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, colName.value());
            //    }
            //    else {
            //        createCell(tbl.rows[i].insertCell(tbl.rows[i].cells.length), i, colName.value());
            //    }
            //}
            // alert(colName.value);
            xmlDoc = xhttp.responseXML;  // sets global variable xmlDoc as xml object == sessionID.xml 
        }
    </SCRIPT>

<asp:HiddenField runat="server" id="hdBrandProperDosage" clientIDMode="Static" />
<!-- End of Main Content For Submenu Item of "Cover Page" -->
</asp:Content>

