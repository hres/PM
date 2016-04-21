<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartThree.aspx.cs" Inherits="Product_Monograph.PartThree" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partThree.js"></script>
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
<details class="margin-top-medium">
        <summary id="SUM_ABOUT">About this medication</summary>
        <div class="form-group row">
            <asp:label id="lblWHAT" associatedcontrolid="tbMedicationForText" runat="server" cssclass="col-sm-3 control-label">What the medication is used for</asp:label>
            <div class="col-sm-9">
                <textarea id="tbMedicationForText" name="tbMedicationForText" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <asp:label associatedcontrolid="tbMedicationDoes" id="lblWHAT_IT_DOES" cssclass="col-sm-3 control-label" runat="server">What it does</asp:label>
            <div class="col-sm-9">
                <textarea id="tbMedicationDoes" name="tbMedicationDoes" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>

        <div class="form-group row">
            <asp:label id="lblWHEN_IT_SHOULD" associatedcontrolid="tbMedicationNotUsed" cssclass="col-sm-3 control-label" runat="server">When it should not be used</asp:label>
            <div class="col-sm-9">
                <textarea id="tbMedicationNotUsed" name="tbMedicationNotUsed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>

        <div class="form-group row">
            <asp:label id="lblWHAT_THE_MEDICINAL" associatedcontrolid="tbMedicationIngredient" cssclass="col-sm-3 control-label" runat="server">What the medicinal ingredient is</asp:label>  
            <div class="col-sm-9">
                <textarea id="tbMedicationIngredient" name="tbMedicationIngredient" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">  
             <label for="tbMedicationNonmed" class="col-sm-3 control-label">
                 <span class="field-name">What the nonmedicinal ingredients are</span>
                 <span class="label label-info" title="For a full listing of nonmedicinal ingredients see Part 1 of the product monograph.">Info</span>
             </label> 
            <div class="col-sm-9">
                <textarea id="tbMedicationNonmed" name="tbMedicationNonmed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <asp:label id="lblWHAT_DOSAGE" associatedcontrolid="tbMedicationDosageForm" cssclass="col-sm-3 control-label" runat="server">What dosage forms it comes in</asp:label>
            <div class="col-sm-9">
                <textarea id="tbMedicationDosageForm" name="tbMedicationDosageForm" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
    </details>

<details class="margin-top-medium">
        <summary id="SUM_WARNINGS"> Warnings and precautions</summary>
        <div class="form-group row"> 
                  <label for="tbSeriousWarningsPrecautions" class="col-sm-3 control-label">
                     <span class="field-name">Serious warnings and precaution</span>
                     <span class="label label-info" title="Activities (Warnings and Precautions, e,g, under Occupational Hazards)
Current conditions (Contraindications, Warnings and Precautions)
Past diseases (Contraindications, Warnings and Precautions)
Reproductive issues (Contraindications, Warnings and Precautions)
Anticipated medical procedures (Warnings and Precautions)
Any allergies to this drug or its ingredients or components of the container (Contraindications)">Info</span>
                  </label>  
         
                  <div class="col-sm-7">                                          
                      <textarea id="tbSeriousWarningsPrecautions" name="tbSeriousWarningsPrecautions" class="textarea form-control" ></textarea>  
                  </div>
                  <div class="col-sm-2 text-right"> 
                      <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddSeriousWarningsPrecautions()" id="btnAddSeriousWarningsPrecautions" />
                  </div>                                                         
        </div>       
        <div id="dvExtraSeriousWarningsPrecautions">
        </div>
    </details>

<details class="margin-top-medium">
        <summary id="SUM_INTERACTIONS">Interactions with this medication</summary>
        <div class="form-group row">
            <label for="tbInteractionWithMed" class="col-sm-3 control-label">
                     <span class="field-name">Interactions with this medication</span>
                     <span class="label label-info" title="Drugs that may interact with">Info</span>
            </label>  

            <div class="col-sm-9">
                <textarea id="tbInteractionWithMed" name="tbInteractionWithMed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
    </details>

 <details class="margin-top-medium">
        <summary id="SUM_PROPER_USE">Proper use of this medication</summary>        
        <div class="form-group row">
                <asp:Label ID="lblProperUse" AssociatedControlID="tbProperUseMed" CssClass="col-sm-3 control-label" runat="server">Proper use of this medication</asp:label> 
                <div class="col-sm-9">                    
                    <textarea id="tbProperUseMed" name="tbProperUseMed" runat="server" class="textarea form-control"></textarea>
                </div>         
        </div>
        <div class="form-group row">
                <asp:Label id="lblUsualDose" AssociatedControlID="tbUsualDose" CssClass="col-sm-3 control-label" runat="server">Usual dose</asp:Label>            
                <div class="col-sm-9">                    
                    <textarea id="tbUsualDose" name="tbUsualDose" runat="server" class="textarea form-control"></textarea>
                </div>            
        </div>
        <div class="form-group">
            <div class="row">  
                      <label for="fustrucform1" class="col-sm-3 control-label">Usual does file</label>  
                    <div class="col-sm-9">               
                        <input type="file" id="fustrucform0" onchange="loadFile('fustrucform0', 'fuimage0','tbfuimagename0','tbfuimagebasesixtyfour0')"/>     
                    </div>           
            </div>             
            <div class="row">             
                   <div class="col-sm-3"></div>
                   <div class="col-xs-3">
                        <img id="fuimage0" src="./images/x.png" class="img-thumbnail"  alt=""/>
                        <input type="text"  class="hidden" id="tbfuimagename0" name="tbfuimagename0" />
                        <input type="text"  class="hidden" id="tbfuimagebasesixtyfour0" name="tbfuimagebasesixtyfour0"  />  
                   </div>
             </div> 
        </div>
        
        
        <div class="form-group row">              
                    <label for="tbOverdose" class="col-sm-3 control-label">
                         <span class="field-name">Over dose</span>
                         <span class="label label-info" title="The boxed message may be modified to provide the most appropriate advice according to current standards of care for this drug product">Info</span>
                    </label>  
                    <div class="col-sm-9">                               
                        <textarea id="tbOverdose" name="tbOverdose" runat="server" class="textarea form-control"></textarea>
                    </div>
         </div> 
         <div class="form-group">
            <div class="row">  
                     <label for="fustrucform1" class="col-sm-3 control-label">Over does file</label>  
                     <div class="col-sm-9">  
                        <input type="file" id="fustrucform1" onchange="loadFile('fustrucform1','fuimage1','tbfuimagename1','tbfuimagebasesixtyfour1')" />
                     </div>
            </div>
               <div class="row">             
                   <div class="col-sm-3"></div>
                   <div class="col-xs-3">
                        <img id="fuimage1" src="./images/x.png" class="img-thumbnail" alt=""/>
                        <input type="text" class="hidden" id="tbfuimagename1" name="tbfuimagename1"/>
                        <input type="text" class="hidden" id="tbfuimagebasesixtyfour1" name="tbfuimagebasesixtyfour1" />
                   </div>
            </div>
        </div>
        <div class="form-group row">
            <asp:label id="lblMissedDose" associatedcontrolid="tbMissedDose" cssclass="col-sm-3 control-label" runat="server">Missed dose</asp:label>
            <div class="col-sm-9">
                <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea form-control"></textarea>
            </div>
        </div> 
        <div class="form-group">
            <div class="row">  
                    <label for="fustrucform1" class="col-sm-3 control-label">Missed does file</label>  
                    <div class="col-sm-9">  
                        <input type="file" id="fustrucform2" onchange="loadFile('fustrucform2','fuimage2','tbfuimagename2','tbfuimagebasesixtyfour2')" />
                    </div>
             </div>
             <div class="row">             
                   <div class="col-sm-3"></div>
                   <div class="col-xs-3">
                        <img id="fuimage2" src="./images/x.png" class="img-thumbnail" alt="" />
                        <input type="text" id="tbfuimagename2" name="tbfuimagename2" class="hidden"/>
                        <input type="text" id="tbfuimagebasesixtyfour2" name="tbfuimagebasesixtyfour2" class="hidden" />
                   </div>
            </div>
        </div>
      
</details>

<details class="margin-top-medium">
        <summary id="SUM_SIDE_EFFECTS">Side effects and what to do about them</summary>
        <div class="form-group row ">
            <label for="tbSideEffects" class="control-label col-sm-3" ><span class="field-name">Side effects</span></label>     
            <div class="col-sm-9">                  
                    <textarea id="tbSideEffects" name="tbSideEffects" runat="server" class="textarea form-control"></textarea>
            </div>
         </div>
        <!--SideEffects Table -->              
        <section>
            <div class="wb-eqht row margin-top-medium">
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm"><p>Frequency</p></div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm"><p>Symptom</p></div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocIfSever" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%">Talk with your doctor only if server</asp:TextBox>
                </div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocAllCases" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%">Talk with your doctor in all cases</asp:TextBox>
                </div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-rght brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbStoptakingdrug" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%">Stop taking drug</asp:TextBox>
                </div>
            </div>
        </section>

        <section>
            <div class="wb-eqht row">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p>Common</p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddCommonSymptomsTextBox()" id="btnAddExtrCommonSymptoms" />
                </div>
            </div>
        </section>

        <section>
            <div id="Common0" class="wb-eqht row">
                <div class="col-xs-2 brdr-lft brdr-bttm wb-eqht">
                    <input class="form-control" title="Common frequency" type="text" id="tbCommonFrequency0" name="tbCommonFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm wb-eqht">
                    <input class="form-control" title="Common symptom" type="text" id="tbCommonSymptom0" name="tbCommonSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm wb-eqht">
                    <input class="form-control" title="Common severe" type="checkbox" id="cbCommonSevere0" name="cbCommonSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm wb-eqht">
                    <input class="form-control" title="Common all cases" type="checkbox" id="cbCommonAllCases0" name="cbCommonAllCases0" />
                </div>
                <div class="col-xs-2 brdr-rght brdr-lft brdr-bttm wb-eqht">
                    <input class="form-control" title="Common stop taking" type="checkbox" id="cbCommonStoptaking0" name="cbCommonStoptaking0" />
                </div>
                <div class="col-xs-2 wb-eqht">
                    <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveCommon(0)" id="btnRemoveCommon" />
                </div>
            </div>
            <div id="dvExtraCommonSymptoms" >
            </div>
        </section>
        <section>
            <div class="wb-eqht row">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p>Uncommon</p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddUncommonSymptomsTextBox()" id="btnAddExtrUncommonSymptoms" />
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="wb-eqht col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Uncommon frequency" class="form-control" id="tbUncommonFrequency0" name="tbUncommonFrequency0" />
                </div>
                <div class="wb-eqht col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Uncommon symptom" class="form-control" id="tbUncommonSymptom0" name="tbUncommonSymptom0" />
                </div>
                <div class="wb-eqht col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Uncommon severe" class="form-control" id="cbUncommonSevere0" name="cbUncommonSevere0" />
                </div>
                <div class="wb-eqht col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Uncommon all cases" class="form-control" id="cbUncommonAllCases0" name="cbUncommonAllCases0" />
                </div>
                <div class="wb-eqht col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Uncommon stop taking" class="form-control" id="cbUncommonStoptaking0" name="cbUncommonStoptaking0" />
                </div>
                <div class="wb-eqht col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveUncommon(0)" id="btnRemoveUncommon" />
                </div>
            </div>
            <div id="dvExtraUncommonSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p>Rare</p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddRareSymptomsTextBox()" id="btnAddExtrRareSymptoms" />
                </div>
            </div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Rare frequency" class="form-control" id="tbRareFrequency0" name="tbRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Rare symptom" class="form-control" id="tbRareSymptom0" name="tbRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Rare severe" class="form-control" id="cbRareSevere0" name="cbRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Rare all cases" class="form-control" id="cbRareAllCases0" name="cbRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Rare stop taking" class="form-control" id="cbRareStoptaking0" name="cbRareStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveRare(0)" id="btnRemoveRare" />
                </div>
            </div>
            <div id="dvExtraRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
               <div class="col-xs-2 brdr-lft brdr-bttm"><p>Very rare</p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddVeryRareSymptomsTextBox()" id="btnAddExtrVeryRareSymptoms" />
                </div>
            </div>
        </section>
        
        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="text" title="Very rare frequency" class="form-control" id="tbVeryRareFrequency0" name="tbVeryRareFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Very rare symptom" class="form-control" id="tbVeryRareSymptom0" name="tbVeryRareSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="checkbox" title="Very rare severe" class="form-control" id="cbVeryRareSevere0" name="cbVeryRareSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">                    
                    <input type="checkbox" title="Very rare all cases" class="form-control" id="cbVeryRareAllCases0" name="cbVeryRareAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">                    
                    <input type="checkbox" title="Very rare stop taking" class="form-control" id="cbVeryRareStoptaking0" name="cbVeryRareStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveVeryRare(0)" id="btnRemoveVeryRare" />
                </div>
            </div>
            <div id="dvExtraVeryRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
               <div class="col-xs-2 brdr-lft brdr-bttm"><p>Unknown</p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Add" onclick="AddUnknownSymptomsTextBox()" id="btnAddExtrUnkownSymptoms" />
                </div>
            </div>
        </section>
    
        <section>
            <div class="row wb-eqht" id="Unknown0">
                <div class="col-xs-2 brdr-lft brdr-bttm">                   
                    <input type="text" title="Unknown frequency" class="form-control" id="tbUnknownFrequency0" name="tbUnknownFrequency0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="text" title="Unknown symptom" class="form-control" id="tbUnknownSymptom0" name="tbUnknownSymptom0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Unknown severe" class="form-control" id="cbUnknownSevere0" name="cbUnknownSevere0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-bttm">
                    <input type="checkbox" title="Unknown all cases" class="form-control" id="cbUnknownAllCases0" name="cbUnknownAllCases0" />
                </div>
                <div class="col-xs-2 brdr-lft brdr-rght brdr-bttm">
                    <input type="checkbox" title="Unknown stop taking" class="form-control" id="cbUnknownStoptaking0" name="cbUnknownStoptaking0" />
                </div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="Remove" onclick="RemoveUnknown(0)" id="btnRemoveUnknown" />
                </div>
            </div>
            <div id="dvExtraUnknownSymptoms"></div>
        </section>
        <!--End of SideEffects -->
     <div class="clearfix"></div>     
     <div class="form-group margin-bottom-none">
            <p>* This is not a complete list of side effects. For any unexpected effects while taking, contact your doctor or pharmacist.</p>          
         </div>     
         <div class="form-group row ">
            <label for="tbSideEffectsWhatToDo" class="control-label col-sm-3" ><span class="field-name">Side effects and what to do</span></label>
            <div class="col-sm-9">                  
                  <textarea id="tbSideEffectsWhatToDo" name="tbSideEffectsWhatToDo" runat="server" class="textarea"></textarea>
            </div>
         </div>
     
 </details>  
    
 <details class="margin-top-medium">
        <summary id="SUM_HOW_TO_STORE-IT">How to store it</summary>
        <div class="form-group row">
            <div class="col-sm-3"></div>           
            <div class="col-sm-9">
                <textarea id="tbHowToStore" name="tbHowToStore" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
</details>

<details class="margin-top-medium">
        <summary id="SUM_REPORTING">Reporting supected side effects</summary>
        <div class="form-group row">
            <div class="col-sm-3"></div>
            <div class="col-sm-9">                
                    <textarea id="tbReportingSuspectedSE" name="tbReportingSuspectedSE" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
</details>

<details class="margin-top-medium">
    <summary id="SUM_MORE_INFORMATION">More Information</summary>
    <div class="form-group row">
            <asp:Label ID="lblMoreInfo" AssociatedControlID="tbMoreInformation" CssClass="col-sm-3 control-label" runat="server"></asp:Label>           
            <div class="col-sm-9">                
                <textarea id="tbMoreInformation" name="tbMoreInformation" runat="server" class="textarea form-control"></textarea>
            </div>        
    </div>

    <div class="form-group row">                
            <asp:Label ID="lblLastRevised" AssociatedControlID="tbLastrRevised" CssClass="col-sm-3 control-label" runat="server">Last Modified
                <span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span>
            </asp:Label>   
             <div class="col-sm-9">                 
            <asp:TextBox runat="server" ID="tbLastrRevised" Width="250" name="tbLastrRevised" CssClass="form-control" type="date" data-rule-dateiso="true"></asp:TextBox>
            </div>
       
    </div>
</details> 
<asp:HiddenField runat="server" ID="hdUnknownSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdVeryRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdRareSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdCommonSymptoms" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="hdUncommonSymptoms" ClientIDMode="Static" />
</asp:Content>
