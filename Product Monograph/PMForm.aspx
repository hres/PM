<%@ Page Title="" Language="C#"   MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PMForm.aspx.cs" Inherits="Product_Monograph.PMForm"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
<script type="text/javascript">
    $(document).ready(function () {
        $("#linkCover").attr("disabled", "disabled");
        $("#linkOne").attr("disabled", "disabled");
        $("#linkTwo").attr("disabled", "disabled");
        $("#linkThree").attr("disabled", "disabled");
        $('#btnLoadTemplate').click(function () {
            $('#fuXmlDraft').removeAttribute('required');
        });
        $('#btnLoadXml').click(function () {
            $('#ddlTemplate').removeAttribute('required');
        });

        $('#btnLoadTemplateFra').click(function () {
            $('#fuXmlDraftFra').removeAttribute('required');
        });

        $('#btnLoadXmlFra').click(function () {
            $('#ddlTemplateFra').removeAttribute('required');
        });
    });
</script>
</asp:Content>
<asp:Content id="Content2" contentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mrgn-tp-lg" runat="server" id="sectionEng">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="panel-title">Create a new template</h2>
                    </div>
                    <div class="panel-body">
                            <p>To load a new blank PM template for the creation of XML file, select a template type from the drop menu, and press the "Load template" button.</p><div class="form-group row">
                            <div class="col-sm-4 text-right">
                                <label for="ddlTemplate" class="required">
                                     <span class="field-name">Template:</span>
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <select id="ddlTemplate" runat="server" class="form-control" required="required" ClientIDMode="Static">
                                    <option label="Select a template"></option>
                                    <option value="2014 Standard" disabled="disabled">2014 Standard</option>
                                    <option value="2014 NOCC" disabled="disabled">2014 NOCC</option>
                                    <option value="2014 Subsequent Entry Product" disabled="disabled">2014 Subsequent Entry Product</option>
                                    <option value="2014 Schedule C" disabled="disabled">2014 Schedule C</option>
                                    <option value="2014 Schedule D" disabled="disabled">2014 Schedule D</option>
                                    <option value="2004 Standard" selected="selected">2004 Standard</option>
                                    <option value="2004 NOCC" disabled="disabled">2004 NOCC</option>
                                    <option value="2004 Subsequent Entry Product" disabled="disabled">2004 Subsequent Entry Product</option>
                                    <option value="2004 Schedule C" disabled="disabled">2004 Schedule C</option>
                                    <option value="2004 Schedule D" disabled="disabled">2004 Schedule D</option>
                                </select>
                            </div>  
                            <div class="col-sm-4">
                                <asp:Button ID="btnLoadTemplate" runat="server" CssClass="btn btn-primary" Text="Load template" OnClick="btnLoadTemplate_Click" ClientIDMode="Static"/> 
                            </div>
                        </div>   
                    </div>
                    <div class="panel-heading">
                        <h2 class="panel-title">Load an existing template</h2>
                    </div>
                    <div class="panel-body">
                        <p>To load an existing XML file, press the “Choose File” button ("Browse..." in Internet Explorer and Firefox), select the file and press the "Open" button in the file browser. Press the "Load XML" button.</p>
                           <div class="col-sm-4 text-right">
                                <label for="ddlTemplate" class="required">
                                     <span class="field-name">XML file:</span>
                                </label>
                            </div>
                            <div class="col-sm-4">
                                 <asp:FileUpload id="fuXmlDraft" name="fuXmlDraft" runat="server" ClientIDMode="Static"/>
                            </div>
                            <div class="col-sm-4">
                                <asp:Button cssClass="btn btn-primary" id="btnLoadXml" runat="server" text="Load XML file" onClick="btnLoadXml_Click"  ClientIDMode="Static"/>   
                            </div>
                    </div>
                <div class="panel-heading">
                    <h2  class="panel-title">Using the XML product monograph (PM) web form</h2>
                 </div>
                <div class="panel-body">
                  <ul>
                      <li>To save a file, press the "Save a draft" button. The file name of the new file will always be the brand name with the '.zip' extension.</li>
                        <li>To collapse and expand web form groups using the arrows shown on the top-left margin of collapsible groups. An arrow to the right (►) means a group is currently collapsed, click on it to expand the group. An arrow downward (▼) means the group is currently expanded and can be collapsed by clicking on this arrow.</li>
                        <li>Key information is displayed by hovering your cursor over the red help of message circle <span class="label label-info">Info</span></li>
                        <li>Navigate through the XML PM Web Form by clicking on the links located below the banner. Major sections will be indicated depending on the template type selected.</li>
                        <li>To add an image into the product label, take the following steps: <br />
                                <span>1) Press the "Browse..." button.</span><br />
		                        <span>2) Select a valid image file (.jpg, .png, .gif, .bmp), and</span><br />
		                        <span>3) Press the "Open" button in the file browser.</span><br />
		                        <span>4) Finally add the image into the section text block using the "Apply symbol" button.</span><br />
                        </li>
                        <li>Clicking within a large text field will activate the rich text editor. This field type can accept text with bold, italics, bulleted lists, subscript and superscript. The grey bar at the bottom of the field displays real-time html code for the text type, which may be useful for formatting purposes.</li>
                        <li>Use the “ADD” button to add another row to a table. Use the “REMOVE” button to delete an existing row.</li>
                 </ul>
                </div>
                <div class="panel-heading">
                        <h2  class="panel-title">Technical specifications</h2>
                 </div>
                <div class="panel-body">
                     <ul>
                        <li>Compatible with Mozilla Firefox (recommended) (6 and higher), Internet Explorer (7 to 10), Google chrome (8 and higher) and Apple Safari (4 and higher).</li>
                        <li>To properly view and use this form, your internet browser will need to support HTML5. It's recommended that your computer have the latest version of one of the more widely used internet web browsers.</li>
                        <li>You can navigate the form using any mobile device (such as a tablet or a smart phone). The information displayed will be adapted for your device.</li>
                        <li>No download required.</li>
                     </ul>
                 </div>
             </div>
    </section>
    <section class="mrgn-tp-lg" runat="server" id="sectionFra">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="panel-title">Create a new templete</h2>
                    </div>
                    <div class="panel-body">
                            <p>To load a new blank PM template for the creation of XML file, select a template type from the drop menu, and press the "Load template" button.</p><div class="form-group row">
                            <div class="col-sm-4 text-right">
                                <label for="ddlTemplateFra" class="required">
                                     <span class="field-name">Template:</span>
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <select id="ddlTemplateFra" runat="server" class="form-control" required="required" ClientIDMode="Static">
                                    <option label="Select a template"></option>
                                    <option value="2014 Standard" disabled="disabled">2014 Standard</option>
                                    <option value="2014 NOCC" disabled="disabled">2014 NOCC</option>
                                    <option value="2014 Subsequent Entry Product" disabled="disabled">2014 Subsequent Entry Product</option>
                                    <option value="2014 Schedule C" disabled="disabled">2014 Schedule C</option>
                                    <option value="2014 Schedule D" disabled="disabled">2014 Schedule D</option>
                                    <option value="2004 Standard" selected="selected">2004 Standard</option>
                                    <option value="2004 NOCC" disabled="disabled">2004 NOCC</option>
                                    <option value="2004 Subsequent Entry Product" disabled="disabled">2004 Subsequent Entry Product</option>
                                    <option value="2004 Schedule C" disabled="disabled">2004 Schedule C</option>
                                    <option value="2004 Schedule D" disabled="disabled">2004 Schedule D</option>
                                </select>
                            </div>  
                            <div class="col-sm-4">
                                <asp:Button ID="btnLoadTemplateFra" runat="server" CssClass="btn btn-primary" Text="Modèle de charge" OnClick="btnLoadTemplate_Click" ClientIDMode="Static"/> 
                            </div>
                        </div>   
                    </div>
                    <div class="panel-heading">
                        <h2 class="panel-title">Load an existing templete</h2>
                    </div>
                    <div class="panel-body">
                        <p>To load an existing XML file, press the “Choose File” button ("Browse..." in Internet Explorer and Firefox), select the file and press the "Open" button in the file browser. Press the "Load XML" button.</p>
                           <div class="col-sm-4 text-right">
                                <label for="ddlTemplate" class="required">
                                     <span class="field-name">Xml file:</span>
                                </label>
                            </div>
                            <div class="col-sm-4">
                                 <asp:FileUpload id="FileUpload1" runat="server" ClientIDMode="Static"/>
                            </div>
                            <div class="col-sm-4">
                                <asp:Button cssClass="btn btn-primary" id="btnLoadXmlFra" runat="server" text="Fichier XML de charge" onClick="btnLoadXml_Click"  ClientIDMode="Static"/>   
                            </div>
                    </div>
                <div class="panel-heading">
                    <h2  class="panel-title">Utiliser le formulaire web pour monographie de produit - xml</h2>
                 </div>
                <div class="panel-body">
                  <ul>
                      <li>To save a file, press the "Save draft" button. The file name of the new file will always be "productmonograph" with the '.zip' extension.</li>
                        <li>To collapse and expand web form groups using the arrows shown on the top-left margin of collapsible groups. An arrow to the right (►) means a group is currently collapsed, click on it to expand the group. An arrow downward (▼) means the group is currently expanded and can be collapsed by clicking on this arrow.</li>
                        <li>Key information is displayed by hovering your cursor over the red help of message circle <span class="label label-info">Info</span></li>
                        <li>Navigate through the XML PM Web Form by clicking on the links located below the banner. Major sections will be indicated depending on the template type selected.</li>
                        <li>To add an image into the product label, take the following steps: <br />
                                <span>1) Press the "Browse..." button.</span><br />
		                        <span>2) Select a valid image file (.jpg, .png, .gif, .bmp), and</span><br />
		                        <span>3) Press the "Open" button in the file browser.</span><br />
		                        <span>4) Finally add the image into the section text block using the "Apply symbol" button.</span><br />
                        </li>
                        <li>Clicking within a large text field will activate the rich text editor. This field type can accept text with bold, italics, bulleted lists, subscript and superscript. The grey bar at the bottom of the field displays real-time html code for the text type, which may be useful for formatting purposes.</li>
                        <li>Use the “ADD” button to add another row to a table. Use the “REMOVE” button to delete an existing row.</li>
                 </ul>
                </div>
                <div class="panel-heading">
                        <h2  class="panel-title">Spécifications techniques</h2>
                 </div>
                <div class="panel-body">
                     <ul>
                        <li>Compatible with Mozilla Firefox (recommended) (6 and higher), Internet Explorer (7 to 10), Google chrome (8 and higher) and Apple Safari (4 and higher).</li>
                        <li>To properly view and use this form, your internet browser will need to support HTML5. It's recommended that your computer have the latest version of one of the more widely used internet web browsers.</li>
                        <li>You can navigate the form using any mobile device (such as a tablet or a smart phone). The information displayed will be adapted for your device.</li>
                        <li>No download required.</li>
                     </ul>
                 </div>
             </div>
    </section>
</asp:Content>
