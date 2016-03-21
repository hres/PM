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
    public partial class PartOne : System.Web.UI.Page
    {
        string strscript = string.Empty;
        string strBrandName = string.Empty;
        string strProperName = string.Empty;
        void Page_PreInit(Object sender, EventArgs e)
        {
            //retrieve culture information from session
            string culture = Convert.ToString(Session["SelectedLanguage"]);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);

            if (Session["masterpage"] != null)
            {
                this.MasterPageFile = (String)Session["masterpage"];

            }
            if (Session["savedFilename"] != null)
            {
                strBrandName = (String)Session["savedFilename"];
            }
            if (Session["properName"] != null)
            {
                strProperName = (String)Session["properName"];
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
            facilityResourcePart1();
        }

        private void SaveProcess()
        {
            string strSaveFileName = string.Empty;
            string strXmlExtension = ".xml";
            string strZipExtension = ".zip";
            try
            {
                XmlDocument doc = SaveInMemory();

                if (doc == null)
                    return;

                #region zip
                byte[] bytes = Encoding.Default.GetBytes(doc.OuterXml);

                using (var compressedFileStream = new MemoryStream())
                {
                    using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Update, true))
                    {
                        if (doc != null)
                        {
                            if (strBrandName.Length > 0)
                            {
                                strSaveFileName = strBrandName + strXmlExtension;
                            }
                            else
                            {
                                strSaveFileName = "DraftPMForm" + strXmlExtension;
                            }

                            var zipEntry = zipArchive.CreateEntry(strSaveFileName);
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
                    strSaveFileName = string.Empty;
                    if (strBrandName.Length > 0)
                    {
                        strSaveFileName = strBrandName + strZipExtension;
                    }
                    else
                    {
                        strSaveFileName = "DraftPMForm" + strZipExtension;
                    }
                    if (buffer.Length > 0)
                    {
                        Response.ContentType = "application/zip";
                        Response.BinaryWrite(buffer);
                        var fileName = strSaveFileName;
                        Response.AddHeader("content-disposition", string.Format(@"attachment;filename=""{0}""", fileName));
                        Response.Flush();
                        Response.End();
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
            }

        }

        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
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
                    HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevantNonmedicinalIngredientsDynamic") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbRouteOfAdminDynamic"))
                    {
                        routearray.Add(routeitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbDosageFormDynamic"))
                    {
                        dosagearray.Add(dosageitem);
                    }
                    foreach (string strengthDynamicItem in HttpContext.Current.Request.Form.GetValues("tbStrengthDynamic"))
                    {
                        strengtharray.Add(strengthDynamicItem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevantNonmedicinalIngredientsDynamic"))
                    {
                        ingredientsarray.Add(ingredientitem);
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
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "BrandNameIndicatedFor", "", tbBrandNameIndicatedFor.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "ICUGeriatrics", "", tbICUGeriatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "GeriatricXvalue", "", tbGeriatricXvalue.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "ICUPediatrics", "", tbICUPediatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsXvalue", "", tbPediatricsXvalue.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsYvalue", "", tbPediatricsYvalue.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "YrsofAgeValue", "", tbYrsofAgeValue.Value, false);
            

            #region Contraindications
            try
            {
                XmlNodeList con = doc.GetElementsByTagName("Contraindications");

                ArrayList contraarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbContraindicationsDynamic") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbContraindicationsDynamic"))
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
                lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region Serious Warnings and Precautions
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("SeriousWarningsandPrecautions");

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
                lblError.Text = error.ToString();
                return null; 
            }
            #endregion

            #region Warnings and Precautions Headings
            try
            {
                XmlNodeList wph = doc.GetElementsByTagName("WarningsandPrecautionsHeadings");

                ArrayList headingddarray = new ArrayList();
                ArrayList headingtxtarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("ddHeadingSelections") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbddHeadingSelections") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("ddHeadingSelections"))
                    {
                        headingddarray.Add(swpitem);
                    }

                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbddHeadingSelections"))
                    {
                        headingtxtarray.Add(swpitem);
                    }
                }

                if (wph.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("WarningsandPrecautionsHeadings");
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

                    XmlNodeList xnode = doc.GetElementsByTagName("WarningsandPrecautionsHeadings");
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
                lblError.Text = error.ToString();
                return null;
            }
            #endregion
            //ching adds new value of Additional Warning
            #region Additional Warnings in section of Warnings and Precautions
            try
            {
                XmlNodeList listAdditionalWarn = doc.GetElementsByTagName("AdditionalWarning");

                ArrayList arrayAdditionalWarn = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbAdditionalWarning") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbAdditionalWarning"))
                    {
                        arrayAdditionalWarn.Add(swpitem);
                    }
                }

                if (listAdditionalWarn.Count < 1)
                {
                    if (arrayAdditionalWarn.Count > 0)
                    {
                        XmlNode xnodeW = doc.CreateElement("AdditionalWarning");
                        rootnode.AppendChild(xnodeW);

                        for (int ar = 0; ar < arrayAdditionalWarn.Count; ar++)
                        {
                            XmlNode subnodeW = doc.CreateElement("row");
                            xnodeW.AppendChild(subnodeW);

                            string colW1 = arrayAdditionalWarn[ar].ToString();
                            XmlNode subsubnodeW = doc.CreateElement("column");
                            subsubnodeW.AppendChild(doc.CreateTextNode(colW1));
                            subnodeW.AppendChild(subsubnodeW);
                        }
                    }
                }
                else
                {
                    listAdditionalWarn[0].RemoveAll();

                    XmlNodeList xnodeW2 = doc.GetElementsByTagName("AdditionalWarning");
                    rootnode.AppendChild(xnodeW2[0]);

                    for (int ar2 = 0; ar2 < arrayAdditionalWarn.Count; ar2++)
                    {
                        XmlNode subnodeW2 = doc.CreateElement("row");
                        xnodeW2[0].AppendChild(subnodeW2);

                        string col1W2 = arrayAdditionalWarn[ar2].ToString();
                        XmlNode subsubnodeW2 = doc.CreateElement("column");
                        subsubnodeW2.AppendChild(doc.CreateTextNode(col1W2));
                        subnodeW2.AppendChild(subsubnodeW2);
                    }
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdditionalWarning", "", tbAdditionalWarning.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseDrugReactOverview", "", tbAdverseDrugReactOverview.Value, false);

            #region Adverse Reactions
            int NumberOfSections = 0;
            if (HttpContext.Current.Request.Form.GetValues("lblSelectedHeader") != null)
            {
                NumberOfSections = HttpContext.Current.Request.Form.GetValues("lblSelectedHeader").Length;


                ArrayList headerlabelsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeader"))
                {
                    headerlabelsarray.Add(itemvalue);
                }

                ArrayList headerdescsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeader"))
                {
                    headerdescsarray.Add(itemvalue);
                }

                ArrayList bottomdescarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderDesc"))
                {
                    bottomdescarray.Add(itemvalue);
                }

                ArrayList tableindexarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderCount"))
                {
                    tableindexarray.Add(itemvalue);
                }

                ArrayList tablenumberarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("nmTableNumber"))
                {
                    tablenumberarray.Add(itemvalue);
                }

                ArrayList tablevaluerarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbTableText"))
                {
                    tablevaluerarray.Add(itemvalue);
                }

                XmlNodeList adv = doc.GetElementsByTagName("AdverseReactions");

                string lblSelectedHeader = "";

                string tbSelectedHeader = "";

                string[,] AdverseReactionsArray = null;

                string tbSelectedHeaderDesc = "";

                string nmTableNumber = "";

                string tbTableText = "";

                try
                {
                    if (adv.Count < 1)
                    {
                        XmlNode xnode = doc.CreateElement("AdverseReactions"); 
                        rootnode.AppendChild(xnode); 

                        #region Inner table
                        for (int s = 1; s <= NumberOfSections; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode); //here

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
                            
                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex) != null)
                            {
                                AdverseReactionsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwo" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOne" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwo" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrative" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < AdverseReactionsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }                            

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
                            subnode.AppendChild(subsubnode);
                        }
                        #endregion

                    }
                    else
                    {
                        adv[0].RemoveAll();

                        XmlNodeList xnode = doc.GetElementsByTagName("AdverseReactions");
                        rootnode.AppendChild(xnode[0]);

                        #region Inner table
                        for (int s = 1; s <= NumberOfSections; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode); //here

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
                            
                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex) != null)
                            {
                                AdverseReactionsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOne" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwo" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOne" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwo" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrative" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    AdverseReactionsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }



                                for (int m = 0; m < AdverseReactionsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(AdverseReactionsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }                            

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
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
                //remove AdverseReactions child nodes
                XmlNodeList adv = doc.GetElementsByTagName("AdverseReactions");
                if (adv.Count > 0)
                    adv[0].RemoveAll();
            }
            #endregion      

            #region Drug Interactions
            int NumberOfSectionsDrugInt = 0;
            if (HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderDrugInt") != null)
            {
                NumberOfSectionsDrugInt = HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderDrugInt").Length;

                ArrayList headerlabelsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderDrugInt"))
                {
                    headerlabelsarray.Add(itemvalue);
                }

                //ArrayList headerdescsarray = new ArrayList();
                //foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeader"))
                //{
                //    headerdescsarray.Add(itemvalue);
                //}

                ArrayList bottomdescarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderDescDrugInt"))
                {
                    bottomdescarray.Add(itemvalue);
                }

                ArrayList tableindexarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderCountDrugInt"))
                {
                    tableindexarray.Add(itemvalue);
                }

                ArrayList tablenumberarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("nmTableNumberDrugInt"))
                {
                    tablenumberarray.Add(itemvalue);
                }

                ArrayList tablevaluerarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbTableTextDrugInt"))
                {
                    tablevaluerarray.Add(itemvalue);
                }

                XmlNodeList dint = doc.GetElementsByTagName("DrugInteractions");

                string lblSelectedHeader = "";

                //string tbSelectedHeader = "";

                string[,] DrugInteractionsArray = null;

                string tbSelectedHeaderDesc = "";

                string nmTableNumber = "";

                string tbTableText = "";

                try
                {
                    if (dint.Count < 1)
                    {
                        XmlNode xnode = doc.CreateElement("DrugInteractions"); //here
                        rootnode.AppendChild(xnode); //here

                        #region Inner table
                        for (int s = 1; s <= NumberOfSectionsDrugInt; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            //tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode); //here

                            XmlNode subsubnode = doc.CreateElement("title");
                            subsubnode.AppendChild(doc.CreateTextNode(lblSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            //subsubnode = doc.CreateElement("desc");
                            //subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeader));
                            //subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblnumber");
                            subsubnode.AppendChild(doc.CreateTextNode(nmTableNumber));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblvalue");
                            subsubnode.AppendChild(doc.CreateTextNode(tbTableText));
                            subnode.AppendChild(subsubnode);

                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex) != null)
                            {
                                DrugInteractionsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOneDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativeDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }




                                for (int m = 0; m < DrugInteractionsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
                            subnode.AppendChild(subsubnode);
                        }
                        #endregion

                    }
                    else
                    {
                        dint[0].RemoveAll();

                        XmlNodeList xnode = doc.GetElementsByTagName("DrugInteractions");
                        rootnode.AppendChild(xnode[0]);

                        #region Inner table
                        for (int s = 1; s <= NumberOfSectionsDrugInt; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            //tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode); //here

                            XmlNode subsubnode = doc.CreateElement("title");
                            subsubnode.AppendChild(doc.CreateTextNode(lblSelectedHeader));
                            subnode.AppendChild(subsubnode);

                            //subsubnode = doc.CreateElement("desc");
                            //subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeader));
                            //subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblnumber");
                            subsubnode.AppendChild(doc.CreateTextNode(nmTableNumber));
                            subnode.AppendChild(subsubnode);

                            subsubnode = doc.CreateElement("tblvalue");
                            subsubnode.AppendChild(doc.CreateTextNode(tbTableText));
                            subnode.AppendChild(subsubnode);

                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex) != null)
                            {
                                DrugInteractionsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOneDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOneDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativeDrugInt" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    DrugInteractionsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < DrugInteractionsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(DrugInteractionsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
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
                //remove AdverseReactions child nodes
                XmlNodeList dint = doc.GetElementsByTagName("DrugInteractions");
                if (dint.Count > 0)
                    dint[0].RemoveAll();
            }           
            #endregion

            #region Serious Drug Interactions
            //try
            //{
            //    XmlNodeList sdi = doc.GetElementsByTagName("SeriousDrugInteractions");

            //    ArrayList srsdiaarray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("tbSeriousDrugInteractions") != null)
            //    {
            //        foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbSeriousDrugInteractions"))
            //        {
            //            srsdiaarray.Add(routeitem);
            //        }
            //    }

            //    if (sdi.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("SeriousDrugInteractions");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < srsdiaarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = srsdiaarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        sdi[0].RemoveAll();

            //        XmlNodeList xnode = doc.GetElementsByTagName("SeriousDrugInteractions");
            //        rootnode.AppendChild(xnode[0]);

            //        for (int ar = 0; ar < srsdiaarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = srsdiaarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //    lblError.Text = error.ToString();
            //    return null;
            //}
            #endregion

            //helpers.Processes.ValidateAndSave(doc, rootnode, "DrugOverview", "", tbDrugOverview.Value, false);

            #region DrugDrugInteractions
            //try
            //{
            //    XmlNodeList ddi = doc.GetElementsByTagName("DrugDrugInteractions");

            //    ArrayList propernamearray = new ArrayList();
            //    ArrayList referencearray = new ArrayList();
            //    ArrayList effectarray = new ArrayList();
            //    ArrayList clinicalcommentarray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("tbPropername") != null &&
            //        HttpContext.Current.Request.Form.GetValues("tbReference") != null &&
            //        HttpContext.Current.Request.Form.GetValues("tbEffect") != null &&
            //        HttpContext.Current.Request.Form.GetValues("tbClinicalcomment") != null)
            //    {
            //        foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbPropername"))
            //        {
            //            propernamearray.Add(routeitem);
            //        }
            //        foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbReference"))
            //        {
            //            referencearray.Add(dosageitem);
            //        }
            //        foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbEffect"))
            //        {
            //            effectarray.Add(ingredientitem);
            //        }
            //        foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbClinicalcomment"))
            //        {
            //            clinicalcommentarray.Add(ingredientitem);
            //        }
            //    }

            //    if (ddi.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("DrugDrugInteractions");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < propernamearray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = propernamearray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = referencearray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);

            //            string col3 = effectarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col3));
            //            subnode.AppendChild(subsubnode);

            //            string col4 = clinicalcommentarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col4));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        ddi[0].RemoveAll();

            //        XmlNodeList xnode = doc.GetElementsByTagName("DrugDrugInteractions");
            //        rootnode.AppendChild(xnode[0]);

            //        for (int ar = 0; ar < propernamearray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = propernamearray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = referencearray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);

            //            string col3 = effectarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col3));
            //            subnode.AppendChild(subsubnode);

            //            string col4 = clinicalcommentarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col4));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //    lblError.Text = error.ToString();
            //    return null;
            //}
            #endregion

            #region HerbLabLife Interactions
            //try
            //{
            //    XmlNodeList hllfi = doc.GetElementsByTagName("HerbLabLifeDrugInteractions");

            //    ArrayList drugintarray = new ArrayList();
            //    ArrayList drugintddarray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("ddDrugInteractions") != null &&
            //        HttpContext.Current.Request.Form.GetValues("tbddDrugInteractions") != null)
            //    {
            //        foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("ddDrugInteractions"))
            //        {
            //            drugintarray.Add(swpitem);
            //        }

            //        foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbddDrugInteractions"))
            //        {
            //            drugintddarray.Add(swpitem);
            //        }
            //    }

            //    if (hllfi.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("HerbLabLifeDrugInteractions");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < drugintarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = drugintarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = drugintddarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        hllfi[0].RemoveAll();

            //        XmlNodeList xnode = doc.GetElementsByTagName("HerbLabLifeDrugInteractions");
            //        rootnode.AppendChild(xnode[0]);

            //        for (int ar = 0; ar < drugintarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = drugintarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = drugintddarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //    lblError.Text = error.ToString();
            //    return null;
            //}
            #endregion

            #region Dosing Considerations
            try
            {
                XmlNodeList doco = doc.GetElementsByTagName("DosingConsiderations");

                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbDosingConsiderations") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbDosingConsiderations"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (doco.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DosingConsiderations");
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
                    doco[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("DosingConsiderations");
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

            helpers.Processes.ValidateAndSave(doc, rootnode, "DrugRecommendedDose", "", tbRecommendedDose.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DrugMissedDose", "", tbMissedDose.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DrugAdministration", "", tbAdministration.Value, false);

            helpers.Processes.ValidateAndSave(doc, rootnode, "OralSolutions", "", tbOralSolutions.Value, false);

            #region Parenteral Products
            try
            {
                XmlNodeList pps = doc.GetElementsByTagName("ParenteralProducts");

                ArrayList vsarray = new ArrayList();
                ArrayList dfsdarray = new ArrayList();
                ArrayList approxavarray = new ArrayList();
                ArrayList ncarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbVialSize") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbVolumeOfDiluent") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbApproxAvailable") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbNominalConcentration") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbVialSize"))
                    {
                        vsarray.Add(routeitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbVolumeOfDiluent"))
                    {
                        dfsdarray.Add(dosageitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbApproxAvailable"))
                    {
                        approxavarray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbNominalConcentration"))
                    {
                        ncarray.Add(ingredientitem);
                    }
                }

                if (pps.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("ParenteralProducts");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < vsarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = vsarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dfsdarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approxavarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ncarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    pps[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("ParenteralProducts");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < vsarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = vsarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dfsdarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approxavarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ncarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
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

            helpers.Processes.ValidateAndSave(doc, rootnode, "Overdosage", "", tbOverdosage.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MechanismOfAction", "", tbMechanismOfAction.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Pharmacodynamics", "", tbPharmacodynamics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AntiInfectiveDescription", "", tbAntiInfectiveDescription.Value, false);

            #region Pharmacokinetics
            int NumberOfSectionsPharmacokinetics = 0;
            if (HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderPharmacokinetics") != null)
            {
                NumberOfSectionsPharmacokinetics = HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderPharmacokinetics").Length;

                ArrayList headerlabelsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderPharmacokinetics"))
                {
                    headerlabelsarray.Add(itemvalue);
                }

                ArrayList headerdescsarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderPharmacokinetics"))
                {
                    headerdescsarray.Add(itemvalue);
                }

                ArrayList bottomdescarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbSelectedHeaderDescPharmacokinetics"))
                {
                    bottomdescarray.Add(itemvalue);
                }

                ArrayList tableindexarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("lblSelectedHeaderCountPharmacokinetics"))
                {
                    tableindexarray.Add(itemvalue);
                }

                ArrayList tablenumberarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("nmTableNumberPharmacokinetics"))
                {
                    tablenumberarray.Add(itemvalue);
                }

                ArrayList tablevaluerarray = new ArrayList();
                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbTableTextPharmacokinetics"))
                {
                    tablevaluerarray.Add(itemvalue);
                }

                XmlNodeList phk = doc.GetElementsByTagName("Pharmacokinetics");

                string lblSelectedHeader = "";

                string tbSelectedHeader = "";

                string[,] PharmacokineticsArray = null;

                string tbSelectedHeaderDesc = "";

                string nmTableNumber = "";

                string tbTableText = "";

                try
                {
                    if (phk.Count < 1)
                    {
                        XmlNode xnode = doc.CreateElement("Pharmacokinetics"); //here
                        rootnode.AppendChild(xnode); //here

                        #region Inner table
                        for (int s = 1; s <= NumberOfSectionsPharmacokinetics; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode.AppendChild(subnode); //here

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

                            //subsubnode = doc.CreateElement("tables");
                            //subnode.AppendChild(subsubnode);

                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex) != null)
                            {
                                PharmacokineticsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoPharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOnePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoPharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < PharmacokineticsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
                            subnode.AppendChild(subsubnode);
                        }
                        #endregion

                    }
                    else
                    {
                        phk[0].RemoveAll();

                        XmlNodeList xnode = doc.GetElementsByTagName("Pharmacokinetics");
                        rootnode.AppendChild(xnode[0]);

                        #region Inner table
                        for (int s = 1; s <= NumberOfSectionsPharmacokinetics; s++)
                        {
                            int incrementingindex = int.Parse(tableindexarray[s - 1].ToString());

                            lblSelectedHeader = headerlabelsarray[s - 1].ToString();

                            tbSelectedHeader = headerdescsarray[s - 1].ToString();

                            nmTableNumber = tablenumberarray[s - 1].ToString();

                            tbTableText = tablevaluerarray[s - 1].ToString();

                            tbSelectedHeaderDesc = bottomdescarray[s - 1].ToString();

                            XmlNode subnode = doc.CreateElement("row");
                            xnode[0].AppendChild(subnode); //here

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

                            //subsubnode = doc.CreateElement("tables");
                            //subnode.AppendChild(subsubnode);

                            if (HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex) != null)
                            {
                                PharmacokineticsArray = new string[5, HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex).Length];

                                int arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadOnePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[0, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbHeadTwoPharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[1, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyOnePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[2, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbBodyTwoPharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[3, arrayindex] = oo;
                                    arrayindex++;
                                }

                                arrayindex = 0;
                                foreach (string itemvalue in HttpContext.Current.Request.Form.GetValues("tbNarrativePharmacokinetics" + incrementingindex))
                                {
                                    string oo = itemvalue;
                                    PharmacokineticsArray[4, arrayindex] = oo;
                                    arrayindex++;
                                }

                                for (int m = 0; m < PharmacokineticsArray.Length / 5; m++)
                                {
                                    XmlNode tablenode = doc.CreateElement("table");
                                    subnode.AppendChild(tablenode);

                                    XmlNode itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[0, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[1, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[2, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[3, m]));
                                    tablenode.AppendChild(itemnode);

                                    itemnode = doc.CreateElement("item");
                                    itemnode.AppendChild(doc.CreateTextNode(PharmacokineticsArray[4, m]));
                                    tablenode.AppendChild(itemnode);

                                }
                            }

                            subsubnode = doc.CreateElement("summary");
                            subsubnode.AppendChild(doc.CreateTextNode(tbSelectedHeaderDesc));
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
                //remove AdverseReactions child nodes
                XmlNodeList phk = doc.GetElementsByTagName("Pharmacokinetics");
                if (phk.Count > 0)
                    phk[0].RemoveAll();
            }
            #endregion      

            #region Pharmacokinetic Parameters
            try
            {
                XmlNodeList knt = doc.GetElementsByTagName("PharmacokineticParameters");

                ArrayList cmaxarray = new ArrayList();
                ArrayList thalfarray = new ArrayList();
                ArrayList aucoarray = new ArrayList();
                ArrayList cleararray = new ArrayList();
                ArrayList distcarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbCmax") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbtHalfH") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbAUCOFour") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbClearance") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbVolumeDistribution") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbCmax"))
                    {
                        cmaxarray.Add(routeitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbtHalfH"))
                    {
                        thalfarray.Add(dosageitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbAUCOFour"))
                    {
                        aucoarray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbClearance"))
                    {
                        cleararray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbVolumeDistribution"))
                    {
                        distcarray.Add(ingredientitem);
                    }
                }

                if (knt.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("PharmacokineticParameters");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < cmaxarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = cmaxarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = thalfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = aucoarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = cleararray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = distcarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    knt[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("PharmacokineticParameters");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < cmaxarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = cmaxarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = thalfarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = aucoarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = cleararray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = distcarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
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

            #region Pharmacokinetics Pharmacology
            //try
            //{
            //    XmlNodeList pharm = doc.GetElementsByTagName("PharmacokineticsPharmacology");

            //    ArrayList drugintarray = new ArrayList();
            //    ArrayList drugintddarray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("ddPharmacokinetics") != null &&
            //        HttpContext.Current.Request.Form.GetValues("tbddPharmacokinetics") != null)
            //    {
            //        foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("ddPharmacokinetics"))
            //        {
            //            drugintarray.Add(swpitem);
            //        }

            //        foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbddPharmacokinetics"))
            //        {
            //            drugintddarray.Add(swpitem);
            //        }
            //    }

            //    if (pharm.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("PharmacokineticsPharmacology");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < drugintarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = drugintarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = drugintddarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        pharm[0].RemoveAll();

            //        XmlNodeList xnode = doc.GetElementsByTagName("PharmacokineticsPharmacology");
            //        rootnode.AppendChild(xnode[0]);

            //        for (int ar = 0; ar < drugintarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = drugintarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);

            //            string col2 = drugintddarray[ar].ToString();
            //            subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col2));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //    lblError.Text = error.ToString();
            //    return null;
            //}
            #endregion

            #region special Population and Condition in section of Action and clinical pharmacology
            try
            {
                XmlNodeList listSpecialPopu = doc.GetElementsByTagName("SpecialPopulationAndCondition");

                ArrayList arraySpecialPopu = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbSpecialPopuCondition") != null)
                {
                    foreach (string spcitem in HttpContext.Current.Request.Form.GetValues("tbSpecialPopuCondition"))
                    {
                        arraySpecialPopu.Add(spcitem);
                    }
                }

                if (listSpecialPopu.Count < 1)
                {
                    if (arraySpecialPopu.Count > 0)
                    {
                        XmlNode xnodeP = doc.CreateElement("SpecialPopulationAndCondition");
                        rootnode.AppendChild(xnodeP);

                        for (int ar = 0; ar < arraySpecialPopu.Count; ar++)
                        {
                            XmlNode subnodeP = doc.CreateElement("row");
                            xnodeP.AppendChild(subnodeP);

                            string colP1 = arraySpecialPopu[ar].ToString();
                            XmlNode subsubnodeP = doc.CreateElement("column");
                            subsubnodeP.AppendChild(doc.CreateTextNode(colP1));
                            subnodeP.AppendChild(subsubnodeP);
                        }
                    }
                }
                else
                {

                    listSpecialPopu[0].RemoveAll();

                    XmlNodeList xnodeP2 = doc.GetElementsByTagName("SpecialPopulationAndCondition");
                    rootnode.AppendChild(xnodeP2[0]);

                    for (int ar2 = 0; ar2 < arraySpecialPopu.Count; ar2++)
                    {
                        XmlNode subnodeP2 = doc.CreateElement("row");
                        xnodeP2[0].AppendChild(subnodeP2);

                        string col1P2 = arraySpecialPopu[ar2].ToString();
                        XmlNode subsubnodeP2 = doc.CreateElement("column");
                        subsubnodeP2.AppendChild(doc.CreateTextNode(col1P2));
                        subnodeP2.AppendChild(subsubnodeP2);
                    }
                }
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
                return null;
            }
            #endregion
            //ching add new value of Special Population And Condition
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialPopulationAndCondition", "", tbSpecialPopuCondition.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StorageAndStability", "", tbStorageStability.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialHandling", "", tbSpecialHandling.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageFormsComposition", "", tbDosageFormsComposition.Value, false);
                        
         
            Session["draft"] = doc;

            return doc;
        }

        private void LoadFromXML()
        {
            XmlDocument xmldoc = (XmlDocument)Session["draft"]; 
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);

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
                  
                    string[] colarray = "tbBrandName;tbProperName;tbDosage;tbStrengthValue;tbStrengthUnit;tbStrengthperDosageValue;tbStrengthperDosageUnit".Split(';');
                    int colcounter = 0;
                    foreach (string column in row.columns)
                    {
                        if (colarray[colcounter].Equals("tbBrandName"))
                        {
                            //ching add code here
                            if (column != null)
                            {
                                lblProprietaryBrandName.Text = helpers.Processes.CleanString(column);
                                lblBrandName.Text = helpers.Processes.CleanString(column);
                                strBrandName = helpers.Processes.CleanString(column);  
                            }
                            else
                            {
                                if(strBrandName != null)
                                {
                                    lblProprietaryBrandName.Text = strBrandName;
                                    lblBrandName.Text = strBrandName;
                                }
                               else
                                   strBrandName = "DraftPMForm";  
                            }
                          
                        }

                        if (colarray[colcounter].Equals("tbProperName"))
                        {
                            //ching add code here
                            if (column != null)
                            {
                                lblProperName.Text = helpers.Processes.CleanString(column);
                                lblICProperName.Text = helpers.Processes.CleanString(column);
                            }
                            else
                            {
                                if(strProperName != null)
                                {
                                    lblProperName.Text = strProperName;
                                    lblICProperName.Text = strProperName;
                                }
                                else
                                {
                                    lblProperName.Text = Resources.Resource.lblProperName;
                                    lblICProperName.Text = Resources.Resource.lblProperName;
                                }
                               
                                
                            }
                           
                        }

                        colcounter++;
                    }

                    break;                    
                }
                #endregion
            }

            XmlNodeList roa = xmldoc.GetElementsByTagName("RouteOfAdministration");
            if (roa.Count > 0)
            {
                #region RouteOfAdmin
                var rows = from row in doc.Root.Elements("RouteOfAdministration").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                //bool ran = false;
                int rowcounter = 1;

                foreach (var row in rows)
                {
                    strscript += "AddRouteOfAdminTextBoxLoadFromXML();";

                    string[] colarray = "tbRouteOfAdminDynamic;tbDosageFormDynamic;tbStrengthDynamic;tbClinicallyRelevantNonmedicinalIngredientsDynamic".Split(';');
                    int colcounter = 0;
                    foreach (string column in row.columns)
                    {
                        if (colarray[colcounter].Equals("tbRouteOfAdminDynamic"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                            "$(xmlcontolledlist).find('route').each(function () {" +
                                                "var $option = $(this).text();" +
                                                "$('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic" + rowcounter + "');" +
                                            "});" +
                                            "}).done(function () {" +
                                                "$('#tbRouteOfAdminDynamic" + rowcounter + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                            "});";
                        }
                        else if (colarray[colcounter].Equals("tbDosageFormDynamic"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                            "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                "var $option = $(this).text();" +
                                                "$('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic" + rowcounter + "');" +
                                            "});" +
                                            "}).done(function () {" +
                                                "$('#tbDosageFormDynamic" + rowcounter + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                            "});";
                        }
                        else 
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                        }
                        colcounter++;
                    }

                    rowcounter++;
                }
                #endregion
            }

            XmlNodeList con = xmldoc.GetElementsByTagName("Contraindications");
            if (con.Count > 0)
            {
                #region Contraindications
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
                        string[] colarray = "tbContraindicationsDynamic".Split(';');
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
                        strscript += "AddContraindicationsTextBox();";

                        string[] colarray = "tbContraindicationsDynamic".Split(';');
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

            XmlNodeList swp = xmldoc.GetElementsByTagName("SeriousWarningsandPrecautions");
            if (swp.Count > 0)
            {
                #region Serious Warnings and Precautions
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

            XmlNodeList wph = xmldoc.GetElementsByTagName("WarningsandPrecautionsHeadings");
            if (wph.Count > 0)
            {
                #region Warnings and Precautions Headings
                var rowsH = from rowcont in doc.Root.Elements("WarningsandPrecautionsHeadings").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int rowcounterH = 1;

                foreach (var rowH in rowsH)
                {
                    strscript += "AddHeadingSelectionLoadFromXML();";

                    string[] colarray = "ddHeadingSelections;tbddHeadingSelections".Split(';');
                    int colcounter = 0;
                    foreach (string columnH in rowH.columns)
                    {
                        if (colarray[colcounter].Equals("ddHeadingSelections"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                        "$(xmlcontolledlist).find('warning').each(function () {" +
                                            "var $option = $(this).text();" +
                                            //"$('<option>' + $option + '</option>').appendTo('#dlheadingselections" + rowcounterH + "');" +
                                            "if ($option == \"Pregnant Women\" || $option == \"Nursing Women\" || $option == \"Pediatrics (x - y years of age)\" || $option == \"Geriatrics (> x years of age)\" || $option == \"Monitoring and Laboratory Tests\")" +
                                            "{" +
                                                "$('<option label=\"' + \"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\" + $option + '\" value=\"' + $option + '\"/>').appendTo('#dlheadingselections" + rowcounterH + "');" +
                                            "}" +
                                            "else" +
                                            "{" +
                                                "$('<option label=\"' + $option + '\" value=\"' + $option + '\"/>').appendTo('#dlheadingselections" + rowcounterH + "');" +
                                            "}" +
                                        "});" +
                                        "}).done(function () {" +                                            
                                            "$('#ddHeadingSelections" + rowcounterH + "').val('" + columnH + "');" +
                                        "});";
                        }

                        if (colarray[colcounter].Equals("tbddHeadingSelections"))
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                        }

                        colcounter++;
                    }

                    rowcounterH++;
                }
                #endregion
            }

            XmlNodeList adv = xmldoc.GetElementsByTagName("AdverseReactions");
            if (adv.Count > 0)
            {
                #region AdverseReactions
                var arsections = from rows in doc.Root.Elements("AdverseReactions").Descendants("row")
                            select new
                            {                               
                                title = rows.Element("title").Value,                             
                                desc = rows.Element("desc").Value,
                                tblnumbers = rows.Element("tblnumber").Value,
                                tblvalues = rows.Element("tblvalue").Value,        
                                tables = rows.Elements("table"), 
                                summary = rows.Element("summary").Value
                            };

                int sectioncounter = 1;
                int tblcounter = 1;
                foreach (var arsection in arsections)
                {
                    strscript += "AddAdverseReactionsOuterSection();";

                    string t = arsection.title;
                    strscript += "$('#lblSelectedHeader" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(t) + "\");";
                    strscript += "$('#lblSelectedHeaderCount" + sectioncounter.ToString() + "').val(\"" + sectioncounter + "\");";

                    string d = arsection.desc;
                    strscript += "$('#tbSelectedHeader" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(d) + "\");";

                    string tn = arsection.tblnumbers;
                    strscript += "$('#nmTableNumber" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tn) + "\");";

                    string tv = arsection.tblvalues;
                    strscript += "$('#tbTableText" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tv) + "\");";

                    
                    foreach (var table in arsection.tables)
                    {
                        strscript += "AddAdverseReactionsInnerTextBox(" + sectioncounter.ToString() + ");";

                        int fixindex = 0;
                        foreach (var item in table.Elements("item"))
                        {
                            //if (fixindex == 0)
                            //{
                            //    string tableitems = item.Value;
                            //    strscript += "$('#nmTableNumber" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            //}

                            //if (fixindex == 1)
                            //{
                            //    string tableitems = item.Value;
                            //    strscript += "$('#tbTableText" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            //}

                            if (fixindex == 0)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadOne" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 1)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadTwo" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 2)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyOne" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 3)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyTwo" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 4)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbNarrative" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            fixindex++;
                        }

                        tblcounter++;
                    }

                    string s = arsection.summary;  
                    strscript += "$('#tbSelectedHeaderDesc" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(s) + "\");";

                    sectioncounter++;
                }
                #endregion
            }

            XmlNodeList dint = xmldoc.GetElementsByTagName("DrugInteractions");
            if (dint.Count > 0)
            {
                #region Drug Interactions
                var arsections = from rows in doc.Root.Elements("DrugInteractions").Descendants("row")
                                 select new
                                 {
                                     title = rows.Element("title").Value,
                                     //desc = rows.Element("desc").Value,
                                     tblnumbers = rows.Element("tblnumber").Value,
                                     tblvalues = rows.Element("tblvalue").Value,
                                     tables = rows.Elements("table"),
                                     summary = rows.Element("summary").Value
                                 };

                int sectioncounter = 1;
                int tblcounter = 1;
                foreach (var arsection in arsections)
                {
                    strscript += "AddDrugInteractionsOuterSection();";

                    string t = arsection.title;
                    strscript += "$('#lblSelectedHeaderDrugInt" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(t) + "\");";
                    strscript += "$('#lblSelectedHeaderCountDrugInt" + sectioncounter.ToString() + "').val(\"" + sectioncounter + "\");";

                    //string d = arsection.desc;
                    //strscript += "$('#tbSelectedHeader" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(d) + "\");";

                    string tn = arsection.tblnumbers;
                    strscript += "$('#nmTableNumberDrugInt" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tn) + "\");";

                    string tv = arsection.tblvalues;
                    strscript += "$('#tbTableTextDrugInt" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tv) + "\");";


                    foreach (var table in arsection.tables)
                    {
                        strscript += "AddDrugInteractionsInnerTextBox(" + sectioncounter.ToString() + ");";

                        int fixindex = 0;
                        foreach (var item in table.Elements("item"))
                        {
                            if (fixindex == 0)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadOneDrugInt" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 1)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbHeadTwoDrugInt" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 2)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyOneDrugInt" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 3)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbBodyTwoDrugInt" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            if (fixindex == 4)
                            {
                                string tableitems = item.Value;
                                strscript += "$('#tbNarrativeDrugInt" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                            }

                            fixindex++;
                        }

                        tblcounter++;
                    }

                    string s = arsection.summary;
                    strscript += "$('#tbSelectedHeaderDescDrugInt" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(s) + "\");";

                    sectioncounter++;
                }
                #endregion
            }

            XmlNodeList ctadr = xmldoc.GetElementsByTagName("ClinicalTrialAdverseDrugReactions");
            if (ctadr.Count > 0)
            {
                #region Clinical Trial Adverse Drug Reactions
                //var rowsH = from rowcont in doc.Root.Elements("ClinicalTrialAdverseDrugReactions").Descendants("row")
                //            select new
                //            {
                //                columns = from column in rowcont.Elements("column")
                //                          select (string)column
                //            };

                //bool ranH = false;
                //int rowcounterH = 0;

                //foreach (var rowH in rowsH)
                //{
                //    if (!ranH)
                //    {
                //        string[] colarray = "ddCTADrugReactions;tbCTADrugReactionsDrugname;tbCTADrugReactionsPlacebo".Split(';');
                //        int colcounter = 0;
                //        foreach (string columnH in rowH.columns)
                //        {
                //            if (colarray[colcounter].Equals("ddCTADrugReactions"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                //                             ".append($(\"<option selected='selected'></option>\")" +
                //                             ".attr('value', '" + columnH + "')" +
                //                             ".text('" + columnH + "'));";
                //            }
                //            else
                //            //if (colarray[colcounter].Equals("tbCTADrugReactionsDrugname"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                //            }

                //            colcounter++;
                //        }

                //        ranH = true;
                //    }
                //    else
                //    {
                //        strscript += "AddCTADrugReactions();";

                //        string[] colarray = "ddCTADrugReactions;tbCTADrugReactionsDrugname;tbCTADrugReactionsPlacebo".Split(';');
                //        int colcounter = 0;
                //        foreach (string columnH in rowH.columns)
                //        {
                //            if (colarray[colcounter].Equals("ddCTADrugReactions"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                //                             ".append($(\"<option selected='selected'></option>\")" +
                //                             ".attr('value', '" + columnH + "')" +
                //                             ".text('" + columnH + "'));";
                //            }
                //            else
                //            //if (colarray[colcounter].Equals("tbddHeadingSelections"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                //            }

                //            colcounter++;
                //        }
                //    }

                //    rowcounterH++;
                //}
                #endregion
            }

            XmlNodeList sdi = xmldoc.GetElementsByTagName("SeriousDrugInteractions");
            if (sdi.Count > 0)
             {
                 #region Serious Drug Interactions
                 var rowsC = from rowcont in doc.Root.Elements("SeriousDrugInteractions").Descendants("row")
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
                         string[] colarray = "tbSeriousDrugInteractions".Split(';');
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
                         strscript += "AddSeriousDrugInteractionsTextBox();";

                         string[] colarray = "tbSeriousDrugInteractions".Split(';');
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

            XmlNodeList ddi = xmldoc.GetElementsByTagName("DrugDrugInteractions");
            if (ddi.Count > 0)
            {
                #region Drug-Drug Interactions
                var rows = from row in doc.Root.Elements("DrugDrugInteractions").Descendants("row")
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
                        string[] colarray = "tbPropername;tbReference;tbEffect;tbClinicalcomment".Split(';');
                        int colcounter = 0;
                        foreach (string column in row.columns)
                        {
                            //strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val('" + column + "');";
                            strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }

                        ran = true;
                    }
                    else
                    {
                        strscript += "AddDrugDrugInteractionsTextBox();";

                        string[] colarray = "tbPropername;tbReference;tbEffect;tbClinicalcomment".Split(';');
                        int colcounter = 0;
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

            XmlNodeList hlldi = xmldoc.GetElementsByTagName("HerbLabLifeDrugInteractions");
             if (hlldi.Count > 0)
             {
                 #region HerbLabLife Interactions
                 var rowsH = from rowcont in doc.Root.Elements("HerbLabLifeDrugInteractions").Descendants("row")
                             select new
                             {
                                 columns = from column in rowcont.Elements("column")
                                           select (string)column
                             };

                 bool ranH = false;
                 int rowcounterH = 0;

                 foreach (var rowH in rowsH)
                 {
                     if (!ranH)
                     {
                         string[] colarray = "ddDrugInteractions;tbddDrugInteractions".Split(';');
                         int colcounter = 0;
                         foreach (string columnH in rowH.columns)
                         {
                             if (colarray[colcounter].Equals("ddDrugInteractions"))
                             {
                                 strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                                              ".append($(\"<option selected='selected'></option>\")" +
                                              ".attr('value', '" + columnH + "')" +
                                              ".text('" + columnH + "'));";
                             }

                             if (colarray[colcounter].Equals("tbddDrugInteractions"))
                             {
                                 strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                             }

                             colcounter++;
                         }

                         ranH = true;
                     }
                     else
                     {
                         strscript += "AddDrugInteractions();";

                         string[] colarray = "ddDrugInteractions;tbddDrugInteractions".Split(';');
                         int colcounter = 0;
                         foreach (string columnH in rowH.columns)
                         {
                             if (colarray[colcounter].Equals("ddDrugInteractions"))
                             {
                                 strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                                              ".append($(\"<option selected='selected'></option>\")" +
                                              ".attr('value', '" + columnH + "')" +
                                              ".text('" + columnH + "'));";
                             }

                             if (colarray[colcounter].Equals("tbddDrugInteractions"))
                             {
                                 strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                             }

                             colcounter++;
                         }
                     }

                     rowcounterH++;
                 }
                 #endregion
             }

             XmlNodeList doco = xmldoc.GetElementsByTagName("DosingConsiderations");
             if (doco.Count > 0)
             {
                 #region Dosing Considerations
                 var rowsC = from rowcont in doc.Root.Elements("DosingConsiderations").Descendants("row")
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
                         string[] colarray = "tbDosingConsiderations".Split(';');
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
                         strscript += "AddDosingConsiderationsTextBox();";

                         string[] colarray = "tbDosingConsiderations".Split(';');
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

             XmlNodeList pps = xmldoc.GetElementsByTagName("ParenteralProducts");
             if (pps.Count > 0)
            {
                #region Parenteral Products
                var rows = from row in doc.Root.Elements("ParenteralProducts").Descendants("row")
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
                        string[] colarray = "tbVialSize;tbVolumeOfDiluent;tbApproxAvailable;tbNominalConcentration".Split(';');
                        int colcounter = 0;
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }

                        ran = true;
                    }
                    else
                    {
                        strscript += "AddParenteralProductsTextBox();";

                        string[] colarray = "tbVialSize;tbVolumeOfDiluent;tbApproxAvailable;tbNominalConcentration".Split(';');
                        int colcounter = 0;
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

             XmlNodeList phk = xmldoc.GetElementsByTagName("Pharmacokinetics");
             if (phk.Count > 0)
             {
                 #region Pharmacokinetics
                 var arsections = from rows in doc.Root.Elements("Pharmacokinetics").Descendants("row")
                                  select new
                                  {
                                      title = rows.Element("title").Value,
                                      desc = rows.Element("desc").Value,
                                      tblnumbers = rows.Element("tblnumber").Value,
                                      tblvalues = rows.Element("tblvalue").Value,
                                      tables = rows.Elements("table"),
                                      summary = rows.Element("summary").Value
                                  };

                 int sectioncounter = 1;
                 int tblcounter = 1;
                 foreach (var arsection in arsections)
                 {
                     strscript += "AddPharmacokineticsOuterSection();";

                     string t = arsection.title;
                     strscript += "$('#lblSelectedHeaderPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(t) + "\");";
                     strscript += "$('#lblSelectedHeaderCountPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + sectioncounter + "\");";

                     string d = arsection.desc;
                     strscript += "$('#tbSelectedHeaderPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(d) + "\");";

                     string tn = arsection.tblnumbers;
                     strscript += "$('#nmTableNumberPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tn) + "\");";

                     string tv = arsection.tblvalues;
                     strscript += "$('#tbTableTextPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(tv) + "\");";


                     foreach (var table in arsection.tables)
                     {
                         strscript += "AddPharmacokineticsInnerTextBox(" + sectioncounter.ToString() + ");";

                         int fixindex = 0;
                         foreach (var item in table.Elements("item"))
                         {
                             if (fixindex == 0)
                             {
                                 string tableitems = item.Value;
                                 strscript += "$('#tbHeadOnePharmacokinetics" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                             }

                             if (fixindex == 1)
                             {
                                 string tableitems = item.Value;
                                 strscript += "$('#tbHeadTwoPharmacokinetics" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                             }

                             if (fixindex == 2)
                             {
                                 string tableitems = item.Value;
                                 strscript += "$('#tbBodyOnePharmacokinetics" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                             }

                             if (fixindex == 3)
                             {
                                 string tableitems = item.Value;
                                 strscript += "$('#tbBodyTwoPharmacokinetics" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                             }

                             if (fixindex == 4)
                             {
                                 string tableitems = item.Value;
                                 strscript += "$('#tbNarrativePharmacokinetics" + sectioncounter + "_" + tblcounter + "').val(\"" + helpers.Processes.CleanString(tableitems) + "\");";
                             }

                             fixindex++;
                         }

                         tblcounter++;
                     }

                     string s = arsection.summary;
                     strscript += "$('#tbSelectedHeaderDescPharmacokinetics" + sectioncounter.ToString() + "').val(\"" + helpers.Processes.CleanString(s) + "\");";

                     sectioncounter++;
                 }
                 #endregion
             }

             XmlNodeList phkp = xmldoc.GetElementsByTagName("PharmacokineticParameters");
            if (phkp.Count > 0)
            {
                #region Pharmacokinetic Parameters
                //var krows = from row in doc.Root.Elements("PharmacokineticParameters").Descendants("row")
                //            select new
                //            {
                //                columns = from column in row.Elements("column")
                //                          select (string)column
                //            };

                //bool kran = false;
                //int krowcounter = 0;

                //foreach (var krow in krows)
                //{
                //    if (!kran)
                //    {
                //        string[] kcolarray = "tbCmax;tbtHalfH;tbAUCOFour;tbClearance;tbVolumeDistribution".Split(';');
                //        int kcolcounter = 0;
                //        foreach (string kcolumn in krow.columns)
                //        {                            
                //            strscript += "$('#" + kcolarray[kcolcounter] + krowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(kcolumn) + "\");";
                //            kcolcounter++;
                //        }

                //        kran = true;
                //    }
                //    else
                //    {
                //        strscript += "AddPharmacokineticParametersTextBox();";

                //        string[] kcolarray = "tbCmax;tbtHalfH;tbAUCOFour;tbClearance;tbVolumeDistribution".Split(';');
                //        int kcolcounter = 0;
                //        foreach (string kcolumn in krow.columns)
                //        {
                //            strscript += "$('#" + kcolarray[kcolcounter] + krowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(kcolumn) + "\");";
                //            kcolcounter++;
                //        }
                //    }

                //    krowcounter++;
                //}
                #endregion
            }

            XmlNodeList pharmcoPharm = xmldoc.GetElementsByTagName("PharmacokineticsPharmacology");
            if (pharmcoPharm.Count > 0)
            {
                #region Pharmacokinetics Pharmacology
                //var rowsH = from rowcont in doc.Root.Elements("PharmacokineticsPharmacology").Descendants("row")
                //            select new
                //            {
                //                columns = from column in rowcont.Elements("column")
                //                          select (string)column
                //            };

                //bool ranH = false;
                //int rowcounterH = 0;

                //foreach (var rowH in rowsH)
                //{
                //    if (!ranH)
                //    {
                //        string[] colarray = "ddPharmacokinetics;tbddPharmacokinetics".Split(';');
                //        int colcounter = 0;
                //        foreach (string columnH in rowH.columns)
                //        {
                //            if (colarray[colcounter].Equals("ddPharmacokinetics"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                //                             ".append($(\"<option selected='selected'></option>\")" +
                //                             ".attr('value', '" + columnH + "')" +
                //                             ".text('" + columnH + "'));";
                //            }

                //            if (colarray[colcounter].Equals("tbddPharmacokinetics"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                //            }

                //            colcounter++;
                //        }

                //        ranH = true;
                //    }
                //    else
                //    {
                //        strscript += "AddPharmacokinetics();";

                //        string[] colarray = "ddPharmacokinetics;tbddPharmacokinetics".Split(';');
                //        int colcounter = 0;
                //        foreach (string columnH in rowH.columns)
                //        {
                //            if (colarray[colcounter].Equals("ddPharmacokinetics"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "')" +
                //                             ".append($(\"<option selected='selected'></option>\")" +
                //                             ".attr('value', '" + columnH + "')" +
                //                             ".text('" + columnH + "'));";
                //            }

                //            if (colarray[colcounter].Equals("tbddPharmacokinetics"))
                //            {
                //                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(columnH) + "\");";
                //            }

                //            colcounter++;
                //        }
                //    }

                //    rowcounterH++;
                //}
                #endregion
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              BrandNameIndicatedFor = (string)item.Element("BrandNameIndicatedFor"),
                              //BriefDiscussionReleClin = (string)item.Element("BriefDiscussionReleClin"),
                              //DistributionRestrict = (string)item.Element("DistributionRestrict"),
                              //WhenTheProdNotRecom = (string)item.Element("WhenTheProdNotRecom"),
                              ICUGeriatrics = (string)item.Element("ICUGeriatrics"),
                              GeriatricXvalue = (string)item.Element("GeriatricXvalue"),
                              ICUPediatrics = (string)item.Element("ICUPediatrics"),
                              PediatricsXvalue = (string)item.Element("PediatricsXvalue"),
                              PediatricsYvalue = (string)item.Element("PediatricsYvalue"),
                              YrsofAgeValue = (string)item.Element("YrsofAgeValue"),

                              AdverseDrugReactOverview = (string)item.Element("AdverseDrugReactOverview"),
                              ClinicalTrialAdverseDrugReact = (string)item.Element("ClinicalTrialAdverseDrugReact"),

                              ClinicalTrialAdverseDrugReactCardiovascular = (string)item.Element("ClinicalTrialAdverseDrugReactCardiovascular"),
                              ClinicalTrialAdverseDrugReactDigestive = (string)item.Element("ClinicalTrialAdverseDrugReactDigestive"),
                              ClinicalTrialAdverseDrugReactGastrointestinal = (string)item.Element("ClinicalTrialAdverseDrugReactGastrointestinal"),
                              ClinicalTrialAdverseDrugReactAbnormalHematologic = (string)item.Element("ClinicalTrialAdverseDrugReactAbnormalHematologic"),
                              ClinicalTrialAdverseDrugReactPMAdverseDrug = (string)item.Element("ClinicalTrialAdverseDrugReactPMAdverseDrug"),

                              DrugOverview = (string)item.Element("DrugOverview"),
                              DrugRecommendedDose = (string)item.Element("DrugRecommendedDose"),
                              DrugMissedDose = (string)item.Element("DrugMissedDose"),
                              DrugAdministration = (string)item.Element("DrugAdministration"),

                              OralSolutions = (string)item.Element("OralSolutions"),
                              Overdosage = (string)item.Element("Overdosage"),
                              MechanismOfAction = (string)item.Element("MechanismOfAction"),
                              Pharmacodynamics = (string)item.Element("Pharmacodynamics"),
                              AntiInfectiveDescription = (string)item.Element("AntiInfectiveDescription"),

                              StorageAndStability = (string)item.Element("StorageAndStability"),
                              SpecialHandling = (string)item.Element("SpecialHandling"),
                              DosageFormsComposition = (string)item.Element("DosageFormsComposition"),
                              AdditionalWarning = (string)item.Element("AdditionalWarning"),
                              SpecialPopuCondition = (string)item.Element("SpecialPopulationAndCondition")
                          };

            foreach (var xmldataitem in xmldata)
            {
                tbBrandNameIndicatedFor.Value = xmldataitem.BrandNameIndicatedFor;
                tbICUGeriatrics.Value = xmldataitem.ICUGeriatrics;
                tbGeriatricXvalue.Value = xmldataitem.GeriatricXvalue;
                tbICUPediatrics.Value = xmldataitem.ICUPediatrics;
                tbPediatricsXvalue.Value = xmldataitem.PediatricsXvalue;
                tbPediatricsYvalue.Value = xmldataitem.PediatricsYvalue;
                tbYrsofAgeValue.Value = xmldataitem.YrsofAgeValue;

                tbAdverseDrugReactOverview.Value = xmldataitem.AdverseDrugReactOverview;
                //tbClinicalTrialAdverseDrugReact.Value = xmldataitem.ClinicalTrialAdverseDrugReact;

                //tbCardiovascular.Value = xmldataitem.ClinicalTrialAdverseDrugReactCardiovascular;
                //tbDigestive.Value = xmldataitem.ClinicalTrialAdverseDrugReactDigestive;
                //tbGastrointestinal.Value = xmldataitem.ClinicalTrialAdverseDrugReactGastrointestinal;
                //tbAbnormalHematologic.Value = xmldataitem.ClinicalTrialAdverseDrugReactAbnormalHematologic;
                //tbPMAdverseDrug.Value = xmldataitem.ClinicalTrialAdverseDrugReactPMAdverseDrug;

               // tbDrugInteractionsOverview.Value = xmldataitem.DrugOverview;
                tbRecommendedDose.Value = xmldataitem.DrugRecommendedDose;
                tbMissedDose.Value = xmldataitem.DrugMissedDose;
                tbAdministration.Value = xmldataitem.DrugAdministration;
                tbOralSolutions.Value = xmldataitem.OralSolutions;

                if (xmldataitem.Overdosage == null)
                {
                    tbOverdosage.Value = "For management of a suspected drug overdose, contact your regional Poison Control Centre.";
                }
                else
                {
                    tbOverdosage.Value = xmldataitem.Overdosage;
                }

                
                tbMechanismOfAction.Value = xmldataitem.MechanismOfAction;
                tbPharmacodynamics.Value = xmldataitem.Pharmacodynamics;
                tbAntiInfectiveDescription.Value = xmldataitem.AntiInfectiveDescription;

                tbStorageStability.Value = xmldataitem.StorageAndStability;
                tbSpecialHandling.Value = xmldataitem.SpecialHandling;
                tbDosageFormsComposition.Value = xmldataitem.DosageFormsComposition;
                tbAdditionalWarning.Value = xmldataitem.AdditionalWarning;
                tbSpecialPopuCondition.Value = xmldataitem.SpecialPopuCondition;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveProcess();
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
        protected void facilityResourcePart1()
        {
            //top menu
            submenutabs.Items[0].Text = Resources.Resource.subMenuItem1;
            submenutabs.Items[1].Text = Resources.Resource.subMenuItem2;
            submenutabs.Items[2].Text = Resources.Resource.subMenuItem3;
            submenutabs.Items[3].Text = Resources.Resource.subMenuItem4;
            submenutabs.Items[4].Text = Resources.Resource.subMenuItem5;

            submenutabs.Items[0].ToolTip = Resources.Resource.subMenuItem1_tooltip;
            submenutabs.Items[1].ToolTip = Resources.Resource.subMenuItem2;
            submenutabs.Items[2].ToolTip = Resources.Resource.subMenuItem3;
            submenutabs.Items[3].ToolTip = Resources.Resource.subMenuItem4;
            submenutabs.Items[4].ToolTip = Resources.Resource.subMenuItem5;
            //bottom menu
            submenutabsbottom.Items[0].Text = Resources.Resource.subMenuItem1;
            submenutabsbottom.Items[1].Text = Resources.Resource.subMenuItem2;
            submenutabsbottom.Items[2].Text = Resources.Resource.subMenuItem3;
            submenutabsbottom.Items[3].Text = Resources.Resource.subMenuItem4;
            submenutabsbottom.Items[4].Text = Resources.Resource.subMenuItem5;

            submenutabsbottom.Items[0].ToolTip = Resources.Resource.subMenuItem1_tooltip;
            submenutabsbottom.Items[1].ToolTip = Resources.Resource.subMenuItem2;
            submenutabsbottom.Items[2].ToolTip = Resources.Resource.subMenuItem3;
            submenutabsbottom.Items[3].ToolTip = Resources.Resource.subMenuItem4;
            submenutabsbottom.Items[4].ToolTip = Resources.Resource.subMenuItem5;

            btnSaveDraftPart1.Text = Resources.Resource.btnSaveDraft;
            btnSaveDraftPart1.ToolTip = Resources.Resource.btnSaveDraft_tooltip;

            lblPartITitle.Text = Resources.Resource.lblPartITitle;
           // lblBrandName.Text = Resources.Resource.lblBrandName;
            //  lblBrandName3.Text = Resources.Resource.lblBrandName;

           // lblProprietaryProperName.Text = Resources.Resource.lblProperName;
            SumSummaryProductInformation.InnerText = Resources.Resource.SumSummaryProductInformation;
            SUM_INDICATIONS.InnerText = Resources.Resource.SUM_INDICATIONS;
            SUM_CONTRAINDICATIONS.InnerText = Resources.Resource.SUM_CONTRAINDICATIONS;

            SUM_WARNINGS.InnerText = Resources.Resource.SUM_WARNINGS;
            SUM_ADVERSE.InnerText = Resources.Resource.SUM_ADVERSE;
            SUM_DRUG_INTERACTIONS.InnerText = Resources.Resource.SUM_DRUG_INTERACTIONS;
            SUM_DOSAGE.InnerText = Resources.Resource.SUM_DOSAGE;
            SUM_OVERDOSAGE.InnerText = Resources.Resource.SUM_OVERDOSAGE;
            SUM_SPECIAL_HANDLING.InnerText = Resources.Resource.SUM_SPECIAL_HANDLING;
            SUM_STORAGE.InnerText = Resources.Resource.SUM_STORAGE;
            SUM_ACTION.InnerText = Resources.Resource.SUM_ACTION;
            SUM_DOSAGEFORMS.InnerText = Resources.Resource.SUM_DOSAGEFORMS;
            SUM_Special_Popu_Condition.InnerText = Resources.Resource.SUM_Special_Popu_Condition;

            //lblDosageForm2.Text = Resources.Resource.lblDosageForm2;
            //lblStrength2.Text = Resources.Resource.tbStrength;
            //lblIngredients.Text = Resources.Resource.lblIngredients;
            lblGeriatrics.Text = Resources.Resource.lblGeriatrics;
            lblYearsOfAge.Text = Resources.Resource.lblYearsOfAge;
            lblPediatrics.Text = Resources.Resource.lblPediatrics;
            lblYearsOfAgeOr.Text = Resources.Resource.lblYearsOfAgeOr;
            lblYearsOfAge2.Text = Resources.Resource.lblYearsOfAge2;
            lblContraindications.Text = Resources.Resource.lblContraindications;
            lblRouteOfAdministration.Text = Resources.Resource.lblRouteOfAdministration;
            lblSerious.Text = Resources.Resource.lblSerious;
            lblAdministration.Text = Resources.Resource.lblAdministration;
            lblReconstitution.Text = Resources.Resource.lblReconstitution;
            lblAdverse.Text = Resources.Resource.lblAdverse;
            lblOverview.Text = Resources.Resource.lblOverview;

            //btnAddExtraContraindications.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddExtraSeriousWarningsPrecautions.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddPharmacokineticsOuterSection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddParenteralProducts.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddExtraDosingConsiderations.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddPharmacokineticsOuterSection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddDrugInteractionsOuterSection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddAdverseReactionsOuterSection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddExtraAddHeadingSelection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddExtraRouteOfAdmin.Value = Resources.Resource.btnAddExtraContraindications;
            //btnAddExtraAddHeadingSelection.Value = Resources.Resource.btnAddExtraContraindications;
            //btnRemoveContraindications.Value = Resources.Resource.btnRemoveVal;
            //btnRemoveSeriousWarningsPrecautions.Value = Resources.Resource.btnRemoveVal;
            //btnRemoveDosingConsiderations.Value = Resources.Resource.btnRemoveVal;

            lblHeadings.Text = Resources.Resource.lblHeadings;
            lblStorage.Text = Resources.Resource.lblStorage;
            lblSpecialHandling.Text = Resources.Resource.lblSpecialHandling;
            lblDosageForms.Text = Resources.Resource.lblDosageForms;
            lblRecommended.Text = Resources.Resource.lblRecommended;
            lblAnySpecific.Text = Resources.Resource.lblAnySpecific;
            lblOverdosage.Text = Resources.Resource.SUM_OVERDOSAGE;
            lblForAnti.Text = Resources.Resource.lblForAnti;
            lblMechanism.Text = Resources.Resource.lblMechanism;
            lblPharmacodynamics.Text = Resources.Resource.lblPharmacodynamics;
            lblDosing.Text = Resources.Resource.lblDosing;
            lblMissed.Text = Resources.Resource.lblMissed;
            lblOral.Text = Resources.Resource.lblOral;
            lblIsIndicatedFor.Text = Resources.Resource.lblIsIndicatedFor;
            lblForManagement.Text = Resources.Resource.lblForManagement;
            lblParenteralProducts.Text = Resources.Resource.lblParenteralProducts;
            lblAdditional.Text = Resources.Resource.lblAdditional;
            //lblVialSize.Text = Resources.Resource.lblVialSize;
            //lblVolume.Text = Resources.Resource.lblVolume;
            //lblApproximate.Text = Resources.Resource.lblApproximate;
            //lblNominal.Text = Resources.Resource.lblNominal;
        }
    }
}



//<div id="AdverseReactionsOuter0" style="width:90%; padding-left: 0px; clear:both; border:1px solid #D9D9D9; height:auto; display:none;">
//        <div style="width:40%; float:left; clear:both; border: 1px solid #D9D9D9; margin:4px;">
//            <input type="text" id="lblSelectedHeader0" name="lblSelectedHeader" readonly="true" style="width:95%"/>
//        </div>
//        <div style="width:100%; text-align:center; clear:both; text-align:left; border: 1px solid #D9D9D9;">                 
//            <textarea id="tbSelectedHeader0" name="tbSelectedHeader"></textarea>                            
//        </div>
//        <div id="AdverseReactionsInner0" style="width:100%; text-align:center; float:left; height:auto; padding-top:6px;">     
//            <div style="width:90%; float:left;">
//                <div style="width:100%; text-align:center; clear:both; text-align:center; border: 1px solid #D9D9D9; padding-top:6px;">
//                    Table&nbsp;<&nbsp;<input type="number" id="nmTableNumber0" name="nmTableNumber0" style="width:55px; text-align:center;"/>&nbsp;>&nbsp;:&nbsp;<&nbsp;<input type="text" id="tbTableText0" name="tbTableText0" style="width:55px; text-align:center;"/>&nbsp;>
//                </div>
//                <div style="width:100%; text-align:center; clear:both; text-align:center;">
//                    <div style="width:50%; float:left; border: 1px solid #D9D9D9;">
//                       <input type="text" id="tbHeadOne0" name="tbHeadOne0" style="width:95%; text-align:center; font-weight:bold;"/>
//                    </div>
//                    <div style="width:50%; float:left; border: 1px solid #D9D9D9;">
//                        <input type="text" id="tbHeadTwo0" name="tbHeadTwo0" style="width:95%; text-align:center; font-weight:bold;"/>
//                    </div>
//                </div>
//                <div style="width:100%; text-align:center; clear:both; text-align:center;">
//                    <div style="width:50%; float:left; border: 1px solid #D9D9D9;">
//                        <textarea id="tb0BodydOne0" name="tbBodydOne0"></textarea>
//                    </div>
//                    <div style="width:50%; float:left; border: 1px solid #D9D9D9;">                    
//                        <textarea id="tb0BodydTwo0" name="tbBodydTwo0"></textarea>
//                    </div>
//                </div>
//                <div style="width:100%; text-align:center; clear:both; text-align:center;">
//                    <textarea id="tb0Narrative0" name="tbNarrative0"></textarea>
//                </div>    
//            </div>
//            <div style="width:5%; float:left; padding-top:6px;">   
//                <div style="height:70px; width:70px;">
//                    <div style="float:left;">
//                        <img style="cursor:pointer !important;" src="images/plus_icon.png" onclick="AddAdverseReactionsInnerTextBox(0)" width="50" height="50" />                                                          
//                    </div>                
//                </div>
//            </div>          
//        </div>   
//        <div id="dvExtraAdverseReactionsInner0" style="width:100%; padding-left: 0px; clear:both;">
//        </div>    
//        <div style="width:100%; text-align:center; clear:both; text-align:center;">
//            <textarea id="tbSelectedHeaderDesc0" name="tbSelectedHeaderDesc"></textarea>
//        </div>
//    </div>




 //<option value="Clinical Trial Adverse Drug Reactions" style="width: 500px; height:40px;">Clinical Trial Adverse Drug Reactions</option>
 //           <option value="Description of data sources" style="width: 500px; height:40px;">Description of data sources</option>
 //           <option value="Relative Frequency of Adverse Drug Reactions" style="width: 500px; height:40px;">Relative Frequency of Adverse Drug Reactions</option>
 //           <option value="Less Common Clinical Trial Adverse Drug" style="width: 500px; height:40px;">Less Common Clinical Trial Adverse Drug</option>
 //           <option value="Abnormal Hematologic and Clinical Chemistry Findings" style="width: 500px; height:40px;">Abnormal Hematologic and Clinical Chemistry Findings</option>
 //           <option value="Post-Market Adverse Drug Reactions" style="width: 500px; height:40px;">Post-Market Adverse Drug Reactions</option>

//<option value="Drug-Drug Interactions" style="width: 500px; height:40px;">Drug-Drug Interactions</option>
//            <option value="Drug-Food Interactions" style="width: 500px; height:40px;">Drug-Food Interactions</option>
//            <option value="Drug-Herb Interactions" style="width: 500px; height:40px;">Drug-Herb Interactions</option>
//            <option value="Drug-Laboratory Interactions" style="width: 500px; height:40px;">Drug-Laboratory Interactions</option>
//            <option value="Drug-Lifestyle Interactions" style="width: 500px; height:40px;">Drug-Lifestyle Interactions</option>

//<option value="Absorption" style="width: 500px; height:40px;">Absorption</option>
//                <option value="Distribution" style="width: 500px; height:40px;">Distribution</option>
//                <option value="Metabolism" style="width: 500px; height:40px;">Metabolism</option>
//                <option value="Excretion" style="width: 500px; height:40px;">Excretion</option>


//<option value="Select">Select</option>
//                <option value="Carcinogenesis and Mutagenesis">Carcinogenesis and Mutagenesis</option>
//                <option value="Cardiovascular">Cardiovascular</option>
//                <option value="Dependence/Tolerance<">Dependence/Tolerance</option>
//                <option value="Ear/Nose/Throat">Ear/Nose/Throat</option>
//                <option value="Endocrine and Metabolism">Endocrine and Metabolism</option>
//                <option value="Gastrointestinal">Gastrointestinal</option>
//                <option value="Genitourinary">Genitourinary</option>
//                <option value="Hematologic">Hematologic</option>
//                <option value="Special Populations">Special Populations</option>
//                <option value="Pregnant Women">Pregnant Women</option>
//                <option value="Nursing Women">Nursing Women</option>
//                <option value="Pediatrics">Pediatrics (x - y years of age)</option>
//                <option value="Geriatrics">Geriatrics (> x years of age)</option>
//                <option value="Monitoring and Laboratory Tests">Monitoring and Laboratory Tests</option>



//<div id="RouteOfAdmin0" style="width:90%; padding-left: 0px; clear:both;">
//        <div style="width:23.5%; float:left;">      
//            <select id="tbRouteOfAdminDynamic0" name="tbRouteOfAdminDynamic" style="width:100%; height:38px;" ></select>              
//        </div>  
//        <div style="width:23.5%; float:left;">       
//             <select id="tbDosageFormDynamic0" name="tbDosageFormDynamic" style="width:100%; height:38px;" ></select>            
//        </div> 
//        <div style="width:23.5%; float:left;">
//            <textarea id="tbStrengthDynamic0" name="tbStrengthDynamic"></textarea>                
//        </div> 
//        <div style="width:23.5%; float:left;">
//            <textarea id="tbClinicallyRelevantNonmedicinalIngredientsDynamic0" name="tbClinicallyRelevantNonmedicinalIngredientsDynamic"></textarea>                
//        </div>  
//        <div style="width:5%; float:left; padding-left:2px;">
//            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveRouteOfAdminTextBox(0)" id="btnRemoveRouteOfAdmin" width="58" height="40" />                                                          
//        </div>  
////    </div>

//<div id="HeadingSelections0" style="width:90%; padding-left: 0px; clear:both;">
//        <div style="width:94%; float:left; border:1px solid #D9D9D9; padding: 4px 3px 4px 4px;">
//            <select name="ddHeadingSelections" id="ddHeadingSelections0" style="width: 320px; margin-bottom: 5px; clear:both;">
//            </select>
//            <textarea id="tbddHeadingSelections0" name="tbddHeadingSelections"></textarea>     
//        </div>  
//        <div style="width:5%; float:left; padding-left:0px;">
//            <img style="cursor:pointer !important;" src="images/btnRemove.png"  onclick="RemoveHeadingSelectionTextBox(0)" id="" width="58" height="40" />                                                          
//        </div> 
//    </div> 