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
                        '<div style="width:50%; float:left; border:1px solid #D9D9D9;">' +
                            '<input type="number" id="' + stv + '" name="tbStrengthValue" style="width:100%; border:0px; height:38px;" />' +
                        '</div>' +
                        '<div style="width:50%; float:left; border:1px solid #D9D9D9;">' +
                            '<select id="' + stu + '" name="tbStrengthUnit" style="width:100%; height:38px; border:0px;" ></select>' +
                        '</div>' +
                    '</div>' + 
                    '<div style="width:18.88%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">' +
                        '<div style="width:50%; float:left; border:1px solid #D9D9D9;">' +
                            '<input type="number" id="' + stpdv + '" name="tbStrengthperDosageValue" style="width:100%; border:0px; height:38px;" />' +
                        '</div>' +
                        '<div style="width:50%; float:left; border:1px solid #D9D9D9;">' +
                            '<select id="' + stpdu + '" name="tbStrengthperDosageUnit" style="width:100%; height:38px; border:0px;" ></select>' +
                        '</div>' +
                    '</div>' +  
                    '<div style="width:5%; float:left; padding-left: 0px;">' +
                        '<input style="cursor:pointer !important; width:58px; height:40px; font-size:12px; padding-left:2px;" onclick="RemoveBrandProperDosageTextBox(' + id + ')" type="button" value="REMOVE" />' +
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

<section style="clear:both; text-align:left; padding-top: 8px; padding-left: 0px;">
    <asp:Button ID="btnSaveDraft" runat="server" Text="Save draft" OnClick="btnSaveDraft_Click"/>
</section>

<div style="float:left; padding:10px 10px 10px 0px; clear:both;">
    <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
</div>

<div style="clear:both; padding:10px 10px 10px 10px; display:none;">       
    <input id="Button3" type="button" value="Hide" />
    <input id="Button4" type="button" value="Show" />
</div>    
    
<div style="width:90%; clear:both; display:block; padding-bottom:40px;">
    <div style="padding: 0px 0px 0px 0px; float:left; clear:both;">Scheduling symbol</div>
    <div style="float:left; padding: 10px 0px 15px 0px; clear:both;">
        <select id="tbSchedulingSymbol" style="width: 500px; height:40px;"/> 
        <input style="cursor:pointer !important; width:120px; height:40px; font-size:12px; margin-left:25px;" onclick="ApplySchedulingSymbol()"  type="button" value="APPLY SYMBOL"/>
    </div>
</div>

<div style="width:90%; clear:both; display:block; padding-left:0px; padding-bottom:20px;">
    <div  class="symbolbrand" style="width:500px;">
        <div style="padding: 4px 4px 4px 0px; float:left; display:none;">Scheduling symbol</div>
        <div style="clear:both; width:100%; padding: 4px 4px 4px 0px; display:none;"><asp:FileUpload ID="fuBrnandSymbol" runat="server" Width="400px"/></div>
        <div style="clear:both; width:100%; padding: 4px 4px 4px 0px; display:none;"><asp:Button ID="btnApplySumbol" runat="server" Text="Apply symbol" Width="130px" OnClick="btnApplySumbol_Click" /></div>
        <div style="clear:both; border:1px solid #D9D9D9; width:103px; height:103px; padding-top:4px;">
            <img id="imgSymbol" src="images/x.png"/>
        </div>                      
        <input type="text" id="tbxmlimgnameSymbol" name="tbxmlimgnameSymbol" style="display:none;" />
        <input type="text" id="tbxmlimgfilenameSymbol" name="tbxmlimgfilenameSymbol" style="display:none;" />
    </div>
</div>

<section style="width:90.2%; padding-left:0px; clear:both;">
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        Brand name
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        Proper name
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        Dosage Form
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <div style="clear:both; width:100%; padding:2px;">Strength</div>
        <div style="width:50%; float:left; padding:2px;">Value</div>
        <div style="width:50%; float:left; padding:2px;">Unit</div>
    </div>
    <div style="width:18.88%; float:left; border: 1px solid #D9D9D9; height:54px; padding:2px;">
        <div style="clear:both; width:100%; padding:2px;">Strength per Dosage</div>
        <div style="width:50%; float:left; padding:2px;">Value</div>
        <div style="width:50%; float:left; padding:2px;">Unit</div>
    </div>
    <div style="width:5%; float:left; padding-left:0px;">  
        <input style="cursor:pointer !important; width:58px; height:40px; font-size:12px;" onclick="AddBrandProperDosageTextBox()" id="btnAddBrandProperDosage"  type="button" value="ADD"/>
    </div>   
</section>

<div id="dvExtraBrandProperDosage" style="width:90.2%; padding-left: 0px; clear:both;">
</div>
    
<div style="width:84.5%; text-align:center; clear:both; display:block; padding-left: 0px;">
    <div style="text-align:left;">    
        <div style="padding: 20px 4px 4px 0px">Pharmaceutical standard (if applicable)</div>                             
            <asp:TextBox ID="tbPharmaceuticalStandard" runat="server" Width="400"></asp:TextBox>                                
    </div>
</div>

<div style="width:84.5%; text-align:center; clear:both; display:block; padding-left: 0px;">
    <div style="text-align:left;">          
        <div style="padding: 20px 4px 4px 0px">Therapeutic Classification</div>                       
            <asp:TextBox ID="tbTherapeuticClassifications" runat="server" Width="400"></asp:TextBox>                                
    </div>
</div>

<div style="width:84.5%; clear:both; padding-left: 0px;">
    <div>
        <div>    
            <div style="padding: 20px 4px 4px 0px">Sponsor name</div>                                    
            <asp:TextBox runat="server" ID="tbSponsorName" Width="400"></asp:TextBox>                                
        </div>
        <div>                                        
            <div style="padding: 20px 4px 4px 0px; display:inline-block; width:400px;">
                <div style="width:150px; float:left;">Sponsor address&nbsp;&nbsp;&nbsp;</div>
                <div style="float:left; color:red; font-weight:bold; width:200px;"></div>
            </div>
            <textarea runat="server" id="tbSponsorAddress" class="textarea"></textarea>
        </div>
    </div>
</div>

<div style="width:84.5%; clear:both; padding-left: 0px;">
    <div style="float:left; width:270px; height:40px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;">Date of Preparation:</div>
        <asp:TextBox runat="server" ID="tbDatePrep" Width="250" ReadOnly="true"></asp:TextBox>
        <cc1:CalendarExtender ID="tbDatePrep_CalendarExtender" runat="server" TargetControlID="tbDatePrep" Format="yyyy-MM-dd"/>
    </div>
    <div style="float:left; width:70px; height:40px; vertical-align:bottom;">
        <div style="height:40px;">&nbsp;</div>
        <div>and/or</div>
    </div>
    <div style="float:left; width:270px; height:30px;">
        <div style="padding: 20px 4px 4px 0px; clear:both;">Date of Revision:</div>
        <asp:TextBox runat="server" ID="tbDateRev" Width="250" ReadOnly="true"></asp:TextBox>
        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbDateRev" Format="yyyy-MM-dd" />
    </div>
</div>

<div style=" width:84.5%; clear:both; padding-left: 0px; display:block; padding-top:40px;">
    <div style="padding: 20px 4px 4px 0px">Submission Control No:</div>              
    <asp:TextBox ID="tbControNum" runat="server" MaxLength="6" Width="250"></asp:TextBox>
    <cc1:FilteredTextBoxExtender ID="tbControNum_FilteredTextBoxExtender" FilterType="Numbers"  runat="server" TargetControlID="tbControNum" />
</div> 

<div style="width:84.5%; text-align:center; clear:both; display:block; padding-left: 0px;">
    <div style="text-align:left;">                  
        <div>                                        
            <div style="padding: 20px 4px 4px 0px; display:inline-block; width:400px;">
                <div style="width:150px; float:left;">Footnote&nbsp;&nbsp;&nbsp;</div>
                <div style="float:left; color:red; font-weight:bold; width:200px;"></div>
            </div>
            <textarea id="tbFootnote" runat="server" class="textarea"></textarea>    
        </div>
    </div>
</div>

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

<asp:HiddenField runat="server" ID="hdBrandProperDosage" ClientIDMode="Static" />

</asp:Content>

