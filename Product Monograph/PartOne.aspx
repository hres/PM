<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartOne.aspx.cs" Inherits="Product_Monograph.PartOne" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partOne.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="row">
        <div class="col-sm-9">
             <p class="margin-bottom-none"><strong>Brand name : </strong><asp:Literal ID="brandName" runat="server"></asp:Literal></p>
             <p><strong>Proper name : </strong><asp:Literal ID="properName" runat="server"></asp:Literal><p>
         </div>
         <div class="col-sm-3 text-right">
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary " Text="Save a draft"  ToolTip="Please save your form data in a draft file." OnClick="btnSave_Click" ClientIDMode="Static"/> 
         </div> 
    </div>  
<ul class="list-unstyled">
	<li>
        <details class="margin-top-medium">
           <summary id="summaryProductInformation" class="well well-sm">Summary product information</summary>
                <table id="dataTable1" class="table table-bordered table-striped table-hover" title="Summary product information form">
                <caption></caption>
                <thead>
                <tr>
                    <th><input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddRouteOfAdminTextBox('dataTable1')" id="btnAddExtraRouteOfAdmin" /></th>
                    <th>Route of administration</th>
                    <th>Dosage form</th>
                    <th>Strength</th>
                    <th>Clinically relevant  <br />nonmedicinal  <br />ingredientsValue</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input id="tbBtnRemove" type="button" onclick="deleteRowBtnRow(this)" name="btnDelete" value="Remove" class="btn btn-default btn-xs"/></td>   
                        <td headers="thRouteOfAdminDynamic" data-required="true"><select id="tbRouteOfAdminDynamic" name="tbRouteOfAdminDynamic" class="form-control font-small input-sm"></select></td>
                        <td headers="thDosageForm"><select id="tbDosageFormDynamic" name="tbDosageFormDynamic" class="form-control font-small input-sm"></select></td>                                    
                        <td headers="thStrength"><textarea  id="tbStrengthDynamic" name="tbStrengthDynamic" ></textarea></td>
                        <td headers="thClinicallyRelevant"><textarea  id="tbClinicallyRelevant" name="tbClinicallyRelevant" ></textarea></td>
                    </tr>
                </tbody>
                </table> 
            </details>
        <details class="margin-top-medium">
                <summary id="indicationsClinical" class="well well-sm">Indications and clinical use</summary>
                <div class="form-group"> 
                     <div class="row"> 
                        <label for="tbbrandName" class="col-sm-3 control-label">
                             <span class="field-name">( is indicated for:)</span>
                             <span class="label label-info" title="Brief discussion of any relevant clinical information - if applicable 
                                 Distribution restrictions - if applicable
                                 When the product is not recommended - if applicable">Info</span>
                        </label>
                      </div>
                     <textarea id="tbbrandName" name="tbbrandName" runat="server" class="textarea form-control"></textarea>
                </div>
                <div class="form-group"> 
                     <div class="row"> 
                        <label for="tbGeriatrics" class="col-sm-1 control-label">Geriatrics</label>
                        <input type="number" id="tbGeriatricsAge" name="tbGeriatricsAge" class="form-control col-sm-1" min="1" max="150" size="3"  runat="server"/>  
                        <label for="tbGeriatricsAge" class="col-sm-2 control-label pull-left">years of age:</label>
                     </div>
                     <textarea id="tbGeriatrics" name="tbGeriatrics" runat="server" class="textarea form-control"></textarea>
                </div>
                <div class="form-group"> 
                    <div class="row"> 
                        <label for="tbPediatrics" class="col-sm-1  control-label">Pediatrics</label>
                        <input type="number" id="tbPediatricsAgeX" name="tbPediatricsAge1" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/>
                        <input type="number" id="tbPediatricsAgeY" name="tbPediatricsAge2" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/>
                        <label for="tbPediatricsAgeX" class="pull-left">years of age or </label>
                        <input type="number" id="tbPediatricsAgeZ" name="tbPediatricsAgeZ" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/> 
                        <label for="tbGeriatricsAgeZ" class="pull-left col-sm-3">years of age:</label> 
                    </div> 
                    <textarea id="tbPediatrics" name="tbPediatrics" runat="server" class="textarea form-control"></textarea>
                </div>
                </details>
        <details class="margin-top-medium">
                    <summary id="contraindications" class="well well-sm">Contraindications</summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbContraindications" class="col-sm-3 control-label">
                             <span class="field-name">Contraindications</span>
                             <span class="label label-info" title="Patients who are hypersensitive to this drug or to any ingredient in the formulation or component of the container. For a complete listing, see the Dosage Forms, Composition and Packaging section of the product monograph. [if applicable]">Info</span>
                        </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbContraindications" name="tbContraindications" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddContraindications()" id="btnContraindications" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraContraindications">
                    </div>             
            </details>
        <details class="margin-top-medium">
                    <summary id="seriousWarnings" class="well well-sm">Warnings and precautions</summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbSeriousWarnings" class="col-sm-3 control-label">Serious warnings and precautions
                            <span class="label label-info" title="Clinically significant or serious life-threatening warnings should be placed in the warning box. Generally not to exceed 20 lines">Info</span>
                            </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbSeriousWarnings" name="tbSeriousWarnings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddSeriousWarnings()" id="btnAddSeriousWarnings" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraSeriousWarnings">
                    </div>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbHeadings" class="col-sm-3 control-label">Headings
                                     <span class="label label-info" title="Headings to be included as applicable">Info</span>
                             </label>
                             <div class="col-sm-7">
                                <select id="dlHeadings" name="dlHeadings" class="form-control font-small input-sm"></select>
                                <textarea id="tbHeadings" name="tbHeadings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddHeadings()" id="btnHeadings" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtratbHeadings">
                    </div>
                    <div class="form-group row">                    
                        <label for="tbAdditionalwarnings" class="col-sm-3 control-label">Additional warnings</label>
                        <div class="col-sm-7"> 
                            <textarea id="tbAdditionalwarnings" name="tbAdditionalwarnings" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                   </div>              
            </details>
           <details class="margin-top-medium">
                    <summary id="adverseReactions" class="well well-sm">Adverse reactions</summary>
                    <div class="form-group row">                    
                        <label for="tbAdverseReactions" class="col-sm-3 control-label">Adverse drug reaction overview
                            <span class="label label-info" title="An overview of the ADR information that may affect prescribing decision, it should contain: serious and important ADRs; the most frequent ADRs and ADRs that...">Info</span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbAdverseReactions" name="tbAdverseReactions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="drugInteractions" class="well well-sm">Drug interactions</summary>
                     <div class="form-group row">                    
                        <label for="tbSeriousDrugInteractions" class="col-sm-3 control-label">Serious drug interactions
                            <span class="label label-info" title="Serious, life-threatening drug interactions should be highlighted in this box. Not to exceed 20 lines.">Info</span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSeriousDrugInteractions" name="tbSeriousDrugInteractions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
                 <div class="form-group row">                    
                        <label for="tbDrugInteractions" class="col-sm-3 control-label">Drug interactions overview
                            <span class="label label-info" title="It should include the following information: interactions suspected based on the pharmacokinetic or pharmacologic profile of the drug (forr example, cytochrome P45C)">Info</span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDrugInteractions" name="tbDrugInteractions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="dosageAdministration" class="well well-sm">Dosage and administration</summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbDosageConsiderations" class="col-sm-3 control-label">Dosing considerations
                                   <span class="label label-info" title="include all situations that may affect dosing of the drug">Info</span>
                             </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbDosageConsiderations" name="tbDosageConsiderations" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddDosageConsiderations()" id="btnDosageConsiderations" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraDosageConsiderations">
                    </div>
                    <div class="form-group row">                    
                            <label for="tbDosageAdjustment" class="col-sm-3 control-label">Recommended dose and dosage adjustment
                                   <span class="label label-info" title="Include for each indication, route of administration or dosage form">Info</span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageAdjustment" name="tbDosageAdjustment" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                     <div class="form-group row">                    
                            <label for="tbDosageMissed" class="col-sm-3 control-label">Missed dose</label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageMissed" name="tbDosageMissed" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                    <div class="form-group row">                    
                            <label for="tbDosageAdministration" class="col-sm-3 control-label">Administration</label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageAdministration" name="tbDosageAdministration" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                    <div class="form-group row">                    
                            <label for="tbDosageReconstitution" class="col-sm-3 control-label">Reconstitution</label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageReconstitution" name="tbDosageReconstitution" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div>  
                  <div class="form-group row">                    
                            <label for="tbDosageOral" class="col-sm-3 control-label">Oral solutions</label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageOral" name="tbDosageOral" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                   </div>
                <div>
                    <table id="dataTable2" class="table table-bordered table-striped table-hover" title="Parenteral products">
                        <caption class="text-left">Parenteral products: </caption>
                        <thead>
                        <tr>
                            <th><input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddParenteralProducts('dataTable2')" id="btnAddParenteralProducts" /></th>
                            <th>Vial size</th>
                            <th>Volume of diluent <br />to be added to vial</th>
                            <th>Approximate available volume</th>
                            <th>Nominal concentration per mL</th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input id="btnParenteralProductRemove" type="button" onclick="deleteParenteralProduct(this)" name="btnDelete" value="Remove" class="btn btn-default btn-xs"/></td>   
                                <td headers="thVial"><textarea  id="tbVial" name="tbVial" ></textarea></td>
                                <td headers="thVolume"><textarea  id="tbVolume" name="tbVolume" ></textarea></td>                                    
                                <td headers="thApproximate"><textarea  id="tbApproximate" name="tbApproximate" ></textarea></td>
                                <td headers="thNominal"><textarea  id="tbNominal" name="tbNominal" ></textarea></td>
                            </tr>
                        </tbody>
                    </table> 
                  </div>         
             </details>

            <details class="margin-top-medium">
                    <summary id="overdosage" class="well well-sm">Overdosage</summary>
                    <div class="form-group row">                    
                        <label for="tbOverdosage" class="col-sm-3 control-label">Overdosage</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbOverdosage" name="tbOverdosage" class="textarea form-control input-sm" runat="server">For management of a suspected drug overdose, contact your regional Poison Control Centre.</textarea>
                        </div>                   
                    </div> 
                    <div class="form-group row">                    
                        <p>For management of a suspected drug overdose, contact your regional Poison Control For management of a suspected drug overdose, contact your regional Poison Control Centre</p>                 
                    </div>
            </details>
            <details class="margin-top-medium">
                    <summary id="actionClinicalPharmacology" class="well well-sm">Action and clinical pharmacology</summary>
                     <div class="form-group row">                    
                        <label for="tbMechanismAction" class="col-sm-3 control-label">Mechanism of action
                            <span class="label label-info" title="For anti-infective products:a brief description of action against micro-organisms">Info</span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbMechanismAction" name="tbMechanismAction" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
                     <div class="form-group row">                    
                        <label for="tbPharmacodynamics" class="col-sm-3 control-label">Pharmacodynamics</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbPharmacodynamics" name="tbPharmacodynamics" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div>
                    <div class="form-group row">                    
                        <label for="tbSpecialPopulationsConditions" class="col-sm-3 control-label">Special Populations and Conditions</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSpecialPopulationsConditions" name="tbSpecialPopulationsConditions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div>  
            </details>
<%--            <details class="margin-top-medium">
                    <summary id="specialPopulationsConditions" class="well well-sm">Special Populations and Conditions</summary>
            </details>--%>
            <details class="margin-top-medium">
                    <summary id="storageStability" class="well well-sm">Storage and stability</summary>
                    <div class="form-group row">                    
                        <label for="tbStorageStability" class="col-sm-3 control-label">Storage and stability</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbStorageStability" name="tbStorageStability" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="specialHandling" class="well well-sm">Special handling instruction</summary>
                    <div class="form-group row">                    
                        <label for="tbSpecialHandling" class="col-sm-3 control-label">Special handling instruction</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSpecialHandling" name="tbSpecialHandling" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="DosageCompositionPackaging" class="well well-sm">Dosage forms, composition and packaging</summary>
                    <div class="form-group row">                    
                        <label for="tbDosageCompositionPackaging" class="col-sm-3 control-label">Dosage forms, composition and packaging</label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDosageCompositionPackaging" name="tbDosageCompositionPackaging" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
     </li>	
</ul>

</asp:Content>
