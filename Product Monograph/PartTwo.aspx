<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartTwo.aspx.cs" Inherits="Product_Monograph.PartTwo" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partTwo.js"></script>
 <script>
     var removeButtonValue = '<%=removeButton%>';     
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="row">
        <div class="col-sm-9">
             <p class="margin-bottom-none"><strong><span class="field-name"><%=brandNameTitle%>:</span></strong><asp:Literal ID="brandName" runat="server"></asp:Literal></p>
             <p><strong><span class="field-name"><%=properNameTitle%>:</span></strong><asp:Literal ID="properName" runat="server"></asp:Literal><p>
         </div>
         <div class="col-sm-3 text-right">
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary " OnClick="btnSave_Click" /> 
         </div> 
</div> 
<details class="margin-top-medium">
    <summary id="pharmInfo" class="well well-sm"><%=sumPharmInfo%></summary>
    <div class="brdr-bttm" >
        <div class="form-group row">
            <label for="tbDrugSub" class="col-sm-3 control-label">
                <span class="field-name"><%=drugSubstance%></span>
            </label>                        
            <div class="col-sm-7"> 
                <input type="text" id="tbDrugSub" name="tbDrugSub" class="form-control"/>                     
            </div>
            <div class="col-sm-2 text-right"> 
                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddDrugSubstance()" id="btnAddDrugSubstance" />
            </div>     
        </div>
        <div class="form-group row">
            <label for="tbChemical" class="col-sm-3 control-label">
                <span class="field-name"><%=chemicalName%></span>
            </label>      
            <div class="col-sm-9">
                <textarea id="tbChemical" name="tbChemical" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbMolecular" class="col-sm-3 control-label">
                <span class="field-name"><%=molecularFormula%></span>
            </label>      
            <div class="col-sm-9">
                <textarea id="tbMolecular" name="tbMolecular" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbMass" class="col-sm-3 control-label">
               <span class="field-name"><%=molecularMass%></span>
            </label>      
            <div class="col-sm-9">
                <textarea id="tbMass" name="tbMass" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbPhysicochemical" class="col-sm-3 control-label">
                <span class="field-name"><%=physicochemicalProp%></span>
            </label>      
            <div class="col-sm-9">
                <textarea id="tbPhysicochemical" name="tbPhysicochemical" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
                <label for="tbPharSchedulingSymbol" class="col-sm-4 control-label" ><span class="field-name"><%=schedulingSymbol%></span> </label>     
                <select id="tbPharSchedulingSymbol" onchange="ApplyPharSchedulingSymbol(this)" class="form-control col-sm-2"></select>                       
                <div class="text-left col-sm-4">
                        <img id="imgSymbol" src="./images/x.png" width="100" height="100" alt="Apply symbol"/>                     
                        <input type="text" id="tbPharxmlimgnameSymbol" name="tbPharxmlimgnameSymbol" class="hidden" />
                        <input type="text" id="tbPharxmlimgfilenameSymbol" name="tbPharxmlimgfilenameSymbol" class="hidden" /> 
                </div>
        </div> 
     </div>
     <div id="divExtraDrugSubstance">
     </div>
</details>
<details class="margin-top-medium">
        <summary id="clinicalTrials" class="well well-sm"><%=sumClinicalTrials%></summary>
            <div class="form-group row">                    
                        <label for="tbClinicalTrials" class="col-sm-3 control-label">
                            <span class="field-name"><%=clinicalTrials%></span></label>
                        <div class="col-sm-9"> 
                            <textarea id="tbClinicalTrials" name="tbClinicalTrials" class="textarea form-control" runat="server"></textarea>
                        </div>                   
            </div>
      <div class="form-group">
            <div>
                <p><strong><span class="field-name"><%=compBioStudies%></span></strong>
                 <span class="label label-info" title="<%=compBioStudiesInfo%>">Info</span>
                 </p>           
            </div>    
        <section class="panel panel-default" id="AnalyteName0">
            <header class="panel-heading">
                <div class="row">
                    <div class="text-center col-sm-10">                    
                         <label for="tbAnalyteMultiplicand0" class="control-label">
                             <span class="field-name"><%=analyteName%></span>
                         </label>
                        ( <input type="number" id="tbAnalyteMultiplicand0" name="tbAnalyteMultiplicand" /> &nbsp;X   
                        <input type="number" id="tbAnalyteMultiplier0" name="tbAnalyteMultiplier" />  &nbsp;mg) 
                    </div>
                    <div class="text-right  col-sm-2 margin-top-0">
                        <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddAnalyteNameTextBox()" id="btnAddAnalyteNameTextBox" />                
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2 text-right">
                         <label for="tbAnalyteMultiplicand0" class="control-label">
                             <span class="field-name"><%=parameter%></span>
                         </label>
                    </div>
                    <div class="col-xs-2 brdr-lft">
                        <label for="tbAnalyteMultiplicand0" class="control-label">
                            <span class="field-name"><%=test%></span>*
                        </label>
                    </div>
                    <div class="col-xs-2 brdr-lft">
                         <label for="tbAnalyteMultiplicand0" class="control-label">
                             <span class="field-name"><%=reference%></span>†
                         </label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                       <label for="tbAnalyteMultiplicand0" class="control-label">% 
                           <span class="field-name"><%=ratioGeoMeans%></span>
                       </label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                       <label for="tbAnalyteMultiplicand0" class="control-label">
                           <span class="field-name"><%=confInterval%></span> #
                       </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        <span><%=auctUnit%></span> 
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCTTest0" name="tbAUCTTest" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCTReference0" name="tbAUCTReference" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCTPercentRatio0" name="tbAUCTPercentRatio" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCTConfidenceInterval0" name="tbAUCTConfidenceInterval" class="textarea form-control"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        <span><%=auciUnit%></span>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCITest0" title="AUCI test" name="tbAUCITest" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbAUCIReference0" title="AUCI reference" name="tbAUCIReference" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCIPercentRatio0" title="AUCI percent ratio" name="tbAUCIPercentRatio" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbAUCIConfidenceInterval0" title="AUCI confidence interval" name="tbAUCIConfidenceInterval" class="textarea form-control"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        <span><%=cmaxUnit%></span>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbCMAXTest0" title="CMAX test" name="tbCMAXTest" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbCMAXReference0" title="CMAX reference" name="tbCMAXReference" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbCMAXPercentRatio0" title="CMAX percent ratio" name="tbCMAXPercentRatio" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbCMAXConfidenceInterval0" title="CMAX confidence interval" name="tbCMAXConfidenceInterval" class="textarea form-control"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        <span><%=tmax%></span>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbTMAXTest0" title="TMAX test" name="tbTMAXTest" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft">
                        <textarea id="tbTMAXReference0" title="TMAX reference" name="tbTMAXReference" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbTMAXPercentRatio0" title="TMAX percent ratio" name="tbTMAXPercentRatio" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft">
                        <textarea id="tbTMAXConfidenceInterval0" title="TMAX confidence interval" name="tbTMAXConfidenceInterval" class="textarea form-control"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        <span><%=halfLife%></span>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfTest0" title="Half test" name="tbTHalfTest" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-2 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfReference0" title="Half reference" name="tbTHalfReference" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfPercentRatio0" title="Half percent ratio" name="tbTHalfPercentRatio" class="textarea form-control"></textarea>
                    </div>
                    <div class="col-xs-3 brdr-tp brdr-lft brdr-bttm">                        
                        <textarea id="tbTHalfConfidenceInterval0" title="Half confidence interval" name="tbTHalfConfidenceInterval" class="textarea form-control"></textarea>
                    </div>
                </div>
            </div>
        </section>
    
        <div id="dvExtraAnalyteName"></div>
        <div class="text-left"><p>* <%=idTestProduct%></p></div>
        <div class="text-left"><p>† <%=idRefProduct%></p></div>
        <div class="text-left"><p>‡ <%=auct24%></p></div>
        <div class="text-left"><p>§ <%=arithmeticMedian %></p></div>
        <div class="text-left"><p>[]<%=arithmeticOnly%></p></div>
        <div class="text-left"><p># <%=confidenceInterval%></p></div>
</div>             
</details>
<details class="margin-top-medium">
        <summary id="detailedPharmacology" class="well well-sm"><%=sumPharmacology%></summary>
        <div class="form-group row">                    
                        <label for="tbDetailedPharmacology" class="col-sm-3 control-label">
                            <span class="field-name"><%=pharmacology%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDetailedPharmacology" name="tbDetailedPharmacology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>       
</details>
<details class="margin-top-medium">
        <summary id="microbiology" class="well well-sm"><%=sumMicrobiology%></summary>
        <div class="form-group row">                    
                        <label for="tbMicrobiology" class="col-sm-3 control-label">
                            <span class="field-name"><%=microbiology%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbMicrobiology" name="tbMicrobiology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>   
</details>
<details class="margin-top-medium">
        <summary id="toxicology" class="well well-sm"><%=sumToxicology%></summary>
       <div class="form-group row">                    
                        <label for="tbToxicology" class="col-sm-3 control-label">
                            <span class="field-name"><%=toxicology%></span></label>
                        <div class="col-sm-9"> 
                            <textarea id="tbToxicology" name="tbToxicology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>   
</details>
<details class="margin-top-medium">
        <summary id="references" class="well well-sm"><%=sumReferences%></summary>
        <div class="form-group row">                    
                        <label for="tbReferences" class="col-sm-3 control-label">
                            <span class="field-name"><%=references%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbReferences" name="tbReferences" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div> 
</details>
</asp:Content>

