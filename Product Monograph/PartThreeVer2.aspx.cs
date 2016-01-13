using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Xml.Serialization;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using System.Text;
using System.Net;
using System.Xml.Linq;
using System.Configuration;
using System.Collections;
using System.IO.Compression;

namespace Product_Monograph
{
    public partial class PartThreeVer2 : System.Web.UI.Page
    {
        string strscript = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (!IsPostBack)
            {
                try
                {
                    LoadFromXML();
                }
                catch (Exception err)
                {
                    lblError.Text = err.ToString();// "Please load a new template or a previously saved draft.";
                }
            }
        }

        private void SaveProcess()
        {
            XmlDocument doc = SaveInMemory();

            #region zip
            byte[] bytes = Encoding.Default.GetBytes(doc.OuterXml);

            using (var compressedFileStream = new MemoryStream())
            {
                using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Update, true))
                {
                    if (doc != null)
                    {
                        var zipEntry = zipArchive.CreateEntry("ProductMonograph.xml");
                        using (var originalFileStream = new MemoryStream(bytes))
                        {
                            using (var zipEntryStream = zipEntry.Open())
                            {
                                originalFileStream.CopyTo(zipEntryStream);
                            }
                        }
                    }
                }

                var buffer = compressedFileStream.ToArray();
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                if (buffer.Length > 0)
                {
                    Response.ContentType = "application/zip";
                    Response.BinaryWrite(buffer);
                    var fileName = "ProductMonograph.zip";
                    Response.AddHeader("content-disposition", string.Format(@"attachment;filename=""{0}""", fileName));
                    Response.Flush();
                    Response.End();
                }
            }
            #endregion

            //StringWriter sw = new StringWriter();
            //XmlTextWriter tx = new XmlTextWriter(sw);
            //doc.WriteTo(tx);

            //String FileName = "productionmonograph.xml";
            //Response.ClearHeaders();
            //Response.ClearContent();
            //Response.Buffer = true;
            //Response.AddHeader("content-disposition", "attachment; filename=" + FileName);
            //Response.Write(sw.ToString());
            //Response.End();
        }

        private void LoadFromXML()
        {
            XmlDocument xmldoc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);

            //populate labels
            XmlNodeList bpd = xmldoc.GetElementsByTagName("BrandProperDosage");
            if (bpd.Count > 0)
            {
                #region BrandProperDosage
                var rows = from row in doc.Root.Elements("BrandProperDosage").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                foreach (var row in rows)
                {
                    //string[] colarray = "tbBrandName;tbProperName;tbDosageAndStrength".Split(';');
                    //string[] colarray = "tbBrandName;tbProperName;tbDosage;tbStrength;tbUnitofMeasure".Split(';');
                    string[] colarray = "tbBrandName;tbProperName;tbDosage;tbStrengthValue;tbStrengthUnit;tbStrengthperDosageValue;tbStrengthperDosageUnit".Split(';');
                    int colcounter = 0;
                    foreach (string column in row.columns)
                    {
                        if (colarray[colcounter].Equals("tbBrandName"))
                        {
                            lblBrandNameProprietary.Text = helpers.Processes.CleanString(column);
                            //lblBrandNameTbl.Text = helpers.Processes.CleanString(column);
                            //lblBrandNameWP.Text = helpers.Processes.CleanString(column);
                        }

                        if (colarray[colcounter].Equals("tbProperName"))
                        {
                            lblProperName.Text = helpers.Processes.CleanString(column);
                            //lblProperNameMI.Text = helpers.Processes.CleanString(column);
                        }

                        colcounter++;
                    }

                    break;
                }
                #endregion
            }

            XmlNodeList swp = xmldoc.GetElementsByTagName("MedicationIsUsedForItems");
            if (swp.Count > 0)
            {
                #region Medication Is Used For Items
                var rowsC = from rowcont in doc.Root.Elements("MedicationIsUsedForItems").Descendants("row")
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
                        string[] colarray = "tbMedicationForItems".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddMedicationForItemsTextBox();";

                        string[] colarray = "tbMedicationForItems".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList mswp = xmldoc.GetElementsByTagName("MedicationSeriousWarningsPrecautions");
            if (mswp.Count > 0)
            {
                #region Medication Serious Warnings Precautions
                var rowsC = from rowcont in doc.Root.Elements("MedicationSeriousWarningsPrecautions").Descendants("row")
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
                        string[] colarray = "tbSeriousWarningsPrecautions".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }

                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddSeriousWarningsPrecautionsTextBox();";

                        string[] colarray = "tbSeriousWarningsPrecautions".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

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

                            //if (colarray[colcounter].Equals("tbUncommonSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbUncommonSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbRareSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbRareSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbVeryRareSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbVeryRareSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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

                            //if (colarray[colcounter].Equals("tbUnknownSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

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
                            //if (colarray[colcounter].Equals("tbUnknownSymptom"))
                            //{
                            //    strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            //}
                            //else
                            //{
                            //    if (columnC == "on")
                            //        strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').attr(\"checked\",\"true\");";
                            //}

                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }
                #endregion
            }

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              MedicationIsUsedFor = (string)item.Element("MedicationIsUsedFor"),
                              MedicationDoes = (string)item.Element("MedicationDoes"),
                              MedicationNotUsed = (string)item.Element("MedicationNotUsed"),
                              MedicationIngredient = (string)item.Element("MedicationIngredient"),
                              MedicationNonmed = (string)item.Element("MedicationNonmed"),
                              MedicationDosageForm = (string)item.Element("MedicationDosageForm"),
                              MedicationInteractionWithMed = (string)item.Element("MedicationInteractionWithMed"),

                              ProperUseMed = (string)item.Element("ProperUseMed"),

                              MedicationUsualDose = (string)item.Element("MedicationUsualDose"),
                              MedicationUsualDoseImagename = (string)item.Element("MedicationUsualDoseImagename"),
                              MedicationUsualDoseImagedata = (string)item.Element("MedicationUsualDoseImagedata"),

                              MedicationOverdose = (string)item.Element("MedicationOverdose"),
                              MedicationOverdoseImagename = (string)item.Element("MedicationOverdoseImagename"),
                              MedicationOverdoseImagedata = (string)item.Element("MedicationOverdoseImagedata"),

                              MedicationMissedDose = (string)item.Element("MedicationMissedDose"),
                              MedicationMissedDoseImagename = (string)item.Element("MedicationMissedDoseImagename"),
                              MedicationMissedDoseImagedata = (string)item.Element("MedicationMissedDoseImagedata"),

                              MedicationSideEffects = (string)item.Element("MedicationSideEffects"),

                              TalkwithDocIfSever = (string)item.Element("TalkwithDocIfSever"),
                              TalkwithDocAllCases = (string)item.Element("TalkwithDocAllCases"),
                              Stoptakingdrug = (string)item.Element("Stoptakingdrug"),

                              SideEffectsWhatToDo = (string)item.Element("SideEffectsWhatToDo"),

                              MedicationHowToStore = (string)item.Element("MedicationHowToStore"),

                              ReportingSuspectedSE = (string)item.Element("ReportingSuspectedSE"),

                              MoreInformation = (string)item.Element("MoreInformation"),

                              MedicationLastrRevised = (string)item.Element("MedicationLastrRevised"),

                              Sponsorname = (string)item.Element("Sponsorname")
                          };

            foreach (var xmldataitem in xmldata)
            {
                //tbMedicationForText.Value = xmldataitem.MedicationIsUsedFor;
                //tbMedicationDoes.Value = xmldataitem.MedicationDoes;
                //tbMedicationNotUsed.Value = xmldataitem.MedicationNotUsed;
                //tbMedicationIngredient.Value = xmldataitem.MedicationIngredient;
                //tbMedicationNonmed.Value = xmldataitem.MedicationNonmed;
                //tbMedicationDosageForm.Value = xmldataitem.MedicationDosageForm;
                //tbInteractionWithMed.Value = xmldataitem.MedicationInteractionWithMed;

                //tbProperUseMed.Value = xmldataitem.ProperUseMed;

                //tbUsualDose.Value = xmldataitem.MedicationUsualDose;
                strscript += "$('#fuimage0').attr('src', " + "'" + xmldataitem.MedicationUsualDoseImagedata + "');";
                strscript += "$('#tbfuimagename0').val(\"" + xmldataitem.MedicationUsualDoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour0').val(\"" + xmldataitem.MedicationMissedDoseImagedata + "\");";

                if (xmldataitem.MedicationOverdose == null)
                {
                    //tbOverdose.Value = "In case of drug overdose, contact a health care practitioner, hospital emergency department or regional Poison Control Centre immediately, even if there are no symptoms.";
                }
                else
                {
                    //tbOverdose.Value = xmldataitem.MedicationOverdose;
                }
                strscript += "$('#fuimage1').attr('src', " + "'" + xmldataitem.MedicationOverdoseImagedata + "');";
                strscript += "$('#tbfuimagename1').val(\"" + xmldataitem.MedicationOverdoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour1').val(\"" + xmldataitem.MedicationOverdoseImagedata + "\");";

                //tbMissedDose.Value = xmldataitem.MedicationMissedDose;
                strscript += "$('#fuimage2').attr('src', " + "'" + xmldataitem.MedicationMissedDoseImagedata + "');";
                strscript += "$('#tbfuimagename2').val(\"" + xmldataitem.MedicationMissedDoseImagename + "\");";
                strscript += "$('#tbfuimagebasesixtyfour2').val(\"" + xmldataitem.MedicationMissedDoseImagedata + "\");";

                //tbSideEffects.Value = xmldataitem.MedicationSideEffects;

                if (xmldataitem.TalkwithDocIfSever == null)
                {
                    //tbTalkwithDocIfSever.Text = "Talk with your doctor only if sever";
                }
                else
                {
                    //tbTalkwithDocIfSever.Text = xmldataitem.TalkwithDocIfSever;
                }
                if (xmldataitem.TalkwithDocAllCases == null)
                {
                    //tbTalkwithDocAllCases.Text = "Talk with your doctor in all cases";
                }
                else
                {
                    //tbTalkwithDocAllCases.Text = xmldataitem.TalkwithDocAllCases;
                }
                if (xmldataitem.Stoptakingdrug == null)
                {
                    //tbStoptakingdrug.Text = "Stop taking drug";
                }
                else
                {
                    //tbStoptakingdrug.Text = xmldataitem.Stoptakingdrug;
                }

                //tbSideEffectsWhatToDo.Value = xmldataitem.SideEffectsWhatToDo;
                //tbHowToStore.Value = xmldataitem.MedicationHowToStore;
                //tbLastrRevised.Text = xmldataitem.MedicationLastrRevised;

                if (xmldataitem.ReportingSuspectedSE == null)
                {
                    //tbReportingSuspectedSE.Value = "<p>You can report any suspected adverse reactions associated with the use of health products to the Canada Vigilance Program by one of the following 3 ways:</p>" +
                                                    //"<p>Report online at www.healthcanada.gc.ca/medeffect</p>" +
                                                    //"<p>Call toll-free at 1-866-234-2345</p>" +
                                                    //"<p>Complete a Canada Vigilance Reporting Form and:</p>" +
                                                    //"<p>&nbsp;&nbsp;&nbsp;Fax toll-free to 1-866-678-6789, or</p>" +
                                                    //"<p>&nbsp;&nbsp;&nbsp;Mail to: 	Canada Vigilance Program</p>" +
                                                    //"<p>Health Canada</p>" +
                                                    //"<p>Postal Locator 0701D</p>" +
                                                    //"<p>Ottawa, Ontario K1A 0K9</p>" +
                                                    //"<p>Postage paid labels, Canada Vigilance Reporting Form and the adverse reaction reporting guidelines are available on the MedEffect™ Canada Web site at www.healthcanada.gc.ca/medeffect.</p>" +
                                                    //"<p>NOTE: Should you require information related to the management of side effects, contact your health professional. The Canada Vigilance Program does not provide medical advice.</p>";
                }
                else
                {
                    //tbReportingSuspectedSE.Value = xmldataitem.ReportingSuspectedSE;
                }

                if (xmldataitem.MoreInformation == null)
                {
                    //tbMoreInformation.Value = "<p>This document plus the full product monograph, prepared for thealth professionals can be found at: (website) or by contacting the sponsor,</p>" +
                                          //"<p>" + xmldataitem.Sponsorname + " at: 1-800-XXX-XXXX</p>";
                }
                else
                {
                    //tbMoreInformation.Value = xmldataitem.MoreInformation;
                }

            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveProcess();
        }

        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
            XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationIsUsedFor", "", tbMedicationForText.Value, false);

            #region MEDICATION IS USED FOR
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("MedicationIsUsedForItems");

                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbMedicationForItems") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbMedicationForItems"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (swp.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("MedicationIsUsedForItems");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    swp[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("MedicationIsUsedForItems");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationDoes", "", tbMedicationDoes.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationNotUsed", "", tbMedicationNotUsed.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationIngredient", "", tbMedicationIngredient.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationNonmed", "", tbMedicationNonmed.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationDosageForm", "", tbMedicationDosageForm.Value, false);

            #region MEDICATION Serious Warnings Precautions
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("MedicationSeriousWarningsPrecautions");

                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbSeriousWarningsPrecautions") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbSeriousWarningsPrecautions"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (swp.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("MedicationSeriousWarningsPrecautions");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    swp[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("MedicationSeriousWarningsPrecautions");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationInteractionWithMed", "", tbInteractionWithMed.Value, false);


            //helpers.Processes.ValidateAndSave(doc, rootnode, "ProperUseMed", "", tbProperUseMed.Value, false);

            #region UsualDose
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationUsualDose", "", tbUsualDose.Value, false);
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
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationUsualDoseImagename", "", namearrayUsualDose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationUsualDoseImagedata", "", imagearrayUsualDose[0].ToString(), false);
            #endregion

            #region MissedDose
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationOverdose", "", tbOverdose.Value, false);
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
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationOverdoseImagename", "", namearrayOverdose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationOverdoseImagedata", "", imagearrayOverdose[0].ToString(), false);
            #endregion

            #region MissedDose
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationMissedDose", "", tbMissedDose.Value, false);
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
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationMissedDoseImagename", "", namearrayMissedDose[0].ToString(), false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationMissedDoseImagedata", "", imagearrayMissedDose[0].ToString(), false);
            #endregion

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationSideEffects", "", tbSideEffects.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "TalkwithDocIfSever", "", tbTalkwithDocIfSever.Text, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "TalkwithDocAllCases", "", tbTalkwithDocAllCases.Text, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "Stoptakingdrug", "", tbStoptakingdrug.Text, false);

            #region Common SideEffects
            try
            {
                //if (hdCommonSymptoms.Value == "")
                //    hdCommonSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("CommonSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("CommonSideEffects");
                    rootnode.AppendChild(xnode);

                    //for (int r = 0; r <= int.Parse(hdCommonSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        //if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        string col0 = Request.Form["tbCommonFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbCommonSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode.AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbCommonSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbCommonSevere
                    //            string col3 = Request.Form["cbCommonAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbCommonSevere
                    //            string col4 = Request.Form["cbCommonStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("CommonSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    //for (int r = 0; r <= int.Parse(hdCommonSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        //if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        string col0 = Request.Form["tbCommonFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbCommonSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode[0].AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);


                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbCommonSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode[0].AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbCommonSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbCommonSevere
                    //            string col3 = Request.Form["cbCommonAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbCommonSevere
                    //            string col4 = Request.Form["cbCommonStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region Uncommon SideEffects
            try
            {
                //if (hdUncommonSymptoms.Value == "")
                //    hdUncommonSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("UncommonSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("UncommonSideEffects");
                    rootnode.AppendChild(xnode);

                    //for (int r = 0; r <= int.Parse(hdUncommonSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbUncommonFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode.AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);


                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode.AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);
                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbUncommonSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbUncommonSevere
                    //            string col3 = Request.Form["cbUncommonAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbUncommonSevere
                    //            string col4 = Request.Form["cbUncommonStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("UncommonSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    //for (int r = 0; r <= int.Parse(hdUncommonSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        //if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        string col0 = Request.Form["tbUncommonFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode[0].AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);


                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbUncommonSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode[0].AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbUncommonSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbUncommonSevere
                    //            string col3 = Request.Form["cbUncommonAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbUncommonSevere
                    //            string col4 = Request.Form["cbUncommonStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region Rare SideEffects
            try
            {
                //if (hdRareSymptoms.Value == "")
                //    hdRareSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("RareSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("RareSideEffects");
                    rootnode.AppendChild(xnode);

                    //for (int r = 0; r <= int.Parse(hdRareSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbRareFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode.AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);

                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode.AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);
                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbRareSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbRareSevere
                    //            string col3 = Request.Form["cbRareAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbRareSevere
                    //            string col4 = Request.Form["cbRareStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("RareSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    //for (int r = 0; r <= int.Parse(hdRareSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbRareFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode[0].AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);

                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbRareSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode[0].AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbRareSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbRareSevere
                    //            string col3 = Request.Form["cbRareAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbRareSevere
                    //            string col4 = Request.Form["cbRareStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region VeryRare SideEffects
            try
            {
                //if (hdVeryRareSymptoms.Value == "")
                //    hdVeryRareSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("VeryRareSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("VeryRareSideEffects");
                    rootnode.AppendChild(xnode);

                    //for (int r = 0; r <= int.Parse(hdVeryRareSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbVeryRareFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode.AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);


                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode.AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbVeryRareSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbVeryRareSevere
                    //            string col3 = Request.Form["cbVeryRareAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbVeryRareSevere
                    //            string col4 = Request.Form["cbVeryRareStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("VeryRareSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    //for (int r = 0; r <= int.Parse(hdVeryRareSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbVeryRareFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode[0].AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);

                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbVeryRareSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode[0].AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbVeryRareSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbVeryRareSevere
                    //            string col3 = Request.Form["cbVeryRareAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbVeryRareSevere
                    //            string col4 = Request.Form["cbVeryRareStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region Unknown SideEffects
            try
            {
                //if (hdUnknownSymptoms.Value == "")
                //    hdUnknownSymptoms.Value = "0";
                XmlNodeList knt = doc.GetElementsByTagName("UnknownSideEffects");
                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("UnknownSideEffects");
                    rootnode.AppendChild(xnode);

                    //for (int r = 0; r <= int.Parse(hdUnknownSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbUnknownFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode.AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);

                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode.AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);

                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbUnknownSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbUnknownSevere
                    //            string col3 = Request.Form["cbUnknownAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbUnknownSevere
                    //            string col4 = Request.Form["cbUnknownStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("UnknownSideEffects");
                    rootnode.AppendChild(xnode[0]);

                    //for (int r = 0; r <= int.Parse(hdUnknownSymptoms.Value); r++)
                    //{
                    //    try
                    //    {
                    //        string col0 = Request.Form["tbUnknownFrequency" + r.ToString()].ToString();
                    //        string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                    //        XmlNode subnode = doc.CreateElement("row");
                    //        xnode[0].AppendChild(subnode);

                    //        XmlNode subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col0));
                    //        subnode.AppendChild(subsubnode);

                    //        subsubnode = doc.CreateElement("column");
                    //        subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        subnode.AppendChild(subsubnode);


                    //        ////if this bombs, this row does not exist. therefore, don't need to check cb's
                    //        //string col1 = Request.Form["tbUnknownSymptom" + r.ToString()].ToString();

                    //        //XmlNode subnode = doc.CreateElement("row");
                    //        //xnode[0].AppendChild(subnode);

                    //        //XmlNode subsubnode = doc.CreateElement("column");
                    //        //subsubnode.AppendChild(doc.CreateTextNode(col1));
                    //        //subnode.AppendChild(subsubnode);
                    //        try
                    //        {
                    //            //if this bombs (after passing tb above, it means the cb is not checked, Request.Form is empty null.
                    //            string col2 = Request.Form["cbUnknownSevere" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col2));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }

                    //        try
                    //        {
                    //            //same comment as cbUnknownSevere
                    //            string col3 = Request.Form["cbUnknownAllCases" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col3));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        try
                    //        {
                    //            //same comment as cbUnknownSevere
                    //            string col4 = Request.Form["cbUnknownStoptaking" + r.ToString()].ToString();
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode(col4));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //        catch
                    //        {
                    //            subsubnode = doc.CreateElement("column");
                    //            subsubnode.AppendChild(doc.CreateTextNode("false"));
                    //            subnode.AppendChild(subsubnode);
                    //        }
                    //    }
                    //    catch
                    //    { }
                    //}
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            //helpers.Processes.ValidateAndSave(doc, rootnode, "SideEffectsWhatToDo", "", tbSideEffectsWhatToDo.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationHowToStore", "", tbHowToStore.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "ReportingSuspectedSE", "", tbReportingSuspectedSE.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "MoreInformation", "", tbMoreInformation.Value, false);

            //string tbLastrRevisedVal = Request.Form[tbLastrRevised.UniqueID];
            //helpers.Processes.ValidateAndSave(doc, rootnode, "MedicationLastrRevised", "", tbLastrRevisedVal, false);

            //helpers.Processes.XMLDraft = doc;
            Session["draft"] = doc;

            return doc;
        }

        protected void menutabs_MenuItemClick(object sender, MenuEventArgs e)
        {
            //SaveInMemory();
            Response.Redirect(submenutabs.SelectedValue + ".aspx");
        }
    }
}