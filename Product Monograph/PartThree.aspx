<%@ Page Title="" Language="C#" MasterPageFile="~/ProdMono.Master" AutoEventWireup="true" CodeBehind="PartThree.aspx.cs" Inherits="Product_Monograph.PartThree" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="./js/pmp.js"></script>
 <script src="./js/partThree.js"></script>
 <script>
     var removeButtonValue = '<%=removeButton%>';       
 </script>
<script>
      tinymce.init({
          mode: "specific_textareas",
          editor_selector: "mceEditor",
          height: 300,
          plugins: [
            'advlist autolink lists link image charmap print preview anchor',
            'searchreplace visualblocks code fullscreen',
            'insertdatetime media table contextmenu paste code'
          ],
          toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
          images_upload_url: 'postAcceptor.php',
      });
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
         </div> 
    </div> 
<!--About this medication-->
<details class="margin-top-medium">
        <summary id="SUM_ABOUT" class="well well-sm"><%=sumMedication%></summary>
        <div class="form-group row">
            <Label id="lblWHAT" for="tbMedicationForText" Class="col-sm-3 control-label">
                <span class="field-name"><%=medicationUse%></span>
            </Label>
            <div class="col-sm-9">
                <textarea id="tbMedicationForText" name="tbMedicationForText" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <Label for="tbMedicationDoes" id="lblWHAT_IT_DOES" Class="col-sm-3 control-label">
                <span class="field-name"><%=medicationDoes%></span>
            </Label>
            <div class="col-sm-9">
                <textarea id="tbMedicationDoes" name="tbMedicationDoes" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>

        <div class="form-group row">
            <Label id="lblWHEN_IT_SHOULD" for="tbMedicationNotUsed" Class="col-sm-3 control-label">
                <span class="field-name"><%=whenNotUse%></span></Label>
            <div class="col-sm-9">
                <textarea id="tbMedicationNotUsed" name="tbMedicationNotUsed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>

        <div class="form-group row">
            <Label id="lblWHAT_THE_MEDICINAL" for="tbMedicationIngredient" Class="col-sm-3 control-label">
                <span class="field-name"><%=medIngredient%></span>
            </Label>  
            <div class="col-sm-9">
                <textarea id="tbMedicationIngredient" name="tbMedicationIngredient" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">  
             <label for="tbMedicationNonmed" class="col-sm-3 control-label">
                 <span class="field-name"><%=nonMedIngredient%></span>
                 <span class="label label-info" title="<%=nonMedIngredientInfo%>"><%=information%></span>
             </label> 
            <div class="col-sm-9">
                <textarea id="tbMedicationNonmed" name="tbMedicationNonmed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <Label id="lblWHAT_DOSAGE" for="tbMedicationDosageForm" Class="col-sm-3 control-label">
                <span class="field-name"><%=whatDosageForm%></span>
            </Label>
            <div class="col-sm-9">
                <textarea id="tbMedicationDosageForm" name="tbMedicationDosageForm" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
    </details>
<!--Warnings and precautions-->
<details class="margin-top-medium">
        <summary id="SUM_WARNINGS" class="well well-sm"><%=sumWarnings%></summary>
        <div class="form-group row"> 
                  <label for="tbSeriousWarningsPrecautions" class="col-sm-3 control-label">
                     <span class="field-name"><%=seriousWarnings%></span>
                     <span class="label label-info" title="<%=warningsInfo%>"><%=information%></span>
                  </label>  
         
                  <div class="col-sm-7">                                          
                      <textarea id="tbSeriousWarningsPrecautions" name="tbSeriousWarningsPrecautions" class="textarea form-control" ></textarea>  
                  </div>
                  <div class="col-sm-2 text-right"> 
                      <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddSeriousWarningsPrecautions()" id="btnAddSeriousWarningsPrecautions" />
                  </div>                                                         
        </div>       
        <div id="dvExtraSeriousWarningsPrecautions">
        </div>
    </details>
<!--Interactions with this medication-->
<details class="margin-top-medium">
        <summary id="SUM_INTERACTIONS" class="well well-sm"><%=sumInteractions%></summary>
        <div class="form-group row">
            <label for="tbInteractionWithMed" class="col-sm-3 control-label">
                     <span class="field-name"><%=interactions%></span>
                     <span class="label label-info" title="<%=interactionsInfo%>"><%=information%></span>
                     
            </label>  

            <div class="col-sm-9">
                <textarea id="tbInteractionWithMed" name="tbInteractionWithMed" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
    </details>
<!--Proper use of this medication-->
 <details class="margin-top-medium">
        <summary id="SUM_PROPER_USE" class="well well-sm"><%=sumProperUse%></summary>        
        <div class="form-group row">
                <label ID="lblProperUse" for="tbProperUseMed" Class="col-sm-3 control-label">
                     <span class="field-name"><%=properUse%></span>
                </label> 
                <div class="col-sm-9">                    
                    <textarea id="tbProperUseMed" name="tbProperUseMed" runat="server" class="textarea form-control"></textarea>
                </div>         
        </div>
        <div class="form-group row">
                <label id="lblUsualDose" for="tbUsualDose" Class="col-sm-3 control-label">
                    <span class="field-name"><%=usualDose%></span>
                </label>            
                <div class="col-sm-9">                    
                    <textarea id="tbUsualDose" name="tbUsualDose" runat="server" class="textarea form-control"></textarea>
                </div>            
        </div>
        <div class="form-group row">              
                    <label for="tbOverdose" class="col-sm-3 control-label">
                         <span class="field-name"><%=overdose%></span>
                         <span class="label label-info" title="<%=overdoseInfo%>"><%=information%></span>
                    </label>  
                    <div class="col-sm-9">                               
                        <textarea id="tbOverdose" name="tbOverdose" runat="server" class="textarea form-control"></textarea>
                    </div>
         </div>
        <div class="form-group row">
            <Label id="lblMissedDose" for="tbMissedDose" Class="col-sm-3 control-label">
                <span class="field-name"><%=missedDose%></span>
            </Label>
            <div class="col-sm-9">
                <textarea id="tbMissedDose" name="tbMissedDose" runat="server" class="textarea form-control"></textarea>
            </div>
        </div> 
       <div class="form-group">  
                    <span class="field-name"><strong>Proper use documentation</strong></span>           
        </div>
        <div class="form-group row">
                <div class="col-sm-11">                    
                    <textarea id="properUseTextarea" name="properUseTextarea" class='mceEditor'>Please create documentation</textarea>
                </div>             
                <div class="col-sm-1">        
                     <input class="btn btn-default btn-xs" type="button" value="<%=addButton %>" onclick="AddProperUseTextarea()" id="btnProperUseTextarea" />           
                </div>            
        </div>
        <div id="divExtraProperUseTextarea">
        </div>     
</details>
<!--Side effects and what to do about them-->
<details class="margin-top-medium">
        <summary id="SUM_SIDE_EFFECTS" class="well well-sm"><%=sumSideEffects%></summary>
        <div class="form-group row ">
            <label for="tbSideEffects" class="control-label col-sm-3" >
                <span class="field-name"><%=sideEffects%></span>
            </label>     
            <div class="col-sm-9">                  
                    <textarea id="tbSideEffects" name="tbSideEffects" runat="server" class="textarea form-control"></textarea>
            </div>
         </div>
        <!--SideEffects Table -->              
        <section>
            <div class="wb-eqht row margin-top-medium">
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm"><p><%=frequency%></p></div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm"><p><%=symptom%></p></div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocIfSever" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbTalkwithDocAllCases" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
                <div class="hght-inhrt col-xs-2 brdr-tp brdr-rght brdr-lft brdr-bttm">
                    <asp:TextBox ID="tbStoptakingdrug" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100%"></asp:TextBox>
                </div>
            </div>
        </section>

        <section>
            <div class="wb-eqht row">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p><%=common%></p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddCommonSymptomsTextBox()" id="btnAddExtrCommonSymptoms" />
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
                    <input class="btn btn-default btn-xs" type="button" value="<%=removeButton %>" onclick="RemoveCommon(0)" id="btnRemoveCommon" />
                </div>
            </div>
            <div id="dvExtraCommonSymptoms" >
            </div>
        </section>
        <section>
            <div class="wb-eqht row">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p><%=uncommon%></p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddUncommonSymptomsTextBox()" id="btnAddExtrUncommonSymptoms" />
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
                    <input class="btn btn-default btn-xs" type="button" value="<%=removeButton %>" onclick="RemoveUncommon(0)" id="btnRemoveUncommon" />
                </div>
            </div>
            <div id="dvExtraUncommonSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
                <div class="col-xs-2 brdr-lft brdr-bttm"><p><%=rare%></p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddRareSymptomsTextBox()" id="btnAddExtrRareSymptoms" />
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
                    <input class="btn btn-default btn-xs" type="button" value="<%=removeButton %>" onclick="RemoveRare(0)" id="btnRemoveRare" />
                </div>
            </div>
            <div id="dvExtraRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
               <div class="col-xs-2 brdr-lft brdr-bttm"><p><%=veryRare%></p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddVeryRareSymptomsTextBox()" id="btnAddExtrVeryRareSymptoms" />
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
                    <input class="btn btn-default btn-xs" type="button" value="<%=removeButton %>" onclick="RemoveVeryRare(0)" id="btnRemoveVeryRare" />
                </div>
            </div>
            <div id="dvExtraVeryRareSymptoms"></div>
        </section>

        <section>
            <div class="row wb-eqht">
               <div class="col-xs-2 brdr-lft brdr-bttm"><p><%=unknown%></p></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-bttm"></div>
                <div class="col-xs-2 brdr-rght brdr-bttm"></div>
                <div class="col-xs-2">
                    <input class="btn btn-default btn-xs" type="button" value="<%=addButton%>" onclick="AddUnknownSymptomsTextBox()" id="btnAddExtrUnkownSymptoms" />
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
                    <input class="btn btn-default btn-xs" type="button" value="<%=removeButton %>" onclick="RemoveUnknown(0)" id="btnRemoveUnknown" />
                </div>
            </div>
            <div id="dvExtraUnknownSymptoms"></div>
        </section>
        <!--End of SideEffects -->
     <div class="clearfix"></div>     
     <div class="form-group margin-bottom-none">
            <p>* <%=sideEffectContact%></p>          
         </div>     
         <div class="form-group row ">
            <label for="tbSideEffectsWhatToDo" class="control-label col-sm-3" >
                <span class="field-name"><%=whatToDo%></span>
            </label>
            <div class="col-sm-9">                  
                  <textarea id="tbSideEffectsWhatToDo" name="tbSideEffectsWhatToDo" runat="server" class="textarea"></textarea>
            </div>
         </div>
     
 </details>  
<!--How to store it-->
 <details class="margin-top-medium">
        <summary id="SUM_HOW_TO_STORE-IT" class="well well-sm"><%=sumHowStore%></summary>
        <div class="form-group row">
            <label for="tbSideEffectsWhatToDo" class="control-label col-sm-3" >
                <span class="field-name"><%=sumHowStore%></span>
            </label>      
            <div class="col-sm-9">
                <textarea id="tbHowToStore" name="tbHowToStore" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
</details>
<!--Reporting supected side effects-->
<details class="margin-top-medium">
        <summary id="SUM_REPORTING" class="well well-sm"><%=sumReporting%></summary>
        <div class="form-group row">
            <label for="tbSideEffectsWhatToDo" class="control-label col-sm-3" >
                <span class="field-name"><%=sumReporting%></span>
            </label>   
            <div class="col-sm-9">                
                    <textarea id="tbReportingSuspectedSE" name="tbReportingSuspectedSE" runat="server" class="textarea form-control"></textarea>
            </div>
        </div>
</details>
<!--More information-->
<details class="margin-top-medium">
    <summary id="SUM_MORE_INFORMATION" class="well well-sm"><%=sumMoreInfo%></summary>
    <div class="form-group row">
            <Label ID="lblMoreInfo" for="tbMoreInformation" Class="col-sm-3 control-label">
                <span class="field-name"><%=sumMoreInfo%></span>
            </Label>           
            <div class="col-sm-9">                
                <textarea id="tbMoreInformation" name="tbMoreInformation" runat="server" class="textarea form-control"></textarea>
            </div>        
    </div>

    <div class="form-group row">   
             <Label ID="lblLastRevised" for="tbLastrRevised" Class="col-sm-3 control-label">
                <span class="field-name"><%=lastModified%></span>     
                <span class="datepicker-format"> (<abbr title="Four digits year, dash, two digits month, dash, two digits day">YYYY-MM-DD</abbr>)</span> 
            </Label> 
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
