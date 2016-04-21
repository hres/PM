using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.IO;
using System.Xml;
using System.Text;
using System.Collections;
using System.IO.Compression;
using System.Threading;
using System.Globalization;
using System.Xml.Linq;
using System.Web.UI;
using Product_Monograph.helpers;

namespace Product_Monograph
{
    public partial class PartThree : BasePage
    {
        string strscript = "";

        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }

            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.partThree;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.partThree;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                try
                {
                    LoadFromXML();
                    if (!string.IsNullOrEmpty(SessionHelper.Current.brandName))
                    {
                        this.brandName.Text = SessionHelper.Current.brandName;
                    }
                    if (!string.IsNullOrEmpty(SessionHelper.Current.properName))
                    {
                        this.properName.Text = SessionHelper.Current.properName;
                    }
                }
                catch
                {
                  
                }
            }
        }


        private void LoadFromXML()
        {
            XmlDocument xmldoc = SessionHelper.Current.draftForm;
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);

            XmlNodeList WarningPrecausion = xmldoc.GetElementsByTagName("WarningPrecausion");

            #region WarningPrecausion
            var rows = from row in doc.Root.Elements("WarningPrecausion").Descendants("row")
                       select new
                       {
                           columns = from column in row.Elements("column")
                                     select (string)column
                       };

            int rowcounter = 0;
            foreach (var row in rows)
            {
                string[] colarray = "tbSeriousWarningsPrecautions".Split(';');
                int colcounter = 0;
                if (rowcounter == 0)
                {
                    foreach (string column in row.columns)
                    {
                        strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                        colcounter++;
                    }
                }
                else
                {
                    strscript += "AddSeriousWarningsPrecautions();";
                    foreach (string column in row.columns)
                    {
                        strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                        colcounter++;
                    }
                }

                rowcounter++;
            }
            #endregion
            XmlNodeList cse = xmldoc.GetElementsByTagName("CommonSideEffects");
            if (cse.Count > 0)
            {
                #region Common Side Effects
                var rowsC = from rowcont in doc.Root.Elements("CommonSideEffects").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    if (!ranC)
                    {
                        string[] colarray = "tbCommonFrequency;tbCommonSymptom;cbCommonSevere;cbCommonAllCases;cbCommonStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbCommonFrequency") || colarray[colcounter].Equals("tbCommonSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }

                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddCommonSymptomsTextBox();";

                        string[] colarray = "tbCommonFrequency;tbCommonSymptom;cbCommonSevere;cbCommonAllCases;cbCommonStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbCommonFrequency") || colarray[colcounter].Equals("tbCommonSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }

                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList use = xmldoc.GetElementsByTagName("UncommonSideEffects");
            if (use.Count > 0)
            {
                #region Uncommon Side Effects
                var rowsC = from rowcont in doc.Root.Elements("UncommonSideEffects").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    if (!ranC)
                    {
                        string[] colarray = "tbUncommonFrequency;tbUncommonSymptom;cbUncommonSevere;cbUncommonAllCases;cbUncommonStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbUncommonFrequency") || colarray[colcounter].Equals("tbUncommonSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddUncommonSymptomsTextBox();";

                        string[] colarray = "tbUncommonFrequency;tbUncommonSymptom;cbUncommonSevere;cbUncommonAllCases;cbUncommonStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbUncommonFrequency") || colarray[colcounter].Equals("tbUncommonSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList rse = xmldoc.GetElementsByTagName("RareSideEffects");
            if (rse.Count > 0)
            {
                #region Rare Side Effects
                var rowsC = from rowcont in doc.Root.Elements("RareSideEffects").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    if (!ranC)
                    {
                        string[] colarray = "tbRareFrequency;tbRareSymptom;cbRareSevere;cbRareAllCases;cbRareStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbRareFrequency") || colarray[colcounter].Equals("tbRareSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddRareSymptomsTextBox();";

                        string[] colarray = "tbRareFrequency;tbRareSymptom;cbRareSevere;cbRareAllCases;cbRareStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbRareFrequency") || colarray[colcounter].Equals("tbRareSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList vse = xmldoc.GetElementsByTagName("VeryRareSideEffects");
            if (vse.Count > 0)
            {
                #region VeryRare Side Effects
                var rowsC = from rowcont in doc.Root.Elements("VeryRareSideEffects").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    if (!ranC)
                    {
                        string[] colarray = "tbVeryRareFrequency;tbVeryRareSymptom;cbVeryRareSevere;cbVeryRareAllCases;cbVeryRareStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbVeryRareFrequency") || colarray[colcounter].Equals("tbVeryRareSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddVeryRareSymptomsTextBox();";

                        string[] colarray = "tbVeryRareFrequency;tbVeryRareSymptom;cbVeryRareSevere;cbVeryRareAllCases;cbVeryRareStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbVeryRareFrequency") || colarray[colcounter].Equals("tbVeryRareSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList unkse = xmldoc.GetElementsByTagName("UnknownSideEffects");
            if (unkse.Count > 0)
            {
                #region Unknown Side Effects
                var rowsC = from rowcont in doc.Root.Elements("UnknownSideEffects").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    if (!ranC)
                    {
                        string[] colarray = "tbUnknownFrequency;tbUnknownSymptom;cbUnknownSevere;cbUnknownAllCases;cbUnknownStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbUnknownFrequency") || colarray[colcounter].Equals("tbUnknownSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            }

                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddUnknownSymptomsTextBox();";

                        string[] colarray = "tbUnknownFrequency;tbUnknownSymptom;cbUnknownSevere;cbUnknownAllCases;cbUnknownStoptaking".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            if (colarray[colcounter].Equals("tbUnknownFrequency") || colarray[colcounter].Equals("tbUnknownSymptom"))
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            }
                            else
                            {
                                if (columnC == "on")
                                    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";

                            }
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }


            //followings are elements under root node
            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              MedicationFor = (string)item.Element("MedicationFor"),
                              MedicationDoes = (string)item.Element("MedicationDoes"),
                              MedicationNotUsed = (string)item.Element("MedicationNotUsed"),
                              MedicationIngredient = (string)item.Element("MedicationIngredient"),
                              MedicationNonmed = (string)item.Element("MedicationNonmed"),
                              MedicationDosageForm = (string)item.Element("MedicationDosageForm"),

                              InteractionWithMed = (string)item.Element("InteractionWithMed"),

                              ProperUseMed = (string)item.Element("ProperUseMed"),
                              UsualDose = (string)item.Element("UsualDose"),
                              Overdose = (string)item.Element("Overdose"),
                              MissedDose = (string)item.Element("MissedDose"),
                              SideEffects = (string)item.Element("SideEffects"),
                              SideEffectsWhatToDo = (string)item.Element("SideEffectsWhatToDo"),
                              HowToStore = (string)item.Element("HowToStore"),
                              ReportingSuspectedSE = (string)item.Element("ReportingSuspectedSE"),
                              MoreInformation = (string)item.Element("MoreInformation"),
                              LastrRevised = (string)item.Element("LastrRevised"),
                              Sponsorname = (string)item.Element("Sponsorname"),
                              UsualDoseImageName = (string)item.Element("UsualDoseImageName"),
                              UsualDoseImageData = (string)item.Element("UsualDoseImageData"),
                              UsualDoseSymbol = (string)item.Element("UsualDoseSymbol"),
                              MedicationUsualDose = (string)item.Element("MedicationUsualDose"),
                              MedicationUsualDoseImagename = (string)item.Element("MedicationUsualDoseImagename"),
                              MedicationUsualDoseImagedata = (string)item.Element("MedicationUsualDoseImagedata"),
                              MedicationOverdose = (string)item.Element("MedicationOverdose"),
                              MedicationOverdoseImagename = (string)item.Element("MedicationOverdoseImagename"),
                              MedicationOverdoseImagedata = (string)item.Element("MedicationOverdoseImagedata"),
                              MedicationMissedDose = (string)item.Element("MedicationMissedDose"),
                              MedicationMissedDoseImagename = (string)item.Element("MedicationMissedDoseImagename"),
                              MedicationMissedDoseImagedata = (string)item.Element("MedicationMissedDoseImagedata")
                          };

            foreach (var xmldataitem in xmldata)
            {
                if (tbMedicationForText.Value != xmldataitem.MedicationFor)
                    tbMedicationForText.Value = xmldataitem.MedicationFor;
                if (tbMedicationDoes.Value != xmldataitem.MedicationDoes)
                    tbMedicationDoes.Value = xmldataitem.MedicationDoes;
                if (tbMedicationNotUsed.Value != xmldataitem.MedicationNotUsed)
                    tbMedicationNotUsed.Value = xmldataitem.MedicationNotUsed;
                if (tbMedicationIngredient.Value != xmldataitem.MedicationIngredient)
                    tbMedicationIngredient.Value = xmldataitem.MedicationIngredient;
                if (tbMedicationNonmed.Value != xmldataitem.MedicationNonmed)
                    tbMedicationNonmed.Value = xmldataitem.MedicationNonmed;
                if (tbMedicationDosageForm.Value != xmldataitem.MedicationDosageForm)
                    tbMedicationDosageForm.Value = xmldataitem.MedicationDosageForm;
                if (tbInteractionWithMed.Value != xmldataitem.InteractionWithMed)
                    tbInteractionWithMed.Value = xmldataitem.InteractionWithMed;

                if (tbProperUseMed.Value != xmldataitem.ProperUseMed)
                    tbProperUseMed.Value = xmldataitem.ProperUseMed;
                if (tbUsualDose.Value != xmldataitem.UsualDose)
                    tbUsualDose.Value = xmldataitem.UsualDose;
                if (tbOverdose.Value != xmldataitem.Overdose)
                    tbOverdose.Value = xmldataitem.Overdose;
                if (tbMissedDose.Value != xmldataitem.MissedDose)
                    tbMissedDose.Value = xmldataitem.MissedDose;

                if(tbSideEffects.Value != xmldataitem.SideEffects)
                    tbSideEffects.Value = xmldataitem.SideEffects;
                if (tbSideEffectsWhatToDo.Value != xmldataitem.SideEffectsWhatToDo)
                    tbSideEffectsWhatToDo.Value = xmldataitem.SideEffectsWhatToDo;

                if (tbHowToStore.Value != xmldataitem.HowToStore)
                    tbHowToStore.Value = xmldataitem.HowToStore;
                if (tbReportingSuspectedSE.Value != xmldataitem.ReportingSuspectedSE)
                    tbReportingSuspectedSE.Value = xmldataitem.ReportingSuspectedSE;
                if (tbMoreInformation.Value != xmldataitem.MoreInformation)
                    tbMoreInformation.Value = xmldataitem.MoreInformation;
                if (tbLastrRevised.Text != xmldataitem.LastrRevised)
                    tbLastrRevised.Text = xmldataitem.LastrRevised;
                if (xmldataitem.Overdose == null)
                {
                    tbOverdose.Value = "In case of drug overdose, contact a health care practitioner, hospital emergency department or regional Poison Control Centre immediately, even if there are no symptoms.";
                }
                else
                {
                    tbOverdose.Value = xmldataitem.Overdose;
                }
                

                if (xmldataitem.ReportingSuspectedSE == null)
                {
                    tbReportingSuspectedSE.Value = "<p>You can report any suspected adverse reactions associated with the use of health products to the Canada Vigilance Program by one of the following 3 ways:</p>" +
                                                    "<p>Report online at www.healthcanada.gc.ca/medeffect</p>" +
                                                    "<p>Call toll-free at 1-866-234-2345</p>" +
                                                    "<p>Complete a Canada Vigilance Reporting Form and:</p>" +
                                                    "<p>&nbsp;&nbsp;&nbsp;Fax toll-free to 1-866-678-6789, or</p>" +
                                                    "<p>&nbsp;&nbsp;&nbsp;Mail to: 	Canada Vigilance Program</p>" +
                                                    "<p>Health Canada</p>" +
                                                    "<p>Postal Locator 0701D</p>" +
                                                    "<p>Ottawa, Ontario K1A 0K9</p>" +
                                                    "<p>Postage paid labels, Canada Vigilance Reporting Form and the adverse reaction reporting guidelines are available on the MedEffect™ Canada Web site at www.healthcanada.gc.ca/medeffect.</p>" +
                                                    "<p>NOTE: Should you require information related to the management of side effects, contact your health professional. The Canada Vigilance Program does not provide medical advice.</p>";
                }
                else
                {
                    tbReportingSuspectedSE.Value = xmldataitem.ReportingSuspectedSE;
                }

                if (xmldataitem.MoreInformation == null)
                {
                    tbMoreInformation.Value = "<p>This document plus the full product monograph, prepared for thealth professionals can be found at: (website) or by contacting the sponsor,</p>" +
                                          "<p>" + xmldataitem.Sponsorname + " at: 1-800-XXX-XXXX</p>";
                }
                else
                {
                    tbMoreInformation.Value = xmldataitem.MoreInformation;
                }
                strscript += "$('#fuimage0').attr('src', " + "'" + xmldataitem.MedicationUsualDoseImagedata + "');";
                strscript += "$('#tbfuimagename0').val(\"" + xmldataitem.MedicationUsualDoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour0').val(\"" + xmldataitem.MedicationMissedDoseImagedata + "\");";
                strscript += "$('#fuimage1').attr('src', " + "'" + xmldataitem.MedicationOverdoseImagedata + "');";
                strscript += "$('#tbfuimagename1').val(\"" + xmldataitem.MedicationOverdoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour1').val(\"" + xmldataitem.MedicationOverdoseImagedata + "\");";
                strscript += "$('#fuimage2').attr('src', " + "'" + xmldataitem.MedicationMissedDoseImagedata + "');";
                strscript += "$('#tbfuimagename2').val(\"" + xmldataitem.MedicationMissedDoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour2').val(\"" + xmldataitem.MedicationMissedDoseImagedata + "\");";
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                XmlDocument doc = SaveInMemory();
                if (doc == null)
                {
                    return;
                }
                else
                {
                    if (!string.IsNullOrWhiteSpace(SessionHelper.Current.brandName))
                    {
                        var common = new helpers.Common(SessionHelper.Current.brandName);
                        common.SaveXmlFile(doc);
                        SessionHelper.Current.draftForm = doc;
                    }
                }
            }
            catch (Exception error)
            {
            }
        }

        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = SessionHelper.Current.draftForm;
            XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");

            #region AboutMedication
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationFor", "MedicationFor", tbMedicationForText.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationDoes", "MedicationDoes", tbMedicationDoes.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationNotUsed", " MedicationNotUsed", tbMedicationNotUsed.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationIngredient", "MedicationIngredient", tbMedicationIngredient.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationNonmed", "MedicationNonmed", tbMedicationNonmed.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationDosageForm", "MedicationDosageForm", tbMedicationDosageForm.Value, true);
            #endregion

            #region WarningPrecausion
            try
            {
                XmlNodeList Warnings = doc.GetElementsByTagName("WarningPrecausion");
                var tbSeriousWarningsPrecautions = new ArrayList();
                
                if (HttpContext.Current.Request.Form.GetValues("tbSeriousWarningsPrecautions") != null )
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbSeriousWarningsPrecautions"))
                    {
                        tbSeriousWarningsPrecautions.Add(item);                    }
                    
                }

                if (Warnings.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("WarningPrecausion");
                    rootnode.AppendChild(xnode);
                    for (int ar = 0; ar < tbSeriousWarningsPrecautions.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = tbSeriousWarningsPrecautions[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                        
                    }
                }
                else
                {
                    Warnings[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("WarningPrecausion");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < tbSeriousWarningsPrecautions.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = tbSeriousWarningsPrecautions[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                       
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion 

            #region MedicationInteractions
            helpers.Processes.ValidateAndSave(doc, rootnode, "InteractionWithMed", "InteractionWithMed", tbInteractionWithMed.Value, true);
            #endregion

            #region ProperUseMedication
            helpers.Processes.ValidateAndSave(doc, rootnode, "ProperUseMed", "ProperUseMed", tbProperUseMed.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "UsualDose", "UsualDose", tbUsualDose.Value, true);
           
            helpers.Processes.ValidateAndSave(doc, rootnode, "Overdose", "Overdose", tbOverdose.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MissedDose", "MissedDose", tbMissedDose.Value, true);
            #endregion

            #region  SideEffects
            helpers.Processes.ValidateAndSave(doc, rootnode, "SideEffects", "SideEffects", tbSideEffects.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SideEffectsWhatToDo", "SideEffectsWhatToDo", tbSideEffectsWhatToDo.Value, true);

            #endregion

            #region  HowToStore
            helpers.Processes.ValidateAndSave(doc, rootnode, "HowToStore", "HowToStore", tbHowToStore.Value, true);
            #endregion
            
            #region  Reporting
            helpers.Processes.ValidateAndSave(doc, rootnode, "ReportingSuspectedSE", "ReportingSuspectedSE", tbReportingSuspectedSE.Value, true);
            #endregion

            #region MoreInfo
            helpers.Processes.ValidateAndSave(doc, rootnode, "MoreInformation", "MoreInformation", tbMoreInformation.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "LastrRevised", "LastrRevised", tbLastrRevised.Text, true);
            #endregion

            ArrayList namearrayUsualDose = new ArrayList();
            ArrayList imagearrayUsualDose = new ArrayList();
            if (HttpContext.Current.Request.Form.GetValues("tbfuimagename0") != null &&
                HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour0") != null)
            {
                foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbfuimagename0"))
                {
                    namearrayUsualDose.Add(routeitem);
                }
                foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour0"))
                {
                    imagearrayUsualDose.Add(dosageitem);
                }
            }
            ArrayList namearrayOverdose = new ArrayList();
            ArrayList imagearrayOverdose = new ArrayList();
            if (HttpContext.Current.Request.Form.GetValues("tbfuimagename1") != null &&
                HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour1") != null)
            {
                foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbfuimagename1"))
                {
                    namearrayOverdose.Add(routeitem);
                }
                foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour1"))
                {
                    imagearrayOverdose.Add(dosageitem);
                }
            }
            ArrayList namearrayMissedDose = new ArrayList();
            ArrayList imagearrayMissedDose = new ArrayList();
            if (HttpContext.Current.Request.Form.GetValues("tbfuimagename2") != null &&
                HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour2") != null)
            {
                foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbfuimagename2"))
                {
                    namearrayMissedDose.Add(routeitem);
                }
                foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour2"))
                {
                    imagearrayMissedDose.Add(dosageitem);
                }
            }
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationUsualDoseImagename", "", namearrayUsualDose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationUsualDoseImagedata", "", imagearrayUsualDose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationOverdoseImagename", "", namearrayOverdose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationOverdoseImagedata", "", imagearrayOverdose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationMissedDoseImagename", "", namearrayMissedDose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationMissedDoseImagedata", "", imagearrayMissedDose[0].ToString(), false);


            #region Common SideEffects
            try
            {
                if (hdCommonSymptoms.Value == "")
                    hdCommonSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("CommonSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("CommonSideEffects");
                    rootnode.AppendChild(xnode);

                    for (int r = 0; r <= int.Parse(hdCommonSymptoms.Value); r++)
                    {
                        try
                        {
                            //if this bombs, this row does not exist. therefore, don't need to check cb's
                            string col0 = Request.Form["tbCommonFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbCommonSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbCommonSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbCommonSevere
                                string col3 = Request.Form["cbCommonAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbCommonSevere
                                string col4 = Request.Form["cbCommonStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("CommonSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    for (int r = 0; r <= int.Parse(hdCommonSymptoms.Value); r++)
                    {
                        try
                        {
                            //if this bombs, this row does not exist. therefore, don't need to check cb's
                            string col0 = Request.Form["tbCommonFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbCommonSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbCommonSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbCommonSevere
                                string col3 = Request.Form["cbCommonAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbCommonSevere
                                string col4 = Request.Form["cbCommonStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion

            #region Uncommon SideEffects
            try
            {
                if (hdUncommonSymptoms.Value == "")
                    hdUncommonSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("UncommonSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("UncommonSideEffects");
                    rootnode.AppendChild(xnode);

                    for (int r = 0; r <= int.Parse(hdUncommonSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbUncommonFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbUncommonSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbUncommonSevere
                                string col3 = Request.Form["cbUncommonAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbUncommonSevere
                                string col4 = Request.Form["cbUncommonStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("UncommonSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    for (int r = 0; r <= int.Parse(hdUncommonSymptoms.Value); r++)
                    {
                        try
                        {
                            //if this bombs, this row does not exist. therefore, don't need to check cb's
                            string col0 = Request.Form["tbUncommonFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbUncommonSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbUncommonSevere
                                string col3 = Request.Form["cbUncommonAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbUncommonSevere
                                string col4 = Request.Form["cbUncommonStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion

            #region Rare SideEffects
            try
            {
                if (hdRareSymptoms.Value == "")
                    hdRareSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("RareSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("RareSideEffects");
                    rootnode.AppendChild(xnode);

                    for (int r = 0; r <= int.Parse(hdRareSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbRareFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);
                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbRareSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbRareSevere
                                string col3 = Request.Form["cbRareAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbRareSevere
                                string col4 = Request.Form["cbRareStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("RareSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    for (int r = 0; r <= int.Parse(hdRareSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbRareFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            ////if this bombs, this row does not exist. therefore, don't need to check cb's
                            //string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                            //XmlNode subnode = doc.CreateElement("row");
                            //xnode[0].AppendChild(subnode);

                            //XmlNode subsubnode = doc.CreateElement("column");
                            //subsubnode.AppendChild(doc.CreateTextNode(col1));
                            //subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbRareSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbRareSevere
                                string col3 = Request.Form["cbRareAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbRareSevere
                                string col4 = Request.Form["cbRareStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion

            #region VeryRare SideEffects
            try
            {
                if (hdVeryRareSymptoms.Value == "")
                    hdVeryRareSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("VeryRareSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("VeryRareSideEffects");
                    rootnode.AppendChild(xnode);

                    for (int r = 0; r <= int.Parse(hdVeryRareSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbVeryRareFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbVeryRareSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbVeryRareSevere
                                string col3 = Request.Form["cbVeryRareAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbVeryRareSevere
                                string col4 = Request.Form["cbVeryRareStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("VeryRareSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    for (int r = 0; r <= int.Parse(hdVeryRareSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbVeryRareFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            ////if this bombs, this row does not exist. therefore, don't need to check cb's
                            //string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                            //XmlNode subnode = doc.CreateElement("row");
                            //xnode[0].AppendChild(subnode);

                            //XmlNode subsubnode = doc.CreateElement("column");
                            //subsubnode.AppendChild(doc.CreateTextNode(col1));
                            //subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbVeryRareSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbVeryRareSevere
                                string col3 = Request.Form["cbVeryRareAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbVeryRareSevere
                                string col4 = Request.Form["cbVeryRareStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion

            #region Unknown SideEffects
            try
            {
                if (hdUnknownSymptoms.Value == "")
                    hdUnknownSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("UnknownSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("UnknownSideEffects");
                    rootnode.AppendChild(xnode);

                    for (int r = 0; r <= int.Parse(hdUnknownSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbUnknownFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);

                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbUnknownSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbUnknownSevere
                                string col3 = Request.Form["cbUnknownAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbUnknownSevere
                                string col4 = Request.Form["cbUnknownStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("UnknownSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    for (int r = 0; r <= int.Parse(hdUnknownSymptoms.Value); r++)
                    {
                        try
                        {
                            string col0 = Request.Form["tbUnknownFrequency" + r.ToString()].ToString();
                            string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col0));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("column");
                            subsubnode.AppendChild(doc.CreateTextNode(col1));
                            subnode.AppendChild(subsubnode);
                            try
                            {
                                //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                                string col2 = Request.Form["cbUnknownSevere" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col2));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }

                            try
                            {
                                //same comment as cbUnknownSevere
                                string col3 = Request.Form["cbUnknownAllCases" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col3));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                            try
                            {
                                //same comment as cbUnknownSevere
                                string col4 = Request.Form["cbUnknownStoptaking" + r.ToString()].ToString();
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode(col4));
                                subnode.AppendChild(subsubnode);
                            }
                            catch
                            {
                                subsubnode = doc.CreateElement("column");
                                subsubnode.AppendChild(doc.CreateTextNode("false"));
                                subnode.AppendChild(subsubnode);
                            }
                        }
                        catch
                        { }
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion

            SessionHelper.Current.draftForm = doc;
            return doc;
        }
    }
}

   