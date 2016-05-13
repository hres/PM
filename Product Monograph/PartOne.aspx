<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartOne.aspx.cs" Inherits="Product_Monograph.PartOne" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partOne.js"></script>
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
            <asp:Button ID="btnSaveDraft" runat="server" cssclass="btn btn-primary " OnClick="btnSave_Click" ClientIDMode="Static"/> 
              <input type="reset" value="Reset" class="btn btn-default mrgn-lft-md">
         </div> 
    </div>  
<ul class="list-unstyled">
	<li>
        <!--Summary product information-->
        <details class="margin-top-medium">
           <summary id="summaryProductInformation" class="well well-sm"><%=sumProdInfo%></summary>
                <table id="dataTable1" class="table table-bordered table-striped table-hover" title="<%=productInfoTableTitle%>">
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
        <!--Indications and clinical use-->
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
        <!--Contraindications-->
        <details class="margin-top-medium">
                    <summary id="contraindications" class="well well-sm"><%=sumContraindications%></summary>
                        <div class="form-group row">                                                    
                             <label for="tbContraindications" class="col-sm-3 control-label">
                             <span class="field-name"><%=contraindications%></span>
                             <span class="label label-info" title="<%=contraindicationsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-9"> 
                                <textarea id="tbContraindications" name="tbContraindications" class="textarea form-control"  runat="server"></textarea>
                             </div>                           
                        </div>
<%--                    <div id="divExtraContraindications">
                    </div>     --%>        
            </details>
        <!--Warnings and precautions-->
        <details class="margin-top-medium">
                    <summary id="seriousWarnings" class="well well-sm"><%=sumWarnings%></summary>
                        <div class="form-group row">                    
                             <label for="tbSeriousWarnings" class="col-sm-3 control-label">
                             <span class="field-name"><%=seriousWarnings%></span>
                             <span class="label label-info" title="<%=seriousWarningsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-9"> 
                                <textarea id="tbSeriousWarnings" name="tbSeriousWarnings" class="textarea form-control" runat="server" ></textarea>
                             </div>
<%--                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddSeriousWarnings()" id="btnAddSeriousWarnings" />
                            </div>  --%> 
                        </div> 
<%--                    <div id="divExtraSeriousWarnings">
                    </div>--%>
                    <div class="form-group row">                    
                             <label for="tbHeadings" class="col-sm-3 control-label">
                                     <span class="field-name"><%=headings%></span>
                                     <span class="label label-info" title="<%=headingsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-7">
                                <select id="dlHeadings" name="dlHeadings" class="form-control font-small input-sm"></select>
                                <textarea id="tbHeadings" name="tbHeadings" class="textarea form-control"  ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddHeadings()" id="btnHeadings" />
                            </div>   
                    </div> 
                    <div id="divExtratbHeadings">
                    </div>
                  <%-- <div class="form-group row brdr-bttm">                    
                            <p  class="col-sm-3">
                                <span class="field-name"><strong>Special populations</strong></span>
                            </p>
                            <div class="clearfix"></div>                                              
                    </div>
                   <div class="form-group row">                    
                            <label for="tbPregnant" class="col-sm-3 control-label">
                                <span class="field-name mrgn-lft-md">Pregnant women</span>
                            </label>
                            <div class="col-sm-9"> 
                                <textarea id="tbPregnant" name="tbPregnant" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                   </div>
                 <div class="form-group row">                    
                                <label for="tbNursing" class="col-sm-3 control-label">
                                    <span class="field-name mrgn-lft-md">Nursing women</span>
                                </label>
                                <div class="col-sm-9"> 
                                    <textarea id="tbNursing" name="tbNursing" class="textarea form-control" runat="server"></textarea>
                                </div>                   
                 </div> 
                 <div class="form-group mrgn-lft-md">                    
                        <div class="row"> 
                          <label for="tbSpecialPediatrics" class="control-label col-sm-2"><span class="field-name"><%=pediatrics%></span></label>                        
                            <input type="number" id="tbSpecialPediatricsAgeX" name="tbSpecialPediatricsAgeX" class="form-control col-sm-1 input-sm" min="1" max="150" size="3" runat="server"/>
                            <label for="tbSpecialPediatricsAgeX" class="control-label col-sm-1 text-center" > <span class="field-name"> &#45; </span></label>  
                            <input type="number" id="tbSpecialPediatricsAgeY" name="tbSpecialPediatricsAgeY" class="form-control col-sm-1 input-sm" min="1" max="150" size="3" runat="server"/>
                            <label for="tbSpecialPediatricsAgeY" class="control-label pull-left"><span class="field-name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pediatricsAge%></span></label>   
                            <label class="control-label col-sm-1"> <span class="field-name"> &nbsp;or &nbsp; &#60; </span></label>          
                            <input type="number" id="tbSpecialPediatricsAgeZ" name="tbSpecialPediatricsAgeZ" class="form-control col-sm-1 input-sm" min="1" max="150" size="3" runat="server"/> 
                            <label for="tbSpecialPediatricsAgeZ" class="control-label col-sm-3 pull-left"><span class="field-name"><%=pediatricsAge%></span></label>    
                         </div> 
                         <textarea id="tbSpecialPediatrics" name="tbSpecialPediatrics" class="textarea form-control" runat="server"></textarea>                
                 </div>
                <div class="form-group mrgn-lft-md"> 
                        <div class="row">                         
                              <label for="tbSpecialGeriatrics" class="control-label col-sm-1"><span class="field-name"><%=geriatrics%></span></label> 
                              <label class="control-label col-sm-1 text-right"> <span class="field-name"> > </span></label> 
                              <input type="number" id="tbSpecialGeriatricsAge" name="tbSpecialGeriatricsAge" class="form-control col-sm-1 input-sm" min="1" max="150" size="3"  runat="server"/>  
                              <label for="tbSpecialGeriatricsAge" class="control-label col-sm-2 pull-left"><span class="field-name"><%=geriatricsAge%></span></label>    
                        </div>
                        <textarea id="tbSpecialGeriatrics" name="tbSpecialGeriatrics " class="textarea form-control" runat="server"></textarea> 
                 </div>
                <div class="form-group mrgn-lft-md">                    
                                <label for="tbMonitoring" class="control-label">
                                    <span class="field-name ">Monitoring and laboratory tests</span>
                                </label>
                                <textarea id="tbMonitoring" name="tbMonitoring " class="textarea form-control" runat="server"></textarea>
                 </div>                  --%>
            </details>
        <!--Adverse reactions-->
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
                    <div class="form-group row">                    
                        <label for="tbAdverseDrugReactions" class="col-sm-3 control-label">
                            <span class="field-name"><%=CTAdverseReaction%></span>
                            <span class="label label-info" title="<%=CTAdverseReactionInfo%>"><%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbAdverseDrugReactions" name="tbAdverseDrugReactions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
                <div class="form-group row">                    
                        <div class="row">                         
                             <label for="tbReactionsTableNo" class="control-label col-sm-5 mrgn-lft-md"><span class="field-name"><%=CTAdverseReactionTable%></span></label>
                             <input type="text" id="tbReactionsTableNo" name="tbReactionsTableNo" class="form-control input-sm col-sm-1" runat="server" size="3"/>  
							 <label for="tbReactionsTableTitle" class="control-label col-sm-1 text-center"> <span class="field-name"> - </span></label> 
							 <div class="col-sm-5">
                                <input type="text" id="tbReactionsTableTitle" name="tbReactionsTableTitle" class="form-control input-sm" size="30" runat="server"/>  	
                             </div> 						  
                        </div>
                         <div class="mrgn-lft-md"> 
                                <table id="adverseReactionsTable" class="table table-bordered table-striped table-hover">
                                    <caption> </caption>                
                                    <thead>
                                    <tr>
                                        <th><input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddAdverseReactionsTable('adverseReactionsTable')" id="btnAdverseReactionsTable" /></th>
                                        <th></th>
                                        <th>
                                               <input type="text" id="tbDrugnameTitle" name="tbDrugnameTitle" class="form-control input-sm col-sm-3" placeholder="Drug name" runat="server"/>
                                               <label for="tbDrugnameTitle" class="control-label col-sm-1 mrgn-lft-0"><span class="field-name">n=</span></label>
                                               <input type="text" id="tbDrugnameNo" name="tbDrugnameNo" class="form-control input-sm col-sm-1 mrgn-lft-md" size="3" runat="server" />
                                               <label for="tbDrugnameNo" class="control-label col-sm-1"> <span class="field-name">(%)</span></label>
                                        </th>
                                        <th>  <input type="text" id="tbPalcebo" name="tbPalcebo" class="form-control input-sm col-sm-3" placeholder="Place bo" runat="server"/>
                                               <label for="tbPalcebo" class="control-label col-sm-1 mrgn-lft-0"><span class="field-name">n=</span></label>
                                               <input type="text" id="tbPalceboNo" name="tbPalceboNo" class="form-control input-sm col-sm-1 mrgn-lft-md" size="3" runat="server" />
                                               <label for="tbPalceboNo" class="control-label col-sm-1"> <span class="field-name">(%)</span></label>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input id="btnRemoveAdverseReactionsTable" type="button" onclick="DeleteAdverseReactionsTable(this)" name="btnDelete" value="<%=removeButton %>" class="btn btn-default btn-xs"/></td>   
                                            <td><input type="text" id="tbClinicalTrial" name="tbClinicalTrial" class="form-control input-sm" /></td>
                                            <td><textarea  id="tbDrugName" name="tbDrugName" ></textarea></td>                                    
                                            <td><textarea  id="tbPlacebo" name="tbPlacebo" ></textarea></td>
                                        </tr>
                                    </tbody>
                                </table> 
                         </div>                  
                 </div> 
                    <div class="form-group row">                    
                        <label for="tbAdverseReactionsSupplement" class="col-sm-3 control-label">
                            <span class="field-name"><%=CTAdReactSupplement%></span>
                            <span class="label label-info" title="<%=CTAdReactSupplementInfo%>"> <%=information%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbAdverseReactionsSupplement" name="tbAdverseReactionsSupplement" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div> 
            </details>
        <!--Drug interactions-->
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
                <div class="form-group row">                    
                             <label for="tbDrugHeadings" class="col-sm-3 control-label">
                                     <span class="field-name"><%=headings%></span>
                                     <span class="label label-info" title="<%=headingsInfo%>"><%=information%></span>
                             </label>
                             <div class="col-sm-7">
                                <select id="dlDrugHeadings" name="dlDrugHeadings" class="form-control font-small input-sm"></select>
                                <textarea id="tbDrugHeadings" name="tbDrugHeadings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddDrugHeadings()" id="btnDrugHeadings" />
                            </div>   
                        </div>
                 <div id="divExtratbDrugHeadings"></div>
                <table id="druginteractionTable" class="table table-bordered table-striped table-hover margin-bottom-none">
                            <caption class="text-left h5 mrgn-tp-0"><%=drugDrugInteraction%></caption>
                            <thead>
                            <tr>
                                <th><input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddDruginteractionTable('druginteractionTable')" id="btnAddDruginteractionTable" /></th>
                                <th><span class="field-name"><%=properNameTitle%></span></th>
                                <th><span class="field-name"><%=refTitle%></span>&nbsp;<span class="label label-info" title="<%=refInfo%>"><%=information%></span></th>
                                <th><span class="field-name"><%=effect%></span>&nbsp;<span class="label label-info" title="<%=effectInfo%>"><%=information%></span></th>
                                <th><span class="field-name"><%=clinicalComment%></span>&nbsp;<span class="label label-info" title="<%=clinicalCommentInfo%>"><%=information%></span></th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input id="btnDruginteractionTableRemove" type="button" onclick="deleteDruginteractionTable(this)" name="btnDelete" value="<%=removeButton%>" class="btn btn-default btn-xs"/></td>   
                                    <td headers="thProperName"><textarea  id="tbProperName" name="tbProperName" ></textarea></td>
                                    <td headers="thRef"><textarea  id="tbRef" name="tbRef" ></textarea></td>              
                                    <td headers="thEffect"><textarea  id="tbEffect" name="tbEffect" ></textarea></td>
							        <td headers="thClinical"><textarea  id="tbClinical" name="tbClinical" ></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                       <div><span class="mrgn-tp-0"><%=legendInfo%></span></div>
            </details>
        <!--Dosage and administration-->
        <details class="margin-top-medium">
                    <summary id="dosageAdministration" class="well well-sm"><%=sumDosage%></summary>
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
                    <div class="form-group row brdr-bttm">                    
                            <p  class="col-sm-3">
                                <span class="field-name"><strong><%=reconstitution%></strong></span>
                                <span class="label label-info" title="<%=parenteralProdInfo%>"><%=information%></span> 
                            </p>
                            <div class="clearfix"></div>                                              
                    </div>  
                <div class="form-group row">                    
                            <label for="tbDosageOral" class="col-sm-3 control-label">
                                <span class="field-name mrgn-lft-md"><%=oralSolutions%></span>
                            </label>
                            <div class="col-sm-7"> 
                                <textarea id="tbDosageOral" name="tbDosageOral" class="textarea form-control" runat="server"></textarea>
                            </div>                   
                   </div>
                <div>
                    <table id="dataTable2" class="table table-bordered table-striped table-hover" title="<%=parenteralProdTitle%>">
                        <caption class="text-left mrgn-lft-md"><span class="field-name"><%=parenteralProd%></span></caption>
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
                    
                </div>     
             </details>
        <!--Overdosage-->
        <details class="margin-top-medium">
                    <summary id="overdosage" class="well well-sm"><%=sumOverdosage%></summary>
                    <div class="form-group row">                    
                        <label for="tbOverdosage" class="col-sm-3 control-label">
                            <span class="field-name"><%=overdosage%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbOverdosage" name="tbOverdosage" class="textarea form-control input-sm" runat="server"></textarea>
                        </div>                   
                    </div> 
                    
            </details>
        <!--Action and clinical pharmacology-->      
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
                             <label for="tbActionHeadings" class="col-sm-3 control-label">
                                     <span class="field-name"><%=pharmacokinetics%></span>
                             </label>
                             <div class="col-sm-7">
                                <select id="dlActionHeadings" name="dlActionHeadings" class="form-control font-small input-sm"></select>
                                <textarea id="tbActionHeadings" name="tbActionHeadings" class="textarea form-control" ></textarea>
                             </div>
                            <div class="col-sm-2 text-right"> 
                                <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddActionHeadings()" id="btnActionHeadings" />
                            </div>   
                        </div> 
                     <div id="divExtratbActionHeadings"></div>               
                 <table id="pharmacokineticsTable" class="table table-bordered table-striped table-hover" title="<%=PharmacokineticsTableTitle%>">
                    <caption class="text-left h5 mrgn-tp-0"><%=pharmacokineticParameters %></caption>
                    <thead>
                    <tr>
                        <th><input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddPharmacokineticsTable('pharmacokineticsTable')" id="btnAddPharmacokineticsTable" /></th>
                        <th><span class="field-name"><%=cmax %></span></th>
                        <th><span class="field-name"><%=halfLifeTitle %></span></th>
                        <th><span class="field-name"><%=auc%></span></th>
                        <th><span class="field-name"><%=clearance %></span></th>
						<th><span class="h5"><%=volDistribution %></span></th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input id="btnPharmacokineticsTableRemove" type="button" onclick="deletePharmacokineticsTable(this)" name="btnDelete" value="<%=removeButton%>" class="btn btn-default btn-xs"/></td>   
                            <td headers="thCmax"><textarea  id="tbCmax" name="tbCmax" ></textarea></td>
                            <td headers="thT12h"><textarea  id="tbT12h" name="tbT12h" ></textarea></td>                                    
                            <td headers="thAuc"><textarea  id="tbAuc" name="tbAuc" ></textarea></td>
                            <td headers="thClearance"><textarea  id="tbClearance" name="tbClearance" ></textarea></td>
							<td headers="thVolumnDis"><textarea  id="tbVolumeDis" name="tbVolumeDis" ></textarea></td>
                        </tr>
                    </tbody>
                </table> 
                <div class="form-group row">                    
                        <label for="tbSpecialPopulationsConditions" class="col-sm-3 control-label">
                            <span class="field-name"><%=populationsConditions%></span>
                        </label>
                        <div class="col-sm-9"> 
                            <textarea id="tbSpecialPopulationsConditions" name="tbSpecialPopulationsConditions" class="textarea form-control" runat="server"></textarea>
                        </div>                   
                    </div>          
            </details>
       <!--Storage and stability--> 
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
       <!--Special handling instructions--> 
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
       <!--Dosage forms, composition and packaging--> 
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
