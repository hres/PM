<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PMForm.aspx.cs" Inherits="Product_Monograph.PMForm2" ValidateRequest="false" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section>
            <h2><asp:Label runat="server" id="lblTitleFormInstructions"></asp:Label></h2>

    </section>

     <asp:Label runat="server" id="lblError" clientIDMode="Static" foreColor="Red"></asp:Label>


    <section class="margin-bottom-small">   
        <asp:FileUpload id="fuXmlDraft" runat="server"/>
        <div class="mrgn-bttm-lg"></div>
        <asp:Button cssClass="btn btn-default" id="btnLoadXml" runat="server" text="Load XML file" onClick="btnLoadXml_Click" />   
    </section>

    <section>
        <img id="imgSymbol" runat="server" src="~/images/landingnotes.png" style="display: none;" />
        <h3><asp:Label runat="server" id="lblUsingxml"></asp:Label></h3>                   
        <p><asp:Label runat="server" id="lblBody"></asp:Label></p>
    </section>


    <section>
        <h3><asp:Label runat="server" ID="lblTechSpec"></asp:Label></h3>
        <p><asp:Label runat="server" id="lblBottomBody"></asp:Label></p>
    </section>




</asp:Content>
