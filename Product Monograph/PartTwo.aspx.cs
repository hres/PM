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
using System.Text;
using System.Xml.Linq;
using System.Collections;
using System.IO.Compression;
using Product_Monograph.helpers;
using System.ComponentModel;
using System.Drawing;

namespace Product_Monograph
{
    public partial class PartTwo : BasePage
    {
        string strscript = "";
        protected static string schedulingSymbol;
        protected static string brandNameTitle;
        protected static string properNameTitle;
        protected static string sumPharmInfo;
        protected static string sumClinicalTrials;
        protected static string sumPharmacology;
        protected static string sumMicrobiology;
        protected static string sumToxicology;
        protected static string sumReferences;
        protected static string drugSubstance;
        protected static string chemicalName;
        protected static string molecularFormula;
        protected static string molecularMass;
        protected static string physicochemicalProp;
        protected static string clinicalTrials;
        protected static string compBioStudies;
        protected static string analyteName;
        protected static string parameter;
        protected static string test;
        protected static string reference;
        protected static string ratioGeoMeans;
        protected static string confInterval;
        protected static string auctUnit;
        protected static string auciUnit;
        protected static string cmaxUnit;
        protected static string tmax;
        protected static string halfLife;
        protected static string idTestProduct;
        protected static string idRefProduct;
        protected static string auct24;
        protected static string arithmeticMedian;
        protected static string arithmeticOnly;
        protected static string confidenceInterval;
        protected static string pharmacology;
        protected static string microbiology;
        protected static string toxicology;
        protected static string references;
        protected static string compBioStudiesInfo;
        protected static string addButton;
        protected static string removeButton;

        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }

            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.partTwo;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.partTwo;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                schedulingSymbol = Resources.Resource.schedulingSymbol;
                brandNameTitle = Resources.Resource.brandNameTitle;
                properNameTitle = Resources.Resource.properNameTitle;
                sumPharmInfo = Resources.Resource.sumPharmInfo;
                sumClinicalTrials = Resources.Resource.sumClinicalTrials;
                sumPharmacology = Resources.Resource.sumPharmacology;
                sumMicrobiology = Resources.Resource.sumMicrobiology;
                sumToxicology = Resources.Resource.sumToxicology;
                sumReferences = Resources.Resource.sumReferences;
                drugSubstance = Resources.Resource.drugSubstance;
                chemicalName = Resources.Resource.chemicalName;
                molecularFormula = Resources.Resource.molecularFormula;
                molecularMass = Resources.Resource.molecularMass;
                physicochemicalProp= Resources.Resource.physicochemicalProp;
                clinicalTrials = Resources.Resource.clinicalTrials;
                compBioStudies = Resources.Resource.compBioStudies;
                analyteName = Resources.Resource.analyteName;
                parameter = Resources.Resource.parameter;
                test = Resources.Resource.test;
                reference = Resources.Resource.reference;
                ratioGeoMeans = Resources.Resource.ratioGeoMeans;
                confInterval = Resources.Resource.confInterval;
                auctUnit = Resources.Resource.auctUnit;
                auciUnit = Resources.Resource.auciUnit;
                cmaxUnit = Resources.Resource.cmaxUnit;
                tmax = Resources.Resource.tmax;
                halfLife = Resources.Resource.halfLife;
                idTestProduct = Resources.Resource.idTestProduct;
                idRefProduct = Resources.Resource.idRefProduct;
                auct24 = Resources.Resource.auct24;
                arithmeticMedian = Resources.Resource.arithmeticMedian;
                arithmeticOnly = Resources.Resource.arithmeticOnly;
                confidenceInterval = Resources.Resource.confidenceInterval;
                pharmacology = Resources.Resource.pharmacology;
                microbiology = Resources.Resource.microbiology;
                toxicology = Resources.Resource.toxicology;
                references = Resources.Resource.references;
                compBioStudiesInfo = Resources.Resource.compBioStudiesInfo;
                addButton = Resources.Resource.addButton;
                removeButton = Resources.Resource.removeButton;


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
            XmlNodeList pharInfo = xmldoc.GetElementsByTagName("PharmaceuticalInformation");
            if (pharInfo.Count > 0)
            {
                #region PharmaceuticalInformation
                var rows = from row in doc.Root.Elements("PharmaceuticalInformation").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                int rowcounter = 0;
                foreach (var row in rows)
                {
                    string[] colarray = "tbDrugSub;tbChemical;tbMolecular;tbMass;tbPhysicochemical;".Split(';');
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
                        strscript += "AddDrugSubstance();";  
                        foreach (string column in row.columns)
                        {
                             strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }

                    rowcounter++;
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

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              PharSchedulingSymbol = (string)item.Element("PharSchedulingSymbol"),
                              PharSchedulingSymbolImageName = (string)item.Element("PharSchedulingSymbolImageName"),
                              PharSchedulingSymbolImageData = (string)item.Element("PharSchedulingSymbolImageData"),
                              ClinicalTrials = (string)item.Element("ClinicalTrials"),
                              DetailedPharmacology = (string)item.Element("DetailedPharmacology"),
                              Microbiology = (string)item.Element("Microbiology"),
                              Toxicology = (string)item.Element("Toxicology"),
                              References = (string)item.Element("References"),                             
                          };
            foreach (var xmldataitem in xmldata)
            {
                tbClinicalTrials.Value = xmldataitem.ClinicalTrials;
                tbDetailedPharmacology.Value = xmldataitem.DetailedPharmacology;
                tbMicrobiology.Value = xmldataitem.Microbiology;
                tbToxicology.Value = xmldataitem.Toxicology;
                tbReferences.Value = xmldataitem.References;
                if (xmldataitem.PharSchedulingSymbolImageData != null)
                    strscript += "$('#imgSymbol').attr('src', " + "'" + xmldataitem.PharSchedulingSymbolImageData + "');";

                if (xmldataitem.PharSchedulingSymbol != null)
                    strscript += "selectedschedulingsymbol = '" + xmldataitem.PharSchedulingSymbol + "';";

                if (xmldataitem.PharSchedulingSymbolImageName != null)
                    strscript += "$('#tbPharxmlimgfilenameSymbol').val('" + xmldataitem.PharSchedulingSymbolImageName + "');";

                if (xmldataitem.PharSchedulingSymbol != null)
                    strscript += "$('#tbPharxmlimgnameSymbol').val('" + xmldataitem.PharSchedulingSymbol + "');";
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

            #region PharmaceuticalInformation
            try
            {
                XmlNodeList pharmaceuticalInfo = doc.GetElementsByTagName("PharmaceuticalInformation");
                var tbDrugSub = new ArrayList();
                var tbChemical = new ArrayList();
                var tbMolecular = new ArrayList();
                var tbMass = new ArrayList();
                var tbPhysicochemical = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbDrugSub") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbChemical") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbMolecular") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbMass") != null &&
                   HttpContext.Current.Request.Form.GetValues("tbPhysicochemical") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbDrugSub"))
                    {
                        tbDrugSub.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbChemical"))
                    {
                        tbChemical.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbMolecular"))
                    {
                        tbMolecular.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbMass"))
                    {
                        tbMass.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbPhysicochemical"))
                    {
                        tbPhysicochemical.Add(item);
                    }
                }

                if (pharmaceuticalInfo.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("PharmaceuticalInformation");
                    rootnode.AppendChild(xnode);
                    for (int ar = 0; ar < tbDrugSub.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = tbDrugSub[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = tbChemical[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = tbMolecular[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = tbMass[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = tbPhysicochemical[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    pharmaceuticalInfo[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("PharmaceuticalInformation");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < tbDrugSub.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = tbDrugSub[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = tbChemical[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = tbMolecular[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = tbMass[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = tbPhysicochemical[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }

            
            try
            {
                #region symbol
                string symbolname = Request.Form["tbPharxmlimgnameSymbol"].ToString();
                string symbolfilename = Request.Form["tbPharxmlimgfilenameSymbol"].ToString();

                if (symbolfilename != string.Empty)
                {
                    System.Drawing.Image imageBmp = System.Drawing.Image.FromFile(Server.MapPath("~/scheduling symbol/" + symbolfilename));
                    Bitmap bmp = new Bitmap(imageBmp);
                    TypeConverter converter = TypeDescriptor.GetConverter(typeof(Bitmap));
                    string base64 = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));


                    XmlNodeList schedsymbol = doc.GetElementsByTagName("PharSchedulingSymbol");
                    if (schedsymbol.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "PharSchedulingSymbol", "", symbolname, false);
                    }
                    else
                    {
                        schedsymbol[0].InnerText = symbolname;
                    }
                    XmlNodeList schedsymbolname = doc.GetElementsByTagName("PharSchedulingSymbolImageName");
                    if (schedsymbolname.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "PharSchedulingSymbolImageName", "", symbolfilename, false);
                    }
                    else
                    {
                        schedsymbolname[0].InnerText = symbolfilename;
                    }
                    XmlNodeList schedsymboldata = doc.GetElementsByTagName("PharSchedulingSymbolImageData");
                    if (schedsymboldata.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "PharSchedulingSymbolImageData", "", base64, false);
                    }
                    else
                    {
                        schedsymboldata[0].InnerText = base64;
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
                //  lblError.Text = error.ToString();
                return null;
            }
           
            helpers.Processes.ValidateAndSave(doc, rootnode, "ClinicalTrials", "", tbClinicalTrials.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DetailedPharmacology", "", tbDetailedPharmacology.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Microbiology", "", tbMicrobiology.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Toxicology", "", tbToxicology.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "References", "", tbReferences.Value, false);
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
                //lblError.Text = error.ToString();
                return null;
            }
            #endregion

            SessionHelper.Current.draftForm= doc;
            return doc;
        }
    }
}