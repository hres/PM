<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartOne.aspx.cs" Inherits="Product_Monograph.PartOne" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partOne.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="row">
        <div class="col-sm-9">
             <p class="margin-bottom-none"><strong><span class="field-name"><%=brandNameTitle%>:</span></strong><asp:Literal ID="brandName" runat="server"></asp:Literal></p>
             <p><strong><span class="field-name"><%=properNameTitle%>:</span></strong><asp:Literal ID="properName" runat="server"></asp:Literal><p>
         </div>
         <div class="col-sm-3 text-right">
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary " Text="Save a draft"  ToolTip="Please save your form data in a draft file." OnClick="btnSave_Click" ClientIDMode="Static"/> 
         </div> 
    </div>  
<ul class="list-unstyled">
	<li>
        <details class="margin-top-medium">
           <summary id="summaryProductInformation" class="well well-sm"><%=sumProdInfo%></summary>
                <table id="dataTable1" class="table table-bordered table-striped table-hover" title="Summary product information form">
                <caption></caption>
                <thead>
                <tr>
                    <th><input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddRouteOfAdminTextBox('dataTable1')" id="btnAddExtraRouteOfAdmin" /></th>
                    <th><span class="field-name"><%=routeAdministration%></span></th>
                    <th><span class="field-name"><%=dosageForm%></span></th>
                    <th><span class="field-name"><%=strength%></span></th>
                    <th><span class="field-name"><%=nonmedIngred%></span></th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input id="tbBtnRemove" type="button" onclick="deleteRowBtnRow(this)" name="btnDelete" value="<%=removeButton %>" class="btn btn-default btn-xs"/></td>   
                        <td headers="thRouteOfAdminDynamic" data-required="true"><select id="tbRouteOfAdminDynamic" name="tbRouteOfAdminDynamic" class="form-control font-small input-sm"></select></td>
                        <td headers="thDosageForm"><select id="tbDosageFormDynamic" name="tbDosageFormDynamic" class="form-control font-small input-sm"></select></td>                                    
                        <td headers="thStrength"><textarea  id="tbStrengthDynamic" name="tbStrengthDynamic" ></textarea></td>
                        <td headers="thClinicallyRelevant"><textarea  id="tbClinicallyRelevant" name="tbClinicallyRelevant" ></textarea></td>
                    </tr>
                </tbody>
                </table> 
            </details>
        <details class="margin-top-medium">
                <summary id="indicationsClinical" class="well well-sm"><%=sumIndications%></summary>
                <div class="form-group"> 
                     <div class="row"> 
                        <label for="tbbrandName" class="col-sm-3 control-label">
                             <span class="field-name"><%=indicatedFor%></span>
                             <span class="label label-info" title="<%=indicatedForInfo%>"><%=information%></span>
                        </label>
                      </div>
                     <textarea id="tbbrandName" name="tbbrandName" runat="server" class="textarea form-control"></textarea>
                </div>
                <div class="form-group"> 
                     <div class="row">                         
                        <label for="tbGeriatrics" class="control-label col-sm-1"><span class="field-name"><%=geriatrics%></span></label> 
                        <label class="control-label col-sm-1 text-right"> <span class="field-name"> > </span></label> 
                        <input type="number" id="tbGeriatricsAge" name="tbGeriatricsAge" class="form-control col-sm-1" min="1" max="150" size="3"  runat="server"/>  
                        <label for="tbGeriatricsAge" class="control-label col-sm-2 pull-left"><span class="field-name"><%=geriatricsAge%></span></label>                        
                     </div>
                     <textarea id="tbGeriatrics" name="tbGeriatrics" runat="server" class="textarea form-control"></textarea>
                </div>
                <div class="form-group"> 
                    <div class="row"> 
                        <label for="tbPediatrics" class="control-label col-sm-2"><span class="field-name"><%=pediatrics%></span></label>                        
                        <input type="number" id="tbPediatricsAgeX" name="tbPediatricsAge1" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/>
                        <label class="control-label col-sm-1 text-center"> <span class="field-name"> - </span></label>  
                        <input type="number" id="tbPediatricsAgeY" name="tbPediatricsAge2" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/>
                        <label for="tbPediatricsAgeX" class="control-label pull-left"><span class="field-name"><%=periatricsAgeX%> </span></label>   
                        <label class="control-label col-sm-1 text-right"> <span class="field-name"> < </span></label>          
                        <input type="number" id="tbPediatricsAgeZ" name="tbPediatricsAgeZ" class="form-control col-sm-1" min="1" max="150" size="3" runat="server"/> 
                        <label for="tbPediatricsAgeZ" class="control-label col-sm-3 pull-left"><span class="field-name"><%=pediatricsAge%></span></label>                         
                    </div> 
                    <textarea id="tbPediatrics" name="tbPediatrics" runat="server" class="textarea form-control"></textarea>
                </div>
                </details>
        <details class="margin-top-medium">
                    <summary id="contraindications" class="well well-sm"><%=sumContraindications%></summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                                                    
                             <label for="tbContraindications" class="col-sm-3 control-label">
                             <span class="field-name"><%=contraindications%></span>
                             <span class="label label-info" title="<%=contraindicationsInfo%>"><%=information%></span>
                        </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbContraindications" name="tbContraindications" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddContraindications()" id="btnContraindications" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraContraindications">
                    </div>             
            </details>
        <details class="margin-top-medium">
                    <summary id="seriousWarnings" class="well well-sm"><%=sumWarnings%></summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbSeriousWarnings" class="col-sm-3 control-label">
                             <span class="field-name"><%=seriousWarnings%></span>
                             <span class="label label-info" title="<%=seriousWarningsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbSeriousWarnings" name="tbSeriousWarnings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddSeriousWarnings()" id="btnAddSeriousWarnings" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraSeriousWarnings">
                    </div>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbHeadings" class="col-sm-3 control-label">
                                     <span class="field-name"><%=headings%></span>
                                     <span class="label label-info" title="<%=headingsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-7">
                                <select id="dlHeadings" name="dlHeadings" class="form-control font-small input-sm"></select>
                                <textarea id="tbHeadings" name="tbHeadings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddHeadings()" id="btnHeadings" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtratbHeadings">
                    </div>
                    <div class="form-group row">                    
                        <label for="tbAdditionalwarnings" class="col-sm-3 control-label">
                            <span class="field-name"><%=addWarnings%></span></label>
                        <div class="col-sm-7"> 
                            <textarea id="tbAdditionalwarnings" name="tbAdditionalwarnings" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                   </div>              
            </details>
           <details class="margin-top-medium">
                    <summary id="adverseReactions" class="well well-sm"><%=sumAdverseReactions%></summary>
                    <div class="form-group row">                    
                        <label for="tbAdverseReactions" class="col-sm-3 control-label">
                            <span class="field-name"><%=adverseReaction%></span>
                            <span class="label label-info" title="<%=adverseReactionInfo%>"> <%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbAdverseReactions" name="tbAdverseReactions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="drugInteractions" class="well well-sm"><%=sumDrugInteractions%></summary>
                     <div class="form-group row">                    
                        <label for="tbSeriousDrugInteractions" class="col-sm-3 control-label">
                            <span class="field-name"><%=seriousInteractions%></span>
                            <span class="label label-info" title="<%=seriousInteractionsInfo%>"><%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSeriousDrugInteractions" name="tbSeriousDrugInteractions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
                 <div class="form-group row">                    
                        <label for="tbDrugInteractions" class="col-sm-3 control-label">
                            <span class="field-name"><%=interactionOverview%></span>
                            <span class="label label-info" title="<%=interactionOverviewInfo%>"><%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDrugInteractions" name="tbDrugInteractions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="dosageAdministration" class="well well-sm"><%=sumDosage%></summary>
                    <div class="brdr-bttm" >
                        <div class="form-group row">                    
                             <label for="tbDosageConsiderations" class="col-sm-3 control-label">
                                   <span class="field-name"><%=dosingConsiderations%></span>
                                   <span class="label label-info" title="<%=dosingConsiderationsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-7"> 
                                <textarea id="tbDosageConsiderations" name="tbDosageConsiderations" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddDosageConsiderations()" id="btnDosageConsiderations" />
                            </div>   
                        </div> 
                    </div>
                    <div id="divExtraDosageConsiderations">
                    </div>
                    <div class="form-group row">                    
                            <label for="tbDosageAdjustment" class="col-sm-3 control-label">
                                   <span class="field-name"><%=recommendedDose%></span>
                                   <span class="label label-info" title="<%=recommendedDoseInfo%>"><%=information%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageAdjustment" name="tbDosageAdjustment" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                     <div class="form-group row">                                               
                            <label for="tbDosageMissed" class="col-sm-3 control-label">
                                <span class="field-name"><%=missedDose%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageMissed" name="tbDosageMissed" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                    <div class="form-group row">                    
                            <label for="tbDosageAdministration" class="col-sm-3 control-label">
                                <span class="field-name"><%=administration%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageAdministration" name="tbDosageAdministration" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div> 
                    <div class="form-group row">                    
                            <label for="tbDosageReconstitution" class="col-sm-3 control-label">
                                <span class="field-name"><%=reconstitution%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageReconstitution" name="tbDosageReconstitution" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                    </div>  
                  <div class="form-group row">                    
                            <label for="tbDosageOral" class="col-sm-3 control-label">
                                <span class="field-name"><%=oralSolutions%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageOral" name="tbDosageOral" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                   </div>
                <div>
                    <table id="dataTable2" class="table table-bordered table-striped table-hover" title="Parenteral products">
                        <caption class="text-left"><span class="field-name"><%=parenteralProd%></span></caption>
                        <thead>
                        <tr>
                            <th><input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddParenteralProducts('dataTable2')" id="btnAddParenteralProducts" /></th>
                            <th><span class="field-name"><%=vialSize%></span></th>
                            <th><span class="field-name"><%=volumediluent %></span></th>
                            <th><span class="field-name"><%=availableVolume%></span></th>
                            <th><span class="field-name"><%=concentration%></span></th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input id="btnParenteralProductRemove" type="button" onclick="deleteParenteralProduct(this)" name="btnDelete" value="<%=removeButton %>" class="btn btn-default btn-xs"/></td>   
                                <td headers="thVial"><textarea  id="tbVial" name="tbVial" ></textarea></td>
                                <td headers="thVolume"><textarea  id="tbVolume" name="tbVolume" ></textarea></td>                                    
                                <td headers="thApproximate"><textarea  id="tbApproximate" name="tbApproximate" ></textarea></td>
                                <td headers="thNominal"><textarea  id="tbNominal" name="tbNominal" ></textarea></td>
                            </tr>
                        </tbody>
                    </table> 
                    <p> <%=parenteralProdInfo%></p>         
                       
                </div> 
                              
                            
             </details>

            <details class="margin-top-medium">
                    <summary id="overdosage" class="well well-sm"><%=sumOverdosage%></summary>
                    <div class="form-group row">                    
                        <label for="tbOverdosage" class="col-sm-3 control-label">
                            <span class="field-name"><%=overdosage%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbOverdosage" name="tbOverdosage" class="textarea form-control input-sm" runat="server">For management of a suspected drug overdose, contact your regional Poison Control Centre.</textarea>
                        </div>                   
                    </div> 
                    
            </details>
            <details class="margin-top-medium">
                    <summary id="actionClinicalPharmacology" class="well well-sm"><%=sumClinicalPharmacology%></summary>
                     <div class="form-group row">                    
                        <label for="tbMechanismAction" class="col-sm-3 control-label">
                            <span class="field-name"><%=mechanismAction%></span>
                            <span class="label label-info" title="<%=mechanismActionInfo%>"><%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbMechanismAction" name="tbMechanismAction" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
                     <div class="form-group row">                    
                        <label for="tbPharmacodynamics" class="col-sm-3 control-label">
                            <span class="field-name"><%=pharmacodynamics%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbPharmacodynamics" name="tbPharmacodynamics" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div>
                    <div class="form-group row">                    
                        <label for="tbSpecialPopulationsConditions" class="col-sm-3 control-label">
                            <span class="field-name"><%=populationsConditions%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSpecialPopulationsConditions" name="tbSpecialPopulationsConditions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div>  
            </details>
<%--            <details class="margin-top-medium">
                    <summary id="specialPopulationsConditions" class="well well-sm">Special Populations and Conditions</summary>
            </details>--%>
            <details class="margin-top-medium">
                    <summary id="storageStability" class="well well-sm"><%=sumStorage%></summary>
                    <div class="form-group row">                    
                        <label for="tbStorageStability" class="col-sm-3 control-label">
                            <span class="field-name"><%=storagestability%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbStorageStability" name="tbStorageStability" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="specialHandling" class="well well-sm"><%=sumSpecialHandling%></summary>
                    <div class="form-group row">                    
                        <label for="tbSpecialHandling" class="col-sm-3 control-label">
                            <span class="field-name"><%=handlingInstruction%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSpecialHandling" name="tbSpecialHandling" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
            <details class="margin-top-medium">
                    <summary id="DosageCompositionPackaging" class="well well-sm"><%=sumDosageForm%></summary>
                    <div class="form-group row">                    
                        <label for="tbDosageCompositionPackaging" class="col-sm-3 control-label">
                            <span class="field-name"><%=compositionPackaging%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbDosageCompositionPackaging" name="tbDosageCompositionPackaging" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
     </li>	
</ul>

</asp:Content>
