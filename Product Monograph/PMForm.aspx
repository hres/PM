<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PMForm.aspx.cs" Inherits="Product_Monograph.PMForm" ValidateRequest="false" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
     <section>  
            <h2><asp:Label runat="server" id="lblTitleFormInstructions"></asp:Label></h2>
    </section>
     <asp:Label runat="server" id="lblError" clientIDMode="Static" foreColor="Red"></asp:Label>


       <div class="form-group mrgn-tp-lg">       
           <div class="col-sm-2">
               <asp:Label ID="lblSelectTemplate" runat="server" CssClass="control-label">Select a template:</asp:Label> 
           </div>
           <div class="col-sm-3">
               <select id="ddlTemplate" runat="server" class="form-control">
                  <option value="Select">Template</option>
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
           <div class="col-sm-7">
              <asp:Button ID="btnLoadTemplate" runat="server" CssClass="btn btn-default" Text="Load template" OnClick="btnLoadTemplate_Click"/> 
           </div>   
                                                                                                                 
           <div class="col-lg-12">
               <label id="Label1" runat="server" style="color:red;"></label>
           </div>
    </div>


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
        <h3><asp:Label runat="server" ID="lblTechSpec" ></asp:Label></h3>
        <p><asp:Label runat="server" id="lblBottomBody"></asp:Label></p>

 
    </section>
 </asp:Content>
