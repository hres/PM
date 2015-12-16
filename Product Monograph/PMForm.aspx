<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PMForm.aspx.cs" Inherits="Product_Monograph.PMForm2" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section style="clear: both; text-align: left; padding-top: 20px; padding-right: 0px;">
        <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
    </section>

    <section style="clear: both; text-align: left; padding-left: 0px;">
        <div style="float: left;">
            <asp:FileUpload ID="fuXmlDraft" runat="server" Width="600px" Height="37px" /></div>
        <div style="padding-left: 20px; float: left;">
            <asp:Button ID="btnLoadXml" runat="server" Text="Load XML" Width="130px" OnClick="btnLoadXml_Click" /></div>
    </section>

    <section style="clear: both; padding-left: 0px; padding-top: 40px; padding-bottom: 40px;">
        <div style="clear: both;">
            <img id="imgSymbol" runat="server" src="~/images/landingnotes.png" style="display: none;" />
            <div style="clear: both; color: #335075;">
                <h4>Using the XML Product Monograph (PM) Web Form</h4>
            </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To load a new blank PM template for the creation of XML file, select a template type from the drop menu, and press the "Load template" button.</div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To load an existing XML file, press the “Choose File” button ("Browse..." in Internet Explorer and Firefox), select the file and press the "Open" button in the file browser. Press the "Load XML" button.</div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To save a file, press the "Save draft" button. The file name of the new file will always be "productmonograph" with the '.zip' extension.</div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To collapse and expand web form groups using the arrows shown on the top-left margin of collapsible groups. An arrow to the right (►) means a group is currently collapsed, click on it to expand the group. An arrow downward (▼) means the group is currently expanded and can be collapsed by clicking on this arrow. </div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	Key information is displayed by hovering your cursor over the red
                <img src="images/qmark.jpg" style="width: 15px; height: 15px;" />
                circle. </div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	Navigate through the XML PM Web Form by clicking on the links located below the banner.  Major sections will be indicated depending on the template type selected. </div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To add an image into the product label, take the following steps: </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 40px;">(1) Press the "Browse..." button. </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 40px;">(2) Select a valid image file (.jpg, .png, .gif, .bmp), and </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 40px;">(3) Press the "Open" button in the file browser. </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 40px;">(4) Finally add the image into the section text block using the "Apply symbol" button.</div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	Clicking within a large text field will activate the rich text editor.  This field type can accept text with bold, italics, bulleted lists, subscript and superscript.  The grey bar at the bottom of the field displays real-time html code for the text type, which may be useful for formatting purposes.</div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">
                •	Use the “ADD” button to add another row to a table.  Use the “REMOVE” button to delete an existing row.
            </div>
            <div style="clear: both; color: #335075;">
                <h4>Technical Specifications</h4>
            </div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;"></div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	Compatible with Mozilla Firefox (recommended) (6 and higher), Internet Explorer (7 to 10), Google chrome (8 and higher) and Apple Safari (4 and higher).</div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	To properly view and use this form, your internet browser will need to support HTML5. It's recommended that your computer have the latest version of one of the more widely used internet web browsers.</div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	You can navigate the form using any mobile device (such as a tablet or a smart phone). The information displayed will be adapted for your device.</div>
            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;">•	No download required.</div>
        </div>
    </section>

</asp:Content>
