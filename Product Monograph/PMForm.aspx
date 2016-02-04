<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PMForm.aspx.cs" Inherits="Product_Monograph.PMForm2" ValidateRequest="false" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section>
<h2><asp:Label runat="server" ID="lblTitleFormInstructions"></asp:Label></h2>
</section>
   
    <section class="mrgn-tp-lg">
    <div>  
        <asp:Label runat="server" ID="lblError" ClientIDMode="Static" ForeColor="Red"></asp:Label>
    </div>
    <div class="col-sm-3">
        <asp:FileUpload ID="fuXmlDraft" runat="server"/>
    </div>
    <div class="col-sm-9 text-left mrgn-bttm-lg">
            <asp:Button CssClass="btn btn-default" ID="btnLoadXml" runat="server" Text="Load XML" OnClick="btnLoadXml_Click" />
    </div>
    </section>
    <section>
        <img id="imgSymbol" runat="server" src="~/images/landingnotes.png" style="display: none;" />
        <h3><asp:Label runat="server" ID="lblUsingxml"></asp:Label></h3>                   
        <p><asp:Label runat="server" id="lblBody"></asp:Label></p>
     </section>
     <section>
            <h3><asp:Label runat="server" ID="lblTechSpec"></asp:Label></h3>
        <p><asp:Label runat="server" id="lblBottomBody"></asp:Label></p>
    </section>

</asp:Content>
