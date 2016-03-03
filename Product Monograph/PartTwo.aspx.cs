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
using System.Threading;
using System.Globalization;

namespace Product_Monograph
{
    public partial class PartTwo : System.Web.UI.Page
    {
        string strscript = "";

        void Page_PreInit(Object sender, EventArgs e)
        {
            //retrieve culture information from session
            string culture = Convert.ToString(Session["SelectedLanguage"]);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);

            if (Session["masterpage"] != null)
            {
                this.MasterPageFile = (String)Session["masterpage"];

            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            

            lblError.Text = "";

            if (!IsPostBack)
            {
                try
                {
                    LoadFromXML();
                }
                catch
                {
                    lblError.Text = "Please load a new template or a previously saved draft.";
                }
            }

            lblPartII.Text = Resources.Resource.PartII;
            lblSumPharmInfo.Text = Resources.Resource.SumPharmInfo;
            lblSumCT.Text = Resources.Resource.SumCT;
            lblSumPharmacology.Text = Resources.Resource.SumPharmacology;
            lblSumMicrobiology.Text = Resources.Resource.SumMicrobiology;
            lblSumToxicology.Text = Resources.Resource.SumToxicology;
            lblSumRef.Text = Resources.Resource.SumRef;
            lblRef.Text = Resources.Resource.References;
            lblToxicology.Text = Resources.Resource.Toxicology;
            lblMicrobiology.Text = Resources.Resource.Microbiology;
            lblDetailedPharma.Text = Resources.Resource.DetailedPharma;
            lblClinicalTrials.Text = Resources.Resource.ClinicalTrials;
            lblChemicalname.Text = Resources.Resource.Chemicalname;
            lblMolecularformula.Text = Resources.Resource.Molecularformula;
            lblMolecularmass.Text = Resources.Resource.Molecularmass;
            lblPhysicochemicalproperties.Text = Resources.Resource.Physicochemicalproperties;
            lblStructuraform.Text = Resources.Resource.Structuralformula;
            lblBioStudy.Text = Resources.Resource.BioStudy;
            lblParameter.Text = Resources.Resource.Parameter;
            lblDrugSub.Text = Resources.Resource.DrugSub;
            lblAnalyteName.Text = Resources.Resource.AnalyteName;
            lblTest.Text = Resources.Resource.Test;
            lblReference.Text = Resources.Resource.Reference;
            lblRGM.Text = Resources.Resource.RGM;
            lblConfInter.Text = Resources.Resource.ConfInter;
            lblNote1.Text = Resources.Resource.Note1;
            lblNote2.Text = Resources.Resource.Note2;
            lblNote3.Text = Resources.Resource.Note3;
            lblNote4.Text = Resources.Resource.Note4;
            lblNote5.Text = Resources.Resource.Note5;
            lblNote6.Text = Resources.Resource.Note6;
            btnAddClinicalTrialsOuterTextBox.Text = Resources.Resource.BtnAdd;
            btnAddAnalyteNameTextBox.Text = Resources.Resource.BtnAdd;
            btnAddDrugSubstance.Text = Resources.Resource.BtnAdd;



        }       


        private void LoadFromXML()
        {
            //if (helpers.Processes.XMLPath != null)
            //{
            //    DirectoryInfo dir = new DirectoryInfo(helpers.Processes.XMLPath);
            //    foreach (FileInfo fileinfo in dir.GetFiles())
            //    {
            //        if (fileinfo.Name.ToLower().Contains("qmark.png"))
            //        {
            //            using (FileStream fs = fileinfo.Open(FileMode.Open, FileAccess.Read))
            //            {
            //                byte[] imageData = new byte[fs.Length];
            //                fs.Read(imageData, 0, System.Convert.ToInt32(fs.Length));
            //                fs.Close();
            //                strscript += "$('#fuimage0').attr('src', " + "'data:image/jpeg;base64," + Convert.ToBase64String(imageData) + "');";
            //                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);
            //            }
            //        }
            //    }
            //}
            //else
            //{ 
            
            //}

            string lblpropername = "";

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
                        //if (colarray[colcounter].Equals("tbBrandName"))
                        //{
                        //    lblBrandNameProprietary.Text = helpers.Processes.CleanString(column);
                        //    lblBrandNameTbl.Text = helpers.Processes.CleanString(column);
                        //    lblBrandNameWP.Text = helpers.Processes.CleanString(column);
                        //}

                        if (colarray[colcounter].Equals("tbProperName"))
                        {
                            lblpropername = helpers.Processes.CleanString(column);
                            //lblProperNameMI.Text = helpers.Processes.CleanString(column);
                        }

                        colcounter++;
                    }

                    break;
                }
                #endregion
            } 

            XmlNodeList sci = xmldoc.GetElementsByTagName("ScientificInformation");

            //on the very first visit on part two, when ScientificInformation element is not yet created
            strscript += "$('#tbSciInfoProperName0').val(\"" + helpers.Processes.CleanString(lblpropername) + "\");";
            //this will never change (value from cover page)
            strscript += "lblpropername = '" + lblpropername + "';";       

            if (sci.Count > 0)
            {
                #region ScientificInformation
                var rows = from row in doc.Root.Elements("ScientificInformation").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                bool ran = false;
                int rowcounter = 0;

                foreach (var row in rows)
                {
                    if (!ran)
                    {
                        string[] colarray = "tbSciInfoProperName;tbSciInfoChemicalname;tbSciInfoMolecularformula;tbSciInfoMolecularmass;tbfuimagename;tbfuimagebasesixtyfour;tbPhysicochemicalproperties".Split(';');
                        int colcounter = 0;
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbfuimagebasesixtyfour"))
                            {
                                strscript += "$('#fuimage" + rowcounter + "').attr('src', " + "'" + column + "');";
                            }

                            //lblpropername (set from LoadFromXML()
                            if (colarray[colcounter].Equals("tbSciInfoProperName"))
                            {                                
                                //strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(lblpropername) + "\");";                            
                            }
                            else                                
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";

                            colcounter++;
                        }

                        ran = true;
                    }
                    else
                    {
                        strscript += "AddDrugSubstanceTextBox();";
                                                
                        string[] colarray = "tbSciInfoProperName;tbSciInfoChemicalname;tbSciInfoMolecularformula;tbSciInfoMolecularmass;tbfuimagename;tbfuimagebasesixtyfour;tbPhysicochemicalproperties".Split(';');
                        int colcounter = 0;
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbfuimagebasesixtyfour"))
                            {
                                strscript += "$('#fuimage" + rowcounter + "').attr('src', " + "'" + column + "');";
                            }

                            //lblpropername (set from LoadFromXML()
                            if (colarray[colcounter].Equals("tbSciInfoProperName"))
                            {
                                //strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(lblpropername) + "\");";
                            }
                            else
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";

                            //strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                
                            colcounter++;
                        }
                    }

                    rowcounter++;
                }
                #endregion
            }

            XmlNodeList clt = xmldoc.GetElementsByTagName("ClinicalTrials");
            if (clt.Count > 0)
            {
                #region Clinical Trials
                var arsections = from rows in doc.Root.Elements("ClinicalTrials").Descendants("row")
                                 select new
                                 {
                                     title = rows.Element("title").Value,
                                     desc = rows.Element("desc").Value,
                                     tblnumbers = rows.Element("tblnumber").Value,
                                     tblvalues = rows.Element("tblvalue").Value,
                                     tables = rows.Elements("table"),
                                     summary = rows.Element("summary").Value,
                                     imgcaption = rows.Element("imgcaption").Value,
                                     imgname = rows.Element("imgname").Value,
                                     imgdata = rows.Element("imgdata").Value,
                                     footer = rows.Element("footer").Value
                                 };

                int sectioncounter = 1;
                int tblcounter = 1;
                foreach (var arsection in arsections)
                {
                    strscript += "AddClinicalTrialsOuterSection();";

                    string t = arsection.title;
                    strscript += "$('#lblSelectedHeaderClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(t) + "\");";
                    strscript += "$('#lblSelectedHeaderCountClinicalTrials" + sectioncounter.ToString() + "').val(\"" + sectioncounter + "\");";

                    string d = arsection.desc;
                    strscript += "$('#tbSelectedHeaderClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(d) + "\");";

                    string tn = arsection.tblnumbers;
                    strscript += "$('#nmTableNumberClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tn) + "\");";

                    string tv = arsection.tblvalues;
                    strscript += "$('#tbTableTextClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tv) + "\");";


                    foreach (var table in arsection.tables)
                    {
                        strscript += "AddClinicalTrialsInnerTextBox(" + sectioncounter.ToString() + ");";

                        int fixindex = 0;
                        foreach (var item in table.Elements("item"))
                        {
                            if (fixindex == 0)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadOneClinicalTrials" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 1)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadTwoClinicalTrials" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 2)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyOneClinicalTrials" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 3)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyTwoClinicalTrials" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 4)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbNarrativeClinicalTrials" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            fixindex++;
                        }

                        tblcounter++;
                    }

                    string s = arsection.summary;
                    strscript += "$('#tbSelectedHeaderDescClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(s) + "\");";

                    string imgc = arsection.imgcaption;
                    strscript += "$('#tbSelectedImageCaptionClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(imgc) + "\");";

                    string imgn = arsection.imgname;
                    strscript += "$('#tbfuimagenameClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(imgn) + "\");";

                    string imgd = arsection.imgdata;
                    strscript += "$('#fuimageClinicalTrials" + sectioncounter.ToString() + "').attr('src', " + "'" + imgd + "');";
                    strscript += "$('#tbfuimagebasesixtyfourClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(imgd) + "\");";
                  
                    string f = arsection.footer;
                    strscript += "$('#tbSelectedFooterDescClinicalTrials" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(f) + "\");";

                    sectioncounter++;
                }
                #endregion
            }

            XmlNodeList anal = xmldoc.GetElementsByTagName("AnalyteName");
            if (anal.Count > 0)
            {
                #region Analyte Name
                var krows = from row in doc.Root.Elements("AnalyteName").Descendants("row")
                            select new
                            {
                                columns = from column in row.Elements("column")
                                          select (string)column
                            };

                bool kran = false;
                int krowcounter = 0;

                foreach (var krow in krows)
                {
                    if (!kran)
                    {

                        string[] kcolarray = "tbAUCTTest;tbAUCTReference;tbAUCTPercentRatio;tbAUCTConfidenceInterval;tbAUCITest;tbAUCIReference;tbAUCIPercentRatio;tbAUCIConfidenceInterval;tbCMAXTest;tbCMAXReference;tbCMAXPercentRatio;tbCMAXConfidenceInterval;tbTMAXTest;tbTMAXReference;tbTMAXPercentRatio;tbTMAXConfidenceInterval;tbTHalfTest;tbTHalfReference;tbTHalfPercentRatio;tbTHalfConfidenceInterval;tbAnalyteMultiplicand;tbAnalyteMultiplier".Split(';');
                        int kcolcounter = 0;
                        foreach (string kcolumn in krow.columns)
                        {
                            strscript += "$('#" + kcolarray[kcolcounter] + krowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(kcolumn) + "\");";
                            kcolcounter++;
                        }

                        kran = true;
                    }
                    else
                    {
                        strscript += "AddAnalyteNameTextBox();";

                        string[] kcolarray = "tbAUCTTest;tbAUCTReference;tbAUCTPercentRatio;tbAUCTConfidenceInterval;tbAUCITest;tbAUCIReference;tbAUCIPercentRatio;tbAUCIConfidenceInterval;tbCMAXTest;tbCMAXReference;tbCMAXPercentRatio;tbCMAXConfidenceInterval;tbTMAXTest;tbTMAXReference;tbTMAXPercentRatio;tbTMAXConfidenceInterval;tbTHalfTest;tbTHalfReference;tbTHalfPercentRatio;tbTHalfConfidenceInterval;tbAnalyteMultiplicand;tbAnalyteMultiplier".Split(';');
                        int kcolcounter = 0;
                        foreach (string kcolumn in krow.columns)
                        {
                            strscript += "$('#" + kcolarray[kcolcounter] + krowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(kcolumn) + "\");";
                            kcolcounter++;
                        }
                    }

                    krowcounter++;
                }
                #endregion
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              SciInfoProperName = (string)item.Element("SciInfoProperName"),
                              SciInfoChemicalname = (string)item.Element("SciInfoChemicalname"),
                              SciInfoMolecularformula = (string)item.Element("SciInfoMolecularformula"),
                              StructuralFormula = (string)item.Element("StructuralFormula"),
                              Physicochemicalproperties = (string)item.Element("Physicochemicalproperties"),
                              //ClinicalTrials = (string)item.Element("ClinicalTrials"),
                              //StudyDemoStudy = (string)item.Element("StudyDemoStudy"),
                              //StudyDemoTrialdesign = (string)item.Element("StudyDemoTrialdesign"),
                              //StudyDemoDosageroute = (string)item.Element("StudyDemoDosageroute"),
                              //StudyDemoStudysubjects = (string)item.Element("StudyDemoStudysubjects"),
                              //StudyDemoMeanage = (string)item.Element("StudyDemoMeanage"),
                              //StudyDemoGender = (string)item.Element("StudyDemoGender"),
                              //StudyResultsPrimaryEndpoints = (string)item.Element("StudyResultsPrimaryEndpoints"),
                              //StudyResultsAssocValueDrugSpecific = (string)item.Element("StudyResultsAssocValueDrugSpecific"),
                              //StudyResultsAssocValueSignificancePlacebo = (string)item.Element("StudyResultsAssocValueSignificancePlacebo"),
                              StudyDetailedPharmacology = (string)item.Element("StudyDetailedPharmacology"),
                              StudyMicrobiology = (string)item.Element("StudyMicrobiology"),
                              StudyToxicology = (string)item.Element("StudyToxicology"),
                              StudyReferences = (string)item.Element("StudyReferences")
                          };

            foreach (var xmldataitem in xmldata)
            {
                //tbSciInfoProperName.Text = xmldataitem.SciInfoProperName;
                //tbSciInfoChemicalname.Text = xmldataitem.SciInfoChemicalname;
                //tbSciInfoMolecularformula.Text = xmldataitem.SciInfoMolecularformula;

                //if (xmldataitem.StructuralFormula != null)
                //{
                //    if (xmldataitem.StructuralFormula != "")
                //    {
                //        //imgStructuralformula.Src = "data:image/jpeg;base64," + xmldataitem.StructuralFormula;
                //        Session["StructuralFormulaToBase64String"] = xmldataitem.StructuralFormula;
                //    }
                //    else
                //    {
                //        //imgStructuralformula.Src = "images/x.png";
                //    }
                //}

                //tbPhysicochemicalproperties.Text = xmldataitem.Physicochemicalproperties;

                //tbClinicalTrials.Value = xmldataitem.ClinicalTrials;
                //tbStudy.Value = xmldataitem.StudyDemoStudy;
                //tbTrialdesign.Value = xmldataitem.StudyDemoTrialdesign;
                //tbDosageroute.Value = xmldataitem.StudyDemoDosageroute;
                //tbStudysubjects.Value = xmldataitem.StudyDemoStudysubjects;
                //tbMeanage.Value = xmldataitem.StudyDemoMeanage;
                //tbGender.Value = xmldataitem.StudyDemoGender;
                //tbPrimaryEndpoints.Value = xmldataitem.StudyResultsPrimaryEndpoints;
                //tbAssocValueDrugSpecific.Value = xmldataitem.StudyResultsAssocValueDrugSpecific;
                //tbAssocValueSignificancePlacebo.Value = xmldataitem.StudyResultsAssocValueSignificancePlacebo;
                tbDetailedPharma.Value = xmldataitem.StudyDetailedPharmacology;
                tbMicrobiology.Value = xmldataitem.StudyMicrobiology;
                tbToxicology.Value = xmldataitem.StudyToxicology;
                tbReferences.Value = xmldataitem.StudyReferences;
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


                    XDocument xdoc = XDocument.Parse(doc.OuterXml);

                    XmlNodeList sci = doc.GetElementsByTagName("ScientificInformation");
                    if (sci.Count > 0)
                    {
                        #region ScientificInformation
                        var rows = from row in xdoc.Root.Elements("ScientificInformation").Descendants("row")
                                   select new
                                   {
                                       columns = from column in row.Elements("column")
                                                 select (string)column
                                   };

                        int rowcounter = 0;
                        foreach (var row in rows)
                        {                                
                                string[] colarray = "tbSciInfoProperName;tbSciInfoChemicalname;tbSciInfoMolecularformula;tbSciInfoMolecularmass;tbfuimagename;tbfuimagebasesixtyfour;tbPhysicochemicalproperties".Split(';');
                                string imgname = "";
                                int colcounter = 0;
                                foreach (string column in row.columns)
                                {
                                    if (colarray[colcounter].Equals("tbfuimagename"))
                                    {
                                        imgname = column;
                                    }
                                    if (colarray[colcounter].Equals("tbfuimagebasesixtyfour"))
                                    {
                                        if (imgname == string.Empty)
                                            continue;

                                        var zipEntry = zipArchive.CreateEntry(imgname);
                                        using (var originalFileStream = new MemoryStream(Convert.FromBase64String(column.Replace("data:image/jpeg;base64,", "").Replace("data:image/png;base64,", "").Replace("data:image/gif;base64,", ""))))
                                        {
                                            using (var zipEntryStream = zipEntry.Open())
                                            {
                                                originalFileStream.CopyTo(zipEntryStream);
                                            }
                                        }
                                    }
                                    colcounter++;
                                }
                            rowcounter++;
                            continue;

                         
                        }
                        #endregion
                    }

                    XmlNodeList clt = doc.GetElementsByTagName("ClinicalTrials");
                    if (clt.Count > 0)
                    {
                        #region Clinical Trials
                        var cltsections = from rows in xdoc.Root.Elements("ClinicalTrials").Descendants("row")
                                         select new
                                         {
                                             imgname = rows.Element("imgname").Value,
                                             imgdata = rows.Element("imgdata").Value
                                         };

                        foreach (var arsection in cltsections)
                        {
                            string img = arsection.imgname;
                            string img64 = arsection.imgdata;

                            if (img == string.Empty)
                                continue;

                            var zipEntry = zipArchive.CreateEntry(img);
                            using (var originalFileStream = new MemoryStream(Convert.FromBase64String(img64.Replace("data:image/jpeg;base64,", "").Replace("data:image/png;base64,", "").Replace("data:image/gif;base64,", ""))))
                            {
                                using (var zipEntryStream = zipEntry.Open())
                                {
                                    originalFileStream.CopyTo(zipEntryStream);
                                }
                            }
                        }
                        #endregion
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

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {           
            SaveProcess();
        }
        
        protected void btnApplyStructuralformula_Click(object sender, EventArgs e)
        {
            //if (fuStructuralformula.HasFile)
            //{
            //    FileInfo fi = new FileInfo(fuStructuralformula.FileName);
            //    if (!fi.Extension.ToString().ToLower().Contains("jpeg") &&
            //        !fi.Extension.ToString().ToLower().Contains("jpg") &&
            //        !fi.Extension.ToString().ToLower().Contains("png") &&
            //        !fi.Extension.ToString().ToLower().Contains("gif"))
            //    {
            //        lblError.Text = "Choose an image file";
            //        return;
            //    }
            //}
            //else
            //{
            //    lblError.Text = "Choose a file";
            //    return;
            //}

            //System.Drawing.Bitmap bmp = new System.Drawing.Bitmap(fuStructuralformula.PostedFile.InputStream);
            //TypeConverter converter = TypeDescriptor.GetConverter(typeof(Bitmap));
            //imgStructuralformula.Src = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));
            //Session["StructuralFormulaToBase64String"] = Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));
            //imgStructuralformula.Visible = true;
        }

        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
            XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");

            #region ScientificInformation
            try
            {
                //helpers.Processes.ValidateAndSave(doc, rootnode, "SciInfoProperName", "", tbSciInfoProperName.Text, false);
                //helpers.Processes.ValidateAndSave(doc, rootnode, "SciInfoChemicalname", "", tbSciInfoChemicalname.Text, false);
                //helpers.Processes.ValidateAndSave(doc, rootnode, "SciInfoMolecularformula", "", tbSciInfoMolecularformula.Text, false);
                #region Structural formula
                //XmlNodeList structure = doc.GetElementsByTagName("StructuralFormula");
                //if (structure.Count < 1)
                //{
                //    try
                //    {
                //        helpers.Processes.CreateXMLElement(doc, rootnode, "StructuralFormula", "", Session["StructuralFormulaToBase64String"].ToString(), false);
                //    }
                //    catch
                //    {
                //        helpers.Processes.CreateXMLElement(doc, rootnode, "StructuralFormula", "", "", false);
                //    }
                //}
                //else
                //{
                //    try
                //    {
                //        structure[0].InnerText = Session["StructuralFormulaToBase64String"].ToString();
                //    }
                //    catch
                //    {
                //        structure[0].InnerText = "";
                //    }
                //}
                #endregion
                //helpers.Processes.ValidateAndSave(doc, rootnode, "Physicochemicalproperties", "", tbPhysicochemicalproperties.Text, false);

                XmlNodeList sciinfo = doc.GetElementsByTagName("ScientificInformation");

                ArrayList SciInfoProperNamearray = new ArrayList();
                ArrayList SciInfoChemicalnamearray = new ArrayList();
                ArrayList SciInfoMolecularformulaarray = new ArrayList();
                ArrayList SciInfoMolecularmassarray = new ArrayList();
                ArrayList SciInfoFileUploadNamearray = new ArrayList();
                ArrayList SciInfoFileUploadb64array = new ArrayList();
                ArrayList SciInfoPhysicochemicalpropertiesarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbSciInfoProperName") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbSciInfoChemicalname") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbSciInfoMolecularformula") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbSciInfoMolecularmass") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbfuimagename") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbPhysicochemicalproperties") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbSciInfoProperName"))
                    {
                        SciInfoProperNamearray.Add(routeitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbSciInfoChemicalname"))
                    {
                        SciInfoChemicalnamearray.Add(dosageitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbSciInfoMolecularformula"))
                    {
                        SciInfoMolecularformulaarray.Add(dosageitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbSciInfoMolecularmass"))
                    {
                        SciInfoMolecularmassarray.Add(dosageitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbfuimagename"))
                    {
                        SciInfoFileUploadNamearray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfour"))
                    {
                        SciInfoFileUploadb64array.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbPhysicochemicalproperties"))
                    {
                        SciInfoPhysicochemicalpropertiesarray.Add(ingredientitem);
                    }
                }

                if (sciinfo.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("ScientificInformation");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < SciInfoProperNamearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = SciInfoProperNamearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = SciInfoChemicalnamearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = SciInfoMolecularformulaarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = SciInfoMolecularmassarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = SciInfoFileUploadNamearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = SciInfoFileUploadb64array[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = SciInfoPhysicochemicalpropertiesarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    sciinfo[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("ScientificInformation");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < SciInfoProperNamearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = SciInfoProperNamearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = SciInfoChemicalnamearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = SciInfoMolecularformulaarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = SciInfoMolecularmassarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = SciInfoFileUploadNamearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = SciInfoFileUploadb64array[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = SciInfoPhysicochemicalpropertiesarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col7));
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

            //helpers.Processes.ValidateAndSave(doc, rootnode, "ClinicalTrials", "", tbClinicalTrials.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoStudy", "", tbStudy.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoTrialdesign", "", tbTrialdesign.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoDosageroute", "", tbDosageroute.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoStudysubjects", "", tbStudysubjects.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoMeanage", "", tbMeanage.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDemoGender", "", tbGender.Value, false);

            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyResultsPrimaryEndpoints", "", tbPrimaryEndpoints.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyResultsAssocValueDrugSpecific", "", tbAssocValueDrugSpecific.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "StudyResultsAssocValueSignificancePlacebo", "", tbAssocValueSignificancePlacebo.Value, false);

            #region Clinical Trials
            int NumberOfSections = 0;
            if (HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderClinicalTrials") != null)
            {
                NumberOfSections = HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderClinicalTrials").Length;

                ArrayList headerlabelsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderClinicalTrials"))
                {
                    headerlabelsarray.Add(itemvalue);
                }

                ArrayList headerdescsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderClinicalTrials"))
                {
                    headerdescsarray.Add(itemvalue);
                }

                ArrayList bottomdescarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderDescClinicalTrials"))
                {
                    bottomdescarray.Add(itemvalue);
                }

                ArrayList captionarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedImageCaptionClinicalTrials"))
                {
                    captionarray.Add(itemvalue);
                }

                ArrayList imgnamearray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbfuimagenameClinicalTrials"))
                {
                    imgnamearray.Add(itemvalue);
                }

                ArrayList basesixtyfourarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbfuimagebasesixtyfourClinicalTrials"))
                {
                    basesixtyfourarray.Add(itemvalue);
                }

                ArrayList tableindexarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderCountClinicalTrials"))
                {
                    tableindexarray.Add(itemvalue);
                }

                ArrayList tablenumberarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("nmTableNumberClinicalTrials"))
                {
                    tablenumberarray.Add(itemvalue);
                }

                ArrayList tablevaluerarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbTableTextClinicalTrials"))
                {
                    tablevaluerarray.Add(itemvalue);
                }

                ArrayList footerdescarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedFooterDescClinicalTrials"))
                {
                    footerdescarray.Add(itemvalue);
                }

                XmlNodeList clt = doc.GetElementsByTagName("ClinicalTrials");

                string lblSelectedHeader = "";

                string tbSelectedHeader = "";

                string[,] ClinicalTrialsArray = null;

                string tbSelectedHeaderDesc = "";

                string nmTableNumber = "";

                string tbTableText = "";

                string tbSelectedImageCaption = "";

                string tbfuimagename = "";

                string tbfuimagebasesixtyfour = "";

                string tbSelectedfooterDesc = "";

                try
                {
                    if (clt.Count < 1)
                    {
                        XmlNode xnode = doc.CreateElement("ClinicalTrials"); 
                        rootnode.AppendChild(xnode); 

                        #region Inner table
                        for (int s = 1; s <= NumberOfSections; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedImageCaption = captionarray[s - 1].ToString();

                            tbfuimagename = imgnamearray[s - 1].ToString();

                            tbfuimagebasesixtyfour = basesixtyfourarray[s - 1].ToString();

                            tbSelectedfooterDesc = footerdescarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("title");
                            subsubnode.AppendChild(doc.CreateTextNode(lblSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("desc");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblnumber");
                            subsubnode.AppendChild(doc.CreateTextNode(nmTableNumber));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblvalue");
                            subsubnode.AppendChild(doc.CreateTextNode(tbTableText));
                            subnode.AppendChild(subsubnode);

                            #region inner table
                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex) != null)
                            {
                                ClinicalTrialsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOneClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativeClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < ClinicalTrialsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }
                            #endregion

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
                            subnode.AppendChild(subsubnode);
                            
                            subsubnode = doc.CreateElement("imgcaption");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedImageCaption));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("imgname");
                            subsubnode.AppendChild(doc.CreateTextNode(tbfuimagename));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("imgdata");
                            subsubnode.AppendChild(doc.CreateTextNode(tbfuimagebasesixtyfour));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("footer");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedfooterDesc));
                            subnode.AppendChild(subsubnode);
                        }
                        #endregion

                    }
                    else
                    {
                        clt[0].RemoveAll();

                        XmlNodeList xnode = doc.GetElementsByTagName("ClinicalTrials");
                        rootnode.AppendChild(xnode[0]);

                        #region Inner table
                        for (int s = 1; s <= NumberOfSections; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedImageCaption = captionarray[s - 1].ToString();

                            tbfuimagename = imgnamearray[s - 1].ToString();

                            tbfuimagebasesixtyfour = basesixtyfourarray[s - 1].ToString();

                            tbSelectedfooterDesc = footerdescarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode);

                            XmlNode subsubnode = doc.CreateElement("title");
                            subsubnode.AppendChild(doc.CreateTextNode(lblSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("desc");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblnumber");
                            subsubnode.AppendChild(doc.CreateTextNode(nmTableNumber));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblvalue");
                            subsubnode.AppendChild(doc.CreateTextNode(tbTableText));
                            subnode.AppendChild(subsubnode);

                            #region inner table
                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex) != null)
                            {
                                ClinicalTrialsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOneClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOneClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativeClinicalTrials" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    ClinicalTrialsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < ClinicalTrialsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(ClinicalTrialsArray[4, m]));
                                    tablenode.AppendChild(itemnode);
                                }
                            }            
                            #endregion

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("imgcaption");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedImageCaption));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("imgname");
                            subsubnode.AppendChild(doc.CreateTextNode(tbfuimagename));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("imgdata");
                            subsubnode.AppendChild(doc.CreateTextNode(tbfuimagebasesixtyfour));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("footer");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedfooterDesc));
                            subnode.AppendChild(subsubnode);
                        }
                        #endregion

                    }
                }
                catch (Exception error)
                {
                    lblError.Text = error.ToString();
                    return null;
                }
            }
            else
            {
                //remove child nodes
                XmlNodeList clt = doc.GetElementsByTagName("ClinicalTrials");
                if (clt.Count > 0)
                    clt[0].RemoveAll();
            }
            #endregion      

            #region Analyte Name
            try
            {
                XmlNodeList knt = doc.GetElementsByTagName("AnalyteName");

                ArrayList aucttestarray = new ArrayList(); ArrayList auctrefarray = new ArrayList(); ArrayList auctperarray = new ArrayList(); ArrayList auctconfarray = new ArrayList();
                ArrayList aucitestarray = new ArrayList(); ArrayList aucirefarray = new ArrayList(); ArrayList auciperarray = new ArrayList(); ArrayList auciconfarray = new ArrayList();
                ArrayList cmaxtestarray = new ArrayList(); ArrayList cmaxrefarray = new ArrayList(); ArrayList cmaxperarray = new ArrayList(); ArrayList cmaxconfarray = new ArrayList();
                ArrayList tmaxtestarray = new ArrayList(); ArrayList tmaxrefarray = new ArrayList(); ArrayList tmaxperarray = new ArrayList(); ArrayList tmaxconfarray = new ArrayList();
                ArrayList thalftestarray = new ArrayList(); ArrayList thalfrefarray = new ArrayList(); ArrayList thalfperarray = new ArrayList(); ArrayList thalfconfarray = new ArrayList();
                ArrayList multicandarray = new ArrayList(); ArrayList multiplierfarray = new ArrayList();

                if (HttpContext.Current.Request.Form.GetValues("tbAUCTTest") != null && HttpContext.Current.Request.Form.GetValues("tbAUCTReference") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbAUCTPercentRatio") != null && HttpContext.Current.Request.Form.GetValues("tbAUCTConfidenceInterval") != null &&

                    HttpContext.Current.Request.Form.GetValues("tbAUCITest") != null && HttpContext.Current.Request.Form.GetValues("tbAUCIReference") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbAUCIPercentRatio") != null && HttpContext.Current.Request.Form.GetValues("tbAUCIConfidenceInterval") != null &&

                    HttpContext.Current.Request.Form.GetValues("tbCMAXTest") != null && HttpContext.Current.Request.Form.GetValues("tbCMAXReference") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbCMAXPercentRatio") != null && HttpContext.Current.Request.Form.GetValues("tbCMAXConfidenceInterval") != null &&

                    HttpContext.Current.Request.Form.GetValues("tbTMAXTest") != null && HttpContext.Current.Request.Form.GetValues("tbTMAXReference") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbTMAXPercentRatio") != null && HttpContext.Current.Request.Form.GetValues("tbTMAXConfidenceInterval") != null &&

                    HttpContext.Current.Request.Form.GetValues("tbTHalfTest") != null && HttpContext.Current.Request.Form.GetValues("tbTHalfReference") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbTHalfPercentRatio") != null && HttpContext.Current.Request.Form.GetValues("tbTHalfConfidenceInterval") != null &&

                    HttpContext.Current.Request.Form.GetValues("tbAnalyteMultiplicand") != null && HttpContext.Current.Request.Form.GetValues("tbAnalyteMultiplier") != null)
                {
                    foreach (string aucttest in HttpContext.Current.Request.Form.GetValues("tbAUCTTest"))
                    { aucttestarray.Add(aucttest); }
                    foreach (string auctref in HttpContext.Current.Request.Form.GetValues("tbAUCTReference"))
                    { auctrefarray.Add(auctref); }
                    foreach (string auctper in HttpContext.Current.Request.Form.GetValues("tbAUCTPercentRatio"))
                    { auctperarray.Add(auctper); }
                    foreach (string auctcon in HttpContext.Current.Request.Form.GetValues("tbAUCTConfidenceInterval"))
                    { auctconfarray.Add(auctcon); }

                    foreach (string aucitest in HttpContext.Current.Request.Form.GetValues("tbAUCITest"))
                    { aucitestarray.Add(aucitest); }
                    foreach (string auciref in HttpContext.Current.Request.Form.GetValues("tbAUCIReference"))
                    { aucirefarray.Add(auciref); }
                    foreach (string auciper in HttpContext.Current.Request.Form.GetValues("tbAUCIPercentRatio"))
                    { auciperarray.Add(auciper); }
                    foreach (string aucicon in HttpContext.Current.Request.Form.GetValues("tbAUCIConfidenceInterval"))
                    { auciconfarray.Add(aucicon); }

                    foreach (string cmaxtest in HttpContext.Current.Request.Form.GetValues("tbCMAXTest"))
                    { cmaxtestarray.Add(cmaxtest); }
                    foreach (string cmaxref in HttpContext.Current.Request.Form.GetValues("tbCMAXReference"))
                    { cmaxrefarray.Add(cmaxref); }
                    foreach (string cmaxper in HttpContext.Current.Request.Form.GetValues("tbCMAXPercentRatio"))
                    { cmaxperarray.Add(cmaxper); }
                    foreach (string cmaxcon in HttpContext.Current.Request.Form.GetValues("tbCMAXConfidenceInterval"))
                    { cmaxconfarray.Add(cmaxcon); }

                    foreach (string tmaxtest in HttpContext.Current.Request.Form.GetValues("tbTMAXTest"))
                    { tmaxtestarray.Add(tmaxtest); }
                    foreach (string tmaxref in HttpContext.Current.Request.Form.GetValues("tbTMAXReference"))
                    { tmaxrefarray.Add(tmaxref); }
                    foreach (string tmaxper in HttpContext.Current.Request.Form.GetValues("tbTMAXPercentRatio"))
                    { tmaxperarray.Add(tmaxper); }
                    foreach (string tmaxcon in HttpContext.Current.Request.Form.GetValues("tbTMAXConfidenceInterval"))
                    { tmaxconfarray.Add(tmaxcon); }

                    foreach (string thalftest in HttpContext.Current.Request.Form.GetValues("tbTHalfTest"))
                    { thalftestarray.Add(thalftest); }
                    foreach (string thalfref in HttpContext.Current.Request.Form.GetValues("tbTHalfReference"))
                    { thalfrefarray.Add(thalfref); }
                    foreach (string thalfper in HttpContext.Current.Request.Form.GetValues("tbTHalfPercentRatio"))
                    { thalfperarray.Add(thalfper); }
                    foreach (string thalfcon in HttpContext.Current.Request.Form.GetValues("tbTHalfConfidenceInterval"))
                    { thalfconfarray.Add(thalfcon); }

                    foreach (string cand in HttpContext.Current.Request.Form.GetValues("tbAnalyteMultiplicand"))
                    { multicandarray.Add(cand); }
                    foreach (string plier in HttpContext.Current.Request.Form.GetValues("tbAnalyteMultiplier"))
                    { multiplierfarray.Add(plier); }

                }


                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("AnalyteName");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < aucttestarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        #region 1
                        string col1 = aucttestarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = auctrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = auctperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = auctconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 2
                        string col5 = aucitestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = aucirefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = auciperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode);

                        string col8 = auciconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col8));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 3
                        string col9 = cmaxtestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col9));
                        subnode.AppendChild(subsubnode);

                        string col10 = cmaxrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col10));
                        subnode.AppendChild(subsubnode);

                        string col11 = cmaxperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col11));
                        subnode.AppendChild(subsubnode);

                        string col12 = cmaxconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col12));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 4
                        string col13 = tmaxtestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col13));
                        subnode.AppendChild(subsubnode);

                        string col14 = tmaxrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col14));
                        subnode.AppendChild(subsubnode);

                        string col15 = tmaxperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col15));
                        subnode.AppendChild(subsubnode);

                        string col16 = tmaxconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col16));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 5
                        string col17 = thalftestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col17));
                        subnode.AppendChild(subsubnode);

                        string col18 = thalfrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col18));
                        subnode.AppendChild(subsubnode);

                        string col19 = thalfperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col19));
                        subnode.AppendChild(subsubnode);

                        string col20 = thalfconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col20));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region multiplication
                        string col21 = multicandarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col21));
                        subnode.AppendChild(subsubnode);

                        string col22 = multiplierfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col22));
                        subnode.AppendChild(subsubnode);
                        #endregion
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("AnalyteName");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < aucttestarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        #region 1
                        string col1 = aucttestarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = auctrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = auctperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = auctconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 2
                        string col5 = aucitestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = aucirefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = auciperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode);

                        string col8 = auciconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col8));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 3
                        string col9 = cmaxtestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col9));
                        subnode.AppendChild(subsubnode);

                        string col10 = cmaxrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col10));
                        subnode.AppendChild(subsubnode);

                        string col11 = cmaxperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col11));
                        subnode.AppendChild(subsubnode);

                        string col12 = cmaxconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col12));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 4
                        string col13 = tmaxtestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col13));
                        subnode.AppendChild(subsubnode);

                        string col14 = tmaxrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col14));
                        subnode.AppendChild(subsubnode);

                        string col15 = tmaxperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col15));
                        subnode.AppendChild(subsubnode);

                        string col16 = tmaxconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col16));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region 5
                        string col17 = thalftestarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col17));
                        subnode.AppendChild(subsubnode);

                        string col18 = thalfrefarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col18));
                        subnode.AppendChild(subsubnode);

                        string col19 = thalfperarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col19));
                        subnode.AppendChild(subsubnode);

                        string col20 = thalfconfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col20));
                        subnode.AppendChild(subsubnode);
                        #endregion
                        #region multiplication
                        string col21 = multicandarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col21));
                        subnode.AppendChild(subsubnode);

                        string col22 = multiplierfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col22));
                        subnode.AppendChild(subsubnode);
                        #endregion
                    }
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "StudyDetailedPharmacology", "", tbDetailedPharma.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StudyMicrobiology", "", tbMicrobiology.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StudyToxicology", "", tbToxicology.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StudyReferences", "", tbReferences.Value, false);

            //helpers.Processes.XMLDraft = doc;
            Session["draft"] = doc;

            return doc;
        }

        protected void menutabs_MenuItemClick(object sender, MenuEventArgs e)
        {
            SaveInMemory();
            Response.Redirect(submenutabs.SelectedValue + ".aspx");
        }

        protected void submenutabsbottom_MenuItemClick(object sender, MenuEventArgs e)
        {
            SaveInMemory();
            Response.Redirect(submenutabsbottom.SelectedValue + ".aspx");
        }

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string asdfs = "";
        //        string uploadfilename = FileField.PostedFile.FileName;
        //    }
        //    catch (Exception ex)
        //    {
        //        Exception E = ex;
        //    }
        //}
        //<div><input id="Button1" runat="server" class="upload" onserverclick="Button1_Click" type="button" value="Update" /></div>

    }
}