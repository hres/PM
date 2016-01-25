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
                <h4><asp:Label runat="server" ID="lblUsingxml"></asp:Label></h4>                   
            </div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;"><asp:Label runat="server" id="lblBody"></asp:Label></div>
  
            <div style="clear: both; color: #335075;">
                <h4><asp:Label runat="server" ID="lblTechSpec"></asp:Label></h4>
            </div>

            <div style="clear: both; font-size: 18px; font-family: Calibri; padding-left: 20px;"><asp:Label runat="server" id="lblBottomBody"></asp:Label></div>

        </div>
    </section>

</asp:Content>
