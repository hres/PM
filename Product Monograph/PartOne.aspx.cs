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
using Product_Monograph.helpers;

namespace Product_Monograph
{
    public partial class PartOne : BasePage
    {
        string strscript = string.Empty;
        bool isClientLoadXML = false;

        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }

            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.partOne;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.partOne;
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
                   // lblError.Text = "Please load a new template or a previously saved draft.";
                }
            }
            else
            {
                if(isClientLoadXML)
                    LoadFromXML();
            }

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

            #region RouteOfAdministration
            try
            {
                XmlNodeList roa = doc.GetElementsByTagName("RouteOfAdministration");

                ArrayList routearray = new ArrayList();
                ArrayList dosagearray = new ArrayList();
                ArrayList strengtharray = new ArrayList();
                ArrayList ingredientsarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbRouteOfAdminDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbDosageFormDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevant") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbRouteOfAdminDynamic"))
                    {
                        routearray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbDosageFormDynamic"))
                    {
                        dosagearray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbStrengthDynamic"))
                    {
                        strengtharray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevant"))
                    {
                        ingredientsarray.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("RouteOfAdministration");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < routearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = routearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = strengtharray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ingredientsarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("RouteOfAdministration");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < routearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = routearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = strengtharray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ingredientsarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion
        
            #region IndicationsClinicalUse
            helpers.Processes.ValidateAndSave(doc, rootnode, "BrandNameIndicatedFor", "", tbbrandName.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "GeriatricsAge", "", tbGeriatricsAge.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Geriatrics", "", tbGeriatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeX", "", tbPediatricsAgeX.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeY", "", tbPediatricsAgeY.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeZ", "", tbPediatricsAgeZ.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Pediatrics", "", tbPediatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseReactions", "", tbAdverseReactions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DrugInteractions", "", tbDrugInteractions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SeriousDrugInteractions", "", tbSeriousDrugInteractions.Value, false);
            #endregion
            #region Contraindications
            try
            {
                XmlNodeList con = doc.GetElementsByTagName("Contraindications");

                ArrayList contraarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbContraindications") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbContraindications"))
                    {
                        contraarray.Add(routeitem);
                    }
                }

                if (con.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("Contraindications");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < contraarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = contraarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    con[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("Contraindications");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < contraarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = contraarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
               // lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region Warnings and precautions
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("SeriousWarningsandPrecautions");
                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbSeriousWarnings") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbSeriousWarnings"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (swp.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("SeriousWarningsandPrecautions");
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
                    XmlNodeList xnode = doc.GetElementsByTagName("SeriousWarningsandPrecautions");
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
                //lblError.Text = error.ToString();
                return null;
            }

            helpers.Processes.ValidateAndSave(doc, rootnode, "AdditionalWarning", "", tbAdditionalwarnings.Value, false);

            #region Warnings and Precautions Headings
            try
            {
                XmlNodeList wph = doc.GetElementsByTagName("WarningHeadings");
                ArrayList headingddarray = new ArrayList();
                ArrayList headingtxtarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("dlHeadings") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbHeadings") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("dlHeadings"))
                    {
                        headingddarray.Add(swpitem);
                    }
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbHeadings"))
                    {
                        headingtxtarray.Add(swpitem);
                    }
                }

                if (wph.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("WarningHeadings");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    wph[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("WarningHeadings");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
               // lblError.Text = error.ToString();
                return null;
            }
            #endregion
            #endregion
            #region Dosage and administration
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("DosageConsiderations");
                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbDosageConsiderations") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbDosageConsiderations"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (swp.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DosageConsiderations");
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
                    XmlNodeList xnode = doc.GetElementsByTagName("DosageConsiderations");
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
              //  lblError.Text = error.ToString();
                return null;
            }
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageAdjustment", "", tbDosageAdjustment.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageMissed", "", tbDosageMissed.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageAdministration", "", tbDosageAdministration.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageReconstitution", "", tbDosageReconstitution.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageOral", "", tbDosageOral.Value, false);
            try
            {
                #region DosageParenteralProducts
                XmlNodeList roa = doc.GetElementsByTagName("DosageParenteralProducts");

                var vialArray = new ArrayList();
                var volumeArray = new ArrayList();
                var approximateArray = new ArrayList();
                var nominaArray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbVial") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbVolume") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbApproximate") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbNominal") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbVial"))
                    {
                        vialArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbVolume"))
                    {
                        volumeArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbApproximate"))
                    {
                        approximateArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbNominal"))
                    {
                        nominaArray.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DosageParenteralProducts");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < vialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = vialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = volumeArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approximateArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = nominaArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("DosageParenteralProducts");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < vialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = vialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = volumeArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approximateArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = nominaArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
               // lblError.Text = error.ToString();
                return null;
            }
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "Overdosage", "", tbOverdosage.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MechanismAction", "", tbMechanismAction.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Pharmacodynamics", "", tbPharmacodynamics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialPopulationsConditions", "", tbSpecialPopulationsConditions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StorageStability", "", tbStorageStability.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialHandling", "", tbSpecialHandling.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageCompositionPackaging", "", tbDosageCompositionPackaging.Value, false);

            SessionHelper.Current.draftForm = doc;
            return doc;
        }

        private void LoadFromXML()
        {
            XmlDocument xmldoc = SessionHelper.Current.draftForm;
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);
            #region RouteOfAdmin
            XmlNodeList roa = xmldoc.GetElementsByTagName("RouteOfAdministration");
            if (roa.Count > 0)
            {
                var rows = from row in doc.Root.Elements("RouteOfAdministration").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                //bool ran = false;
                int rowcounter = 0;
                foreach (var row in rows)
                {
                    string[] colarray = "tbRouteOfAdminDynamic;tbDosageFormDynamic;tbStrengthDynamic;tbClinicallyRelevant".Split(';');
                    int colcounter = 0;
                    if (rowcounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbRouteOfAdminDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('route').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbRouteOfAdminDynamic option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else if (colarray[colcounter].Equals("tbDosageFormDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbDosageFormDynamic option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddRouteOfAdminTextBox('dataTable1');";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbRouteOfAdminDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('route').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbRouteOfAdminDynamic" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else if (colarray[colcounter].Equals("tbDosageFormDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbDosageFormDynamic" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                             }
                            colcounter++;
                        }
                    }
                    rowcounter++;
                }                         
            }
            #endregion
            #region Contraindications
            XmlNodeList con = xmldoc.GetElementsByTagName("Contraindications");
            if (con.Count > 0)
            {
                var rowsC = from rowcont in doc.Root.Elements("Contraindications").Descendants("row")
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
                        string[] colarray = "tbContraindications".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddContraindications();";
                        string[] colarray = "tbContraindications".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                    }

                    rowcounterC++;
                }                
            }
            #endregion
            #region Warnings and precautions
            XmlNodeList swp = xmldoc.GetElementsByTagName("SeriousWarningsandPrecautions");
            if (swp.Count > 0)
            {
                var rowsC = from rowcont in doc.Root.Elements("SeriousWarningsandPrecautions").Descendants("row")
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
                        string[] colarray = "tbSeriousWarnings".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddSeriousWarnings();";
                        string[] colarray = "tbSeriousWarnings".Split(';');
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                    }
                    rowcounterC++;
                }
            }

            XmlNodeList wph = xmldoc.GetElementsByTagName("WarningHeadings");
            if (wph.Count > 0)
            {
                #region Headings
                var rowsH = from rowcont in doc.Root.Elements("WarningHeadings").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int rowcounterH = 0;
                foreach (var row in rowsH)
                {
                    string[] colarray = "dlHeadings;tbHeadings".Split(';');
                    int colcounter = 0;
                    if (rowcounterH == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                  "$(xmlcontolledlist).find('warning').each(function () {" +
                                                      "var $option = $(this).text();" +
                                                      "$('<option>' + $option + '</option>').appendTo('#dlHeadings');" +
                                                  "});" +
                                                  "}).done(function () {" +
                                                      "$('#dlHeadings option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                  "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddHeadings();";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                   "$(xmlcontolledlist).find('warning').each(function () {" +
                                                       "var $option = $(this).text();" +
                                                       "$('<option>' + $option + '</option>').appendTo('#dlHeadings" + rowcounterH.ToString() + "');" +
                                                   "});" +
                                                   "}).done(function () {" +
                                                       "$('#dlHeadings" + rowcounterH.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                   "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                   rowcounterH++;
                }
                #endregion
            }
            #endregion
            #region DosageAdministration
            XmlNodeList dosage = xmldoc.GetElementsByTagName("DosageConsiderations");
            if (dosage.Count > 0)
            {
                #region DosageConsiderations
                var rowsC = from rowcont in doc.Root.Elements("DosageConsiderations").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    string[] colarray = "tbDosageConsiderations".Split(';');
                    if (!ranC)
                    {
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddDosageConsiderations();";
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

            XmlNodeList dpp = xmldoc.GetElementsByTagName("DosageParenteralProducts");
            if (dpp.Count > 0)
            {
                #region Headings
                var dppRows = from rowcont in doc.Root.Elements("DosageParenteralProducts").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int dppRowCounter = 0;
                foreach (var row in dppRows)
                {
                    string[] colarray = "tbVial;tbVolume;tbApproximate;tbNominal".Split(';');
                    int colcounter = 0;
                    if (dppRowCounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddParenteralProducts('dataTable2');";
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + dppRowCounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    dppRowCounter++;
                }
                #endregion
            }
            #endregion
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              BrandNameIndicatedFor = (string)item.Element("BrandNameIndicatedFor"),
                              GeriatricsAge = (string)item.Element("GeriatricsAge"),
                              Geriatrics = (string)item.Element("Geriatrics"),
                              PediatricsAgeX = (string)item.Element("PediatricsAgeX"),
                              PediatricsAgeY = (string)item.Element("PediatricsAgeY"),
                              PediatricsAgeZ = (string)item.Element("PediatricsAgeZ"),
                              Pediatrics = (string)item.Element("Pediatrics"),
                              AdditionalWarning = (string)item.Element("AdditionalWarning"),
                              DosageAdjustment = (string)item.Element("DosageAdjustment"),
                              DosageMissed = (string)item.Element("DosageMissed"),
                              DosageAdministration = (string)item.Element("DosageAdministration"),
                              DosageReconstitution = (string)item.Element("DosageReconstitution"),
                              DosageOral = (string)item.Element("DosageOral"),
                              Overdosage = (string)item.Element("Overdosage"),
                              MechanismAction = (string)item.Element("MechanismAction"),
                              Pharmacodynamics = (string)item.Element("Pharmacodynamics"),
                              SpecialPopulationsConditions = (string)item.Element("SpecialPopulationsConditions"),
                              StorageStability = (string)item.Element("StorageStability"),
                              SpecialHandling = (string)item.Element("SpecialHandling"),
                              DosageCompositionPackaging = (string)item.Element("DosageCompositionPackaging"),
                              AdverseReactions = (string)item.Element("AdverseReactions"),
                              DrugInteractions = (string)item.Element("DrugInteractions"),
                              SeriousDrugInteractions = (string)item.Element("SeriousDrugInteractions"),
                          };
            foreach (var xmldataitem in xmldata)
            {
                tbbrandName.Value = xmldataitem.BrandNameIndicatedFor;
                tbGeriatricsAge.Value = xmldataitem.GeriatricsAge;
                tbGeriatrics.Value = xmldataitem.Geriatrics;
                tbPediatricsAgeX.Value = xmldataitem.PediatricsAgeX;
                tbPediatricsAgeY.Value = xmldataitem.PediatricsAgeY;
                tbPediatricsAgeZ.Value = xmldataitem.PediatricsAgeZ;
                tbPediatrics.Value = xmldataitem.Pediatrics;
                tbAdditionalwarnings.Value = xmldataitem.AdditionalWarning;
                tbDosageAdministration.Value = xmldataitem.DosageAdministration;
                tbDosageReconstitution.Value = xmldataitem.DosageReconstitution;
                tbDosageOral.Value = xmldataitem.DosageOral;
                tbDosageMissed.Value = xmldataitem.DosageMissed;
                tbDosageAdjustment.Value = xmldataitem.DosageAdjustment;
                tbOverdosage.Value = xmldataitem.Overdosage;
                tbMechanismAction.Value = xmldataitem.MechanismAction;
                tbPharmacodynamics.Value = xmldataitem.Pharmacodynamics;
                tbSpecialPopulationsConditions.Value = xmldataitem.SpecialPopulationsConditions;
                tbStorageStability.Value = xmldataitem.StorageStability;
                tbSpecialHandling.Value = xmldataitem.SpecialHandling;
                tbDosageCompositionPackaging.Value = xmldataitem.DosageCompositionPackaging;
                tbAdverseReactions.Value = xmldataitem.AdverseReactions;
                tbDrugInteractions.Value = xmldataitem.DrugInteractions;
                tbSeriousDrugInteractions.Value = xmldataitem.SeriousDrugInteractions;
            }
        }
    }
}

