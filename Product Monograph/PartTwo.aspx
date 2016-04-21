<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartTwo.aspx.cs" Inherits="Product_Monograph.PartTwo" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partTwo.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="row">
        <div class="col-sm-9">
             <p class="margin-bottom-none"><strong>Brand name : </strong><asp:Literal ID="brandName" runat="server"></asp:Literal></p>
             <p><strong>Proper name : </strong><asp:Literal ID="properName" runat="server"></asp:Literal><p>
         </div>
         <div class="col-sm-3 text-right">
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary " Text="Save a draft"  ToolTip="Please save your form data in a draft file." OnClick="btnSave_Click" /> 
         </div> 
</div> 
<details class="margin-top-medium">
    <summary>Pharmaceutical information</summary>
    <div class="brdr-bttm" >
        <div class="form-group row">
            <label for="tbDrugSub" class="col-sm-3 control-label">Drug substance</label>                        
            <div class="col-sm-7"> 
                <input type="text" id="tbDrugSub" name="tbDrugSub" class="form-control"/>                     
            </div>
            <div class="col-sm-2 text-right"> 
                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddDrugSubstance()" id="btnAddDrugSubstance" />
            </div>     
        </div>
        <div class="form-group row">
            <label for="tbChemical" class="col-sm-3 control-label">Chemical name</label>      
            <div class="col-sm-9">
                <textarea id="tbChemical" name="tbChemical" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbMolecular" class="col-sm-3 control-label">Molecular formula</label>      
            <div class="col-sm-9">
                <textarea id="tbMolecular" name="tbMolecular" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbMass" class="col-sm-3 control-label">Molecular mass</label>      
            <div class="col-sm-9">
                <textarea id="tbMass" name="tbMass" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="tbPhysicochemical" class="col-sm-3 control-label">Physicochemical properties</label>      
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
        <summary id="clinicalTrials" class="well well-sm">Clinical trials</summary>
            <div class="form-group row">                    
                        <label for="tbClinicalTrials" class="col-sm-3 control-label">Clinical trials</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbClinicalTrials" name="tbClinicalTrials" class="textarea form-control" runat="server"></textarea>
                        </div>                   
            </div>
      <div class="form-group">
            <div>
                <p><strong>Comparative bioavailability studies</strong>
                 <span class="label label-info" title="narrative outlining the design of the bioequivalence study. The values in the table should be based on the measured data from the study; no potency correction should be applied.">Info</span>
                 </p>           
            </div>    
        <section class="panel panel-default" id="AnalyteName0">
            <header class="panel-heading">
                <div class="row">
                    <div class="text-center col-sm-10">                    
                         <label for="tbAnalyteMultiplicand0" class="control-label">Analyte name</label>
                        ( <input type="number" id="tbAnalyteMultiplicand0" name="tbAnalyteMultiplicand" /> &nbsp;X   
                        <input type="number" id="tbAnalyteMultiplier0" name="tbAnalyteMultiplier" />  &nbsp;mg) 
                    </div>
                    <div class="text-right  col-sm-2 margin-top-0">
                        <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddAnalyteNameTextBox()" id="btnAddAnalyteNameTextBox" />                
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2 text-right">
                         <label for="tbAnalyteMultiplicand0" class="control-label">Parameter</label>
                    </div>
                    <div class="col-xs-2 brdr-lft">
                        <label for="tbAnalyteMultiplicand0" class="control-label">Test*</label>
                    </div>
                    <div class="col-xs-2 brdr-lft">
                         <label for="tbAnalyteMultiplicand0" class="control-label">Reference†</label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                       <label for="tbAnalyteMultiplicand0" class="control-label">% Ratio of geometric means</label>
                    </div>
                    <div class="col-xs-3 brdr-lft">
                       <label for="tbAnalyteMultiplicand0" class="control-label">Confidence interval #</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 brdr-tp text-right">
                        AUCT ‡(units) 
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
                        AUCI (units)
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
                        CMAX (units)
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
                        TMAX §(h)
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
                        T1/2 [](h)
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
        <div class="text-left"><p>* Identity of the test product.</p></div>
        <div class="text-left"><p>† Identity of the reference product, including the manufacturer, and origin (country of purchase).</p></div>
        <div class="text-left"><p>‡ For drugs with a half-life greater than 24 hours AUCT should be replaced with AUC0-72.</p></div>
        <div class="text-left"><p>§ Expressed as either the arithmetic mean (CV%) or the median (range) only.</p></div>
        <div class="text-left"><p>[]Expressed as the arithmetic mean (CV%) only.</p></div>
        <div class="text-left"><p># Indicate % Confidence Interval (i.e., 90% or 95%) in the column heading and list for the AUCT, AUCI and CMAX (if required).</p></div>
</div>             
</details>
<details class="margin-top-medium">
        <summary id="detailedPharmacology" class="well well-sm">Detailed pharmacology</summary>
        <div class="form-group row">                    
                        <label for="tbDetailedPharmacology" class="col-sm-3 control-label">Detailed pharmacology</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDetailedPharmacology" name="tbDetailedPharmacology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>       
</details>
<details class="margin-top-medium">
        <summary id="microbiology" class="well well-sm">Microbiology</summary>
        <div class="form-group row">                    
                        <label for="tbMicrobiology" class="col-sm-3 control-label">Microbiology</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbMicrobiology" name="tbMicrobiology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>   
</details>
<details class="margin-top-medium">
        <summary id="toxicology" class="well well-sm">Toxicology</summary>
       <div class="form-group row">                    
                        <label for="tbToxicology" class="col-sm-3 control-label">Toxicology</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbToxicology" name="tbToxicology" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div>   
</details>
<details class="margin-top-medium">
        <summary id="references" class="well well-sm">References</summary>
        <div class="form-group row">                    
                        <label for="tbReferences" class="col-sm-3 control-label">References</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbReferences" name="tbReferences" class="textarea form-control" runat="server"></textarea>
                        </div>                   
         </div> 
</details>
</asp:Content>

