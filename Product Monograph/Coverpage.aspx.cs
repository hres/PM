using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using System.Xml.Linq;
using System.Collections;
using Product_Monograph.helpers;
using System.Text;

namespace Product_Monograph
{
    public partial class Coverpage : BasePage
    {
        string strscript = string.Empty;
        protected static string sponsorName;
        protected static string schedulingSymbol;
        protected static string pharmaceuticalStandard;
        protected static string submissionControlNumber;
        protected static string therapeuticClassification;
        protected static string sponsorAddress;
        protected static string footnote;
        protected static string dateRevision;
        protected static string datePreparation;
        protected static string brandNameTitle;
        protected static string properNameTitle;
        protected static string dosageForm;
        protected static string strengthValue;
        protected static string strengthDosageValue;
        protected static string brandDosageForm;
        protected static string addButton;
        protected static string removeButton;
        protected static string resetButton;
        protected static string existXmlFile;
        protected static string brandNameHidden;

        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }

            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.coverPage;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.coverPage;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
          //  ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowStatus", "javascript:alert('Record is not updated');", true);
            if (!IsPostBack)
            {
                sponsorName = Resources.Resource.sponsorName;
                schedulingSymbol = Resources.Resource.schedulingSymbol;
                pharmaceuticalStandard = Resources.Resource.pharmaceuticalStandard;
                submissionControlNumber = Resources.Resource.submissionControlNumber;
                therapeuticClassification = Resources.Resource.therapeuticClassification;
                sponsorAddress = Resources.Resource.sponsorAddress;
                footnote = Resources.Resource.footnote;
                dateRevision = Resources.Resource.dateRevision;
                datePreparation = Resources.Resource.datePreparation;
                brandNameTitle = Resources.Resource.brandNameTitle;
                properNameTitle = Resources.Resource.properNameTitle;
                dosageForm = Resources.Resource.dosageForm;
                strengthValue = Resources.Resource.strengthValue;
                strengthDosageValue = Resources.Resource.strengthDosageValue;
                brandDosageForm = Resources.Resource.brandDosageForm;
                addButton = Resources.Resource.addButton;
                removeButton = Resources.Resource.removeButton;
                btnSaveDraft.Text = Resources.Resource.saveButton;
                btnSaveDraft.Attributes["Title"] = Resources.Resource.saveButtonTitle;
                resetButton = Resources.Resource.resetButton;

                try
                {
                   // if (ValidateXmlDoc())
                        LoadFromXML();

                    if (string.IsNullOrEmpty(SessionHelper.Current.brandName))
                    {
                        brandNameHidden = string.Empty;
                    }
                    else
                    {
                        this.brandName.Text = SessionHelper.Current.brandName;
                        brandNameHidden = SessionHelper.Current.brandName;
                    }
                    if (!string.IsNullOrEmpty(SessionHelper.Current.properName))
                    {
                        this.properName.Text = SessionHelper.Current.properName;
                    }

                    existXmlFile = SessionHelper.Current.existXmlFile.ToString();
                }
                catch
                {

                }
            }
        }
        //private bool ValidateXmlDoc()
        //{

        //    try
        //    {
        //        XmlDocument xmldoc = SessionHelper.Current.draftForm;
        //        if (xmldoc == null)  //maybe dameged, or not exist, or empty --- waiting for client requirements
        //        {
        //            return false;
        //        }
        //        else
        //        {
        //            if (xmldoc.ChildNodes[1].HasChildNodes == false)  //having two elements, but it still contains empty data, it is new XML file
        //            {
        //                return false;
        //            }
        //            else
        //            {
        //                return true;     //it is a xml file which was loaded by client 
        //            }

        //        }


        //    }
        //    catch (XmlException e)
        //    {
        //        //  lblError.Text = "No XMLDocument file to load: " + e.Message;  //project stops -- note by ching
        //        return false;
        //    }

        //}
        private void LoadFromXML()
        {
            XmlDocument xmldoc = SessionHelper.Current.draftForm;
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);

            XmlNodeList roa = xmldoc.GetElementsByTagName("BrandProperDosage");
            if (roa.Count > 0)
            {
                #region BrandProperDosage
                var rows = from row in doc.Root.Elements("BrandProperDosage").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                int rowcounter = 0;
                string strTemp = "tbBrandname;tbPropername;tbDosage;tbStrengthValue;tbStrengthUnit;tbStrengthperDosageValue;tbStrengthperDosageUnit";
                string[] colarray = null;
                foreach (var row in rows)
                {
                    int colcounter = 0;
                    colarray = strTemp.Split(';');
                    if (rowcounter > 0)
                    {
                        strscript += "addRow('dataTable');";
                    }
                    foreach (string column in row.columns)
                    {
                        if (colarray[colcounter].Equals("tbDosage"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                            "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                "var $option = $(this).text();" +
                                                "$('<option>' + $option + '</option>').appendTo('#tbDosage" + rowcounter.ToString() + "');" +
                                            "});" +
                                            "}).done(function () {" +
                                                "$('#tbDosage" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                            "});";
                        }
                        else if (colarray[colcounter].Equals("tbStrengthUnit"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('unit').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbStrengthUnit" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbStrengthUnit" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                        }
                        else if (colarray[colcounter].Equals("tbStrengthperDosageUnit"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('unit').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbStrengthperDosageUnit" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                        }
                        else
                        {
                            if (rowcounter == 0)
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                                if (colcounter == 0)
                                {
                                    SessionHelper.Current.brandName = helpers.Processes.CleanString(column);
                                }
                                else if (colcounter == 1)
                                {
                                    SessionHelper.Current.properName = helpers.Processes.CleanString(column);
                                }
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                        }

                        colcounter++;
                    }
                    rowcounter++;
                }
                #endregion
            }

            //followings are elements under root node
            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              SchedulingSymbol = (string)item.Element("SchedulingSymbol"),
                              SchedulingSymbolImageName = (string)item.Element("SchedulingSymbolImageName"),
                              SchedulingSymbolImageData = (string)item.Element("SchedulingSymbolImageData"),
                              PharmaceuticalStandard = (string)item.Element("PharmaceuticalStandard"),
                              TherapeuticClassification = (string)item.Element("TherapeuticClassification"),
                              Sponsorname = (string)item.Element("Sponsorname"),
                              Sponsoraddress = (string)item.Element("Sponsoraddress"),
                              Sponsorfootnote = (string)item.Element("Sponsorfootnote"),
                              DateofRevision = (string)item.Element("DateofRevision"),
                              DateofPreparation = (string)item.Element("DateofPreparation"),
                              SubmissionControlNumber = (string)item.Element("SubmissionControlNumber")
                          };

            foreach (var xmldataitem in xmldata)
            {
                if (xmldataitem.SchedulingSymbolImageData != null)
                    strscript += "$('#imgSymbol').attr('src', " + "'" + xmldataitem.SchedulingSymbolImageData + "');";

                if (xmldataitem.SchedulingSymbol != null)
                    strscript += "selectedschedulingsymbol = '" + xmldataitem.SchedulingSymbol + "';";

                if (xmldataitem.SchedulingSymbolImageName != null)
                    strscript += "$('#tbxmlimgfilenameSymbol').val('" + xmldataitem.SchedulingSymbolImageName + "');";

                if (xmldataitem.SchedulingSymbol != null)
                    strscript += "$('#tbxmlimgnameSymbol').val('" + xmldataitem.SchedulingSymbol + "');";

                if (tbPharmaceuticalStandard.Text != xmldataitem.PharmaceuticalStandard)
                    tbPharmaceuticalStandard.Text = xmldataitem.PharmaceuticalStandard;
                if (tbTherapeuticClassifications.Text != xmldataitem.TherapeuticClassification)
                    tbTherapeuticClassifications.Text = xmldataitem.TherapeuticClassification;
                if (tbSponsorName.Text != xmldataitem.Sponsorname)
                    tbSponsorName.Text = xmldataitem.Sponsorname;
                if (tbSponsorAddress.Value != xmldataitem.Sponsoraddress)
                    tbSponsorAddress.Value = xmldataitem.Sponsoraddress;
                if (tbFootnote.Value != xmldataitem.Sponsorfootnote)
                    tbFootnote.Value = xmldataitem.Sponsorfootnote;
                if (tbDateRev.Text != xmldataitem.DateofRevision)
                    tbDateRev.Text = xmldataitem.DateofRevision;
                if (tbDatePrep.Text != xmldataitem.DateofPreparation)
                    tbDatePrep.Text = xmldataitem.DateofPreparation;
                if (tbControNum.Text != xmldataitem.SubmissionControlNumber)
                    tbControNum.Text = xmldataitem.SubmissionControlNumber;
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);
        }

        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = SessionHelper.Current.draftForm;
            XmlNode rootnode = doc.DocumentElement;
            #region symbol
            try
            {
                string symbolname = Request.Form["tbxmlimgnameSymbol"].ToString();
                string symbolfilename = Request.Form["tbxmlimgfilenameSymbol"].ToString();

                if (symbolfilename != string.Empty)
                {
                    System.Drawing.Image imageBmp = System.Drawing.Image.FromFile(Server.MapPath("~/scheduling symbol/" + symbolfilename));
                    Bitmap bmp = new Bitmap(imageBmp);
                    TypeConverter converter = TypeDescriptor.GetConverter(typeof(Bitmap));
                    string base64 = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));


                    XmlNodeList schedsymbol = doc.GetElementsByTagName("SchedulingSymbol");
                    if (schedsymbol.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "SchedulingSymbol", "", symbolname, false);
                    }
                    else
                    {
                        schedsymbol[0].InnerText = symbolname;
                    }
                    XmlNodeList schedsymbolname = doc.GetElementsByTagName("SchedulingSymbolImageName");
                    if (schedsymbolname.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "SchedulingSymbolImageName", "", symbolfilename, false);
                    }
                    else
                    {
                        schedsymbolname[0].InnerText = symbolfilename;
                    }
                    XmlNodeList schedsymboldata = doc.GetElementsByTagName("SchedulingSymbolImageData");
                    if (schedsymboldata.Count < 1)
                    {
                        helpers.Processes.CreateXMLElement(doc, rootnode, "SchedulingSymbolImageData", "", base64, false);
                    }
                    else
                    {
                        schedsymboldata[0].InnerText = base64;
                    }
                }
            }
            catch (Exception error)
            {
                //  lblError.Text = error.ToString();
                return null;
            }
            #endregion

            #region BrandProperDosage
            try
            {
                XmlNodeList roa = doc.GetElementsByTagName("BrandProperDosage");
                ArrayList brandarray = new ArrayList();
                ArrayList properarray = new ArrayList();
                ArrayList dosagearray = new ArrayList();
                ArrayList strengthvaluearray = new ArrayList();
                ArrayList strengthunitarray = new ArrayList();
                ArrayList strengthperdosagevaluearray = new ArrayList();
                ArrayList strengthperdosageunitarray = new ArrayList();


                if (HttpContext.Current.Request.Form.GetValues("tbBrandName") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbProperName") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbDosage") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthValue") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthUnit") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageUnit") != null)
                {
                    foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbBrandName"))
                    {
                        brandarray.Add(routeitem);
                    }
                    foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbProperName"))
                    {
                        properarray.Add(dosageitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbDosage"))
                    {
                        dosagearray.Add(ingredientitem);
                    }

                    foreach (string strengthValueitem in HttpContext.Current.Request.Form.GetValues("tbStrengthValue"))
                    {
                        strengthvaluearray.Add(strengthValueitem);
                    }

                    foreach (string strengthUnititem in HttpContext.Current.Request.Form.GetValues("tbStrengthUnit"))
                    {
                        strengthunitarray.Add(strengthUnititem);
                    }

                    foreach (string strengthperDosagehValitem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue"))
                    {
                        strengthperdosagevaluearray.Add(strengthperDosagehValitem);
                    }
                    foreach (string StrengthperDosageUnititem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageUnit"))
                    {
                        strengthperdosageunitarray.Add(StrengthperDosageUnititem);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("BrandProperDosage");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < brandarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = brandarray[ar].ToString();
                        XmlNode subsubnode1 = doc.CreateElement("column");
                        subsubnode1.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode1);

                        string col2 = properarray[ar].ToString();
                        XmlNode subsubnode2 = doc.CreateElement("column");
                        subsubnode2.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode2);

                        string col3 = dosagearray[ar].ToString();
                        XmlNode subsubnode3 = doc.CreateElement("column");
                        subsubnode3.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode3);

                        string col4 = strengthvaluearray[ar].ToString();
                        XmlNode subsubnode4 = doc.CreateElement("column");
                        subsubnode4.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode4);

                        string col5 = strengthunitarray[ar].ToString();
                        XmlNode subsubnode5 = doc.CreateElement("column");
                        subsubnode5.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode5);

                        string col6 = strengthperdosagevaluearray[ar].ToString();
                        XmlNode subsubnode6 = doc.CreateElement("column");
                        subsubnode6.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode6);

                        string col7 = strengthperdosageunitarray[ar].ToString();
                        XmlNode subsubnode7 = doc.CreateElement("column");
                        subsubnode7.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode7);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("BrandProperDosage");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < brandarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = brandarray[ar].ToString();
                        XmlNode subsubnode1 = doc.CreateElement("column");
                        subsubnode1.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode1);

                        string col2 = properarray[ar].ToString();
                        XmlNode subsubnode2 = doc.CreateElement("column");
                        subsubnode2.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode2);

                        string col3 = dosagearray[ar].ToString();
                        XmlNode subsubnode3 = doc.CreateElement("column");
                        subsubnode3.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode3);

                        string col4 = strengthvaluearray[ar].ToString();
                        XmlNode subsubnode4 = doc.CreateElement("column");
                        subsubnode4.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode4);

                        string col5 = strengthunitarray[ar].ToString();
                        XmlNode subsubnode5 = doc.CreateElement("column");
                        subsubnode5.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode5);

                        string col6 = strengthperdosagevaluearray[ar].ToString();
                        XmlNode subsubnode6 = doc.CreateElement("column");
                        subsubnode6.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode6);

                        string col7 = strengthperdosageunitarray[ar].ToString();
                        XmlNode subsubnode7 = doc.CreateElement("column");
                        subsubnode7.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode7);
                    }
                }
                SessionHelper.Current.brandName = brandarray[0].ToString();
                SessionHelper.Current.properName = properarray[0].ToString();
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "PharmaceuticalStandard", "", tbPharmaceuticalStandard.Text, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "TherapeuticClassification", "Therapeutic Classification", tbTherapeuticClassifications.Text, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorname", "Sponsor name", tbSponsorName.Text, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsoraddress", "Sponsor address", tbSponsorAddress.Value, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorfootnote", "Sponsor Footnote", tbFootnote.Value, true);

            #region Revision and Preparation dates

            if (Request.Form["tbDatePrep"] != null)
            {
                helpers.Processes.ValidateAndSave(doc, rootnode, "DateofPreparation", "", Request.Form["tbDatePrep"], false);
            }

            if (Request.Form["tbDateRev"] != null)
            {
                helpers.Processes.ValidateAndSave(doc, rootnode, "DateofRevision", "", Request.Form["tbDateRev"], false);
            }       
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "SubmissionControlNumber", "Submission Control Number", tbControNum.Text, true);

            SessionHelper.Current.draftForm = doc;

            return doc;
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {

            //var sb = new StringBuilder();
            //sb.Append("<script language='javascript' type='text/javascript'>");
            //sb.Append("function GoToPartOnePage() {");
            //sb.Append("alert('Function called successfully!');");
            //sb.Append("window.location.href = 'PartOne.aspx';");
            //sb.Append("return false;");
            //sb.Append("}");
            //sb.Append("</script>");
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), Guid.NewGuid().ToString(), sb.ToString(), false);

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
            catch (System.Threading.ThreadAbortException thr)
            {
                var strMessage = string.Format("{0}-{1}", "Coverpage", "btnSaveDraft_Click");
                ExceptionHelper.LogException(thr, strMessage);
            }
            catch (Exception ex)
            {
                var strMessage = string.Format("{0}-{1}", "Coverpage", "btnSaveDraft_Click");
                ExceptionHelper.LogException(ex, strMessage);
            }
        }

    }
}
