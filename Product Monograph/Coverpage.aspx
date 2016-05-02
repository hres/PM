<%@ Page Title="" Language="C#"  MasterPageFile="~/ProdMono.Master"  AutoEventWireup="true" CodeBehind="Coverpage.aspx.cs" Inherits="Product_Monograph.Coverpage" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
 <script src="./js/pmp.js"></script>
 <script src="./js/coverPage.js"></script>
</asp:Content>

<asp:Content id="Content2" contentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
     <div class="row hidden">       
        <input id="Button3" type="button" value="Hide" />
        <input id="Button4" type="button" value="Show" />
    </div>
    <div class="row brdr-bttm">
        <div class="col-sm-9">
             <p class="margin-bottom-none"><strong><span class="field-name"><%=brandNameTitle%>:</span></strong><asp:Literal ID="brandName" runat="server"></asp:Literal></p>
             <p><strong><span class="field-name"><%=properNameTitle%>:</span></strong><asp:Literal ID="properName" runat="server"></asp:Literal><p>
         </div>
         <div class="col-sm-3 text-right">
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary" Text="Save a draft"  ToolTip="Please save your form data in a draft file." OnClick="btnSaveDraft_Click" /> 
         </div> 
    </div>
     <div class="form-group row margin-top-medium">
                <label for="tbSchedulingSymbol" class="control-label col-sm-3" ><span class="field-name"><%=schedulingSymbol%></span> </label>     
                <select id="tbSchedulingSymbol" onchange="ApplySchedulingSymbol(this)" class="form-control col-sm-2"></select>                       
                     <div class="text-left">
                        <img id="imgSymbol" src="images/x.png" width="100" height="100" alt="Apply symbol"/>                     
                        <input type="text" id="tbxmlimgnameSymbol" name="tbxmlimgnameSymbol" class="hidden" />
                        <input type="text" id="tbxmlimgfilenameSymbol" name="tbxmlimgfilenameSymbol" class="hidden" /> 
                    </div>
            </div>
            <!--Brand  Dosage Form Table --> 
        <div class="table-responsive">             
        <table id="dataTable" class="table table-bordered table-striped table-hover" title="The brand dosage form">
                    <caption class="text-left"><span class="field-name"><%=brandDosageForm%></span></caption>
                    <thead>
                        <tr>           
                            <th><input class="btn btn-default btn-xs" type="button" runat="server" id="btnAppendRow" onclick="addRow('dataTable')" value="Add" /></th>
                            <th><span class="field-name"><%=brandNameTitle%></span></th>
                            <th><span class="field-name"><%=properNameTitle%></span></th>
                            <th><span class="field-name"><%=dosageForm%></span></th>
                            <th><span class="field-name"><%=strengthValue%></span></th>
                            <th><span class="field-name"><%=strengthDosageValue%></span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>                                                
                            <td><input id="tbBtnRemove" type="button" onclick="deleteRowBtnRow(this)" name="btnDelete" value="Remove" class="btn btn-default btn-xs"  disabled="disabled");/></td>   
                            <td headers="thBrandName" data-required="true"><input type="text" id="tbBrandname" name="tbBrandname" class="form-control input-sm" /></td>
                            <td headers="thProperName"><input type="text" id="tbPropername" name="tbPropername" class="form-control input-sm" /></td>
                            <td headers="thDosageForm">
                                <select id="tbDosage" name="tbDosage" class="form-control input-sm"></select></td>                
                            <td headers="thStrength">
                                <input type="number" id="tbStrengthValue" name="tbStrengthValue" value="0" min="0" max="1000" class="form-control font-small input-sm" />                                                  
                                <div>
                                    <select id="tbStrengthUnit" name="tbStrengthUnit" class="form-control font-small input-sm"> </select> 
                                </div>           
                            </td>
                            <td headers="thStrengthPerDosage">
                                <input type="number" id="tbStrengthperDosageValue" name="tbStrengthperDosageValue" value="0" min="0" max="1000" class="form-control font-small input-sm" /> 
                                <div>                        
                                    <select id="tbStrengthperDosageUnit" name="tbStrengthperDosageUnit" class="form-control input-sm font-small" ></select>  
                                </div>                             
                            </td>
                        </tr>
                    </tbody>
                </table> 
                <!--End of Brand Table -->
        </div>
            <div class="form-group row margin-top-large">
                <label for="tbPharmaceuticalStandard" class="control-label col-sm-3"><span class="field-name"><%=pharmaceuticalStandard%></span></label> 
                <div class="col-sm-9"> 
                    <asp:TextBox id="tbPharmaceuticalStandard" runat="server"  MaxLength="200" CssClass="form-control" ></asp:TextBox>                                
                </div>
            </div>
            <div class="form-group  row">         
                <label for="tbTherapeuticClassifications" class="required control-label col-sm-3" ><span class="field-name"><%=therapeuticClassification%></span></label> 
                <div class="col-sm-9"> 
                        <asp:TextBox id="tbTherapeuticClassifications" runat="server" MaxLength="200" CssClass="form-control" required="required" ClientIDMode="Static"></asp:TextBox>    
                </div>
            </div>
            <div class="form-group  row">
                <label for="tbSponsorName" class="required control-label col-sm-3" ><span class="field-name"><%=sponsorName%></span></label> 
                <div class="col-sm-9">                                  
                    <asp:TextBox id="tbSponsorName" runat="server" MaxLength="200" CssClass="form-control" required="required" ClientIDMode="Static"></asp:TextBox>                                
                </div>
            </div>
        <div class="form-group  row">                               
           <label for="tbSponsorAddress" class="control-label col-sm-3" ><span class="field-name"><%=sponsorAddress%></span></label> 
            <div class="col-sm-9">       
                <textarea id="tbSponsorAddress" name="tbSponsorAddress" runat="server" class="textarea form-control"  ClientIDMode="Static"></textarea>
            </div>
        </div>
        <div class="form-group  row">
             <label for="tbDatePrep" class="control-label col-sm-3" >
                <span class="field-name"><%=datePreparation%></span><br />
                <span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span>
            </label>
            <div class="col-sm-9">
                <asp:TextBox runat="server" id="tbDatePrep" CssClass="form-control"  type="date" data-rule-dateiso="true"></asp:TextBox>  
            </div>
        </div>  
        <div class="form-group  row"> 
             <label for="tbDateRev" class="control-label col-sm-3" >
                <span class="field-name"><%=dateRevision%></span>
                <span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span>
            </label>
            <div class="col-sm-9">  
                <asp:TextBox runat="server" id="tbDateRev" CssClass="form-control" type="date" data-rule-dateiso="true" ></asp:TextBox>
            </div>
        </div>
        <div class="form-group  row">
             <label for="tbControNum" class="control-label col-sm-3" ><span class="field-name"><%=submissionControlNumber%></span></label> 
            <div class="col-sm-9">           
                    <asp:TextBox id="tbControNum" type="number" data-rule-digits="true" runat="server" min="0" max="999999" CssClass="form-control"></asp:TextBox>                         
                </div>
        </div>
        <div class="form-group  row"> 
            <label for="tbFootnote" class="control-label col-sm-3" ><span class="field-name"><%=footnote%></span></label> 
            <div class="col-sm-9">        
                    <textarea id="tbFootnote" name="tbFootnote" runat="server" class="textarea form-control"  ClientIDMode="Static"></textarea>               
            </div> 
        </div>
  
</asp:Content>


