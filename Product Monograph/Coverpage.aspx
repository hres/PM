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

            ////table - start
            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('dosage').each(function () {
            //        var $option = $(this).text();
            //        //var $val = $(this).attr("value");
            //        $('<option>' + $option + '</option>').appendTo('#tbDosage0');
            //    });
            //});
            //$.get('ControlledList.xml', function (xmlcontolledlist) {
            //    $(xmlcontolledlist).find('unit').each(function () {
            //        var $option = $(this).text();
            //        //var $val = $(this).attr("value");
            //        $('<option>' + $option + '</option>').appendTo('#tbUnitofMeasure0');
            //    });
            //});
            ////table - end


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
<asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>
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
<div class="form-group">
<div class="row">
   <h2 id="CoverPage" lang="en">Cover Page</h2>
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
<!--Brand Table -->
<section class="margin-top-medium">
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
<section>
  <div id="dvExtraBrandProperDosage" style="clear:both;">
   </div>   
</section>
<!-- End of Brand Table -->
<section class="margin-top-medium">  
    <div>    
        <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="PharmaceuticalStandard">Pharmaceutical standard (if applicable)</h3></div>                             
        <asp:TextBox id="tbPharmaceuticalStandard" runat="server" Width="400" CausesValidation="True" MaxLength="200"></asp:TextBox>                                
    </div>
</section>
<section>
    <div>          
        <div style="padding: 20px 4px 4px 0px"><h3 class="h5" id="TherapeuticClassification">Therapeutic Classification</h3></div>                       
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
            </div>
            <textarea runat="server" id="tbSponsorAddress" class="textarea" lang="en" Width="400"></textarea>
        </div>
    </div>
</section>
<section>
   <div style="float:left; width:340px; height:40px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;"><h3 class="h5" id="lblDateOfPreparation" lang="en">Date of preparation</h3></div>
        <asp:TextBox runat="server" id="tbDatePrep" width="250" readOnly="true"></asp:TextBox>
        <cc1:CalendarExtender id="tbDatePrep_CalendarExtender" runat="server" targetControlID="tbDatePrep" format="yyyy-MM-dd"/>
        &nbsp;&nbsp;<label lang="en" id="lblAndOr">and/or</label> 
   </div>
   <div style="float:left; width:270px; height:30px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;"><h3 class="h5" id="lblDateOfRevision" lang="en">Date of revision</h3></div>
        <asp:TextBox runat="server" id="tbDateRev" width="250" readOnly="true"></asp:TextBox>
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
<asp:HiddenField runat="server" id="hdBrandProperDosage" clientIDMode="Static" />
</asp:Content>

