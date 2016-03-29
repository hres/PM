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
using System.Text.RegularExpressions;
using System.Threading;
using System.Globalization;

namespace Product_Monograph
{
    public partial class Coverpage : System.Web.UI.Page
    {
        string strscript = string.Empty;
        bool isClientXmlFile = false;
        string strSaveFileName = string.Empty;
        string strXmlExtension = ".xml";
        string strZipExtension = ".zip";
        public class Field
        {
            public string FieldLabel { get; set; }

            public string FieldID { get; set; }
        }

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

        List<Field> fields = new List<Field>();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (!IsPostBack)
            {
                try
                {
                    if(ValidateXmlDoc())  //if xml file contains data, load the file. otherwise ignores loading -- ching adds code
                       LoadFromXML();
                }
                catch 
                {
                    lblError.Text = "Please load a new template or a previously saved draft.";
                }
            }
            facilityResource();
            Session["isClientLoadXmlFile"] = isClientXmlFile;
        }
        private bool ValidateXmlDoc()
        {
            //Session["isClientLoadXmlFile"] = null;
            try
            {
                XmlDocument xmldoc = (XmlDocument)Session["draft"];
                if (xmldoc == null)  //maybe dameged, or not exist, or empty --- waiting for client requirements
                {
                    return false;
                  //  throw new ArgumentNullException("xmldoc");
                }
                else
                {
                    if (xmldoc.ChildNodes[1].HasChildNodes == false)  //having two elements, but it still contains empty data, it is new XML file
                    {
                        isClientXmlFile = false;
                        return false;
                    }
                    else
                    {
                        isClientXmlFile = true;
                        return true;     //it is a xml file which was loaded by client 
                    }
                   
                }
              

            }
            catch (XmlException e)
            {
                lblError.Text = "No XMLDocument file to load: " + e.Message;  //project stops -- note by ching
                return false;
            }
        
        }
        private void LoadFromXML()
        {
            XmlDocument xmldoc = (XmlDocument)Session["draft"];

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
                    if (rowcounter == 0)
                    {

                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbDosage"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbDosage');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbDosage option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else if (colarray[colcounter].Equals("tbStrengthUnit"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                    "$(xmlcontolledlist).find('unit').each(function () {" +
                                                        "var $option = $(this).text();" +
                                                        "$('<option>' + $option + '</option>').appendTo('#tbStrengthUnit');" +
                                                    "});" +
                                                    "}).done(function () {" +
                                                        "$('#tbStrengthUnit option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                    "});";
                            }
                            else if (colarray[colcounter].Equals("tbStrengthperDosageUnit"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                    "$(xmlcontolledlist).find('unit').each(function () {" +
                                                        "var $option = $(this).text();" +
                                                        "$('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit');" +
                                                    "});" +
                                                    "}).done(function () {" +
                                                        "$('#tbStrengthperDosageUnit option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                    "});";
                            }
                            else
                            {

                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";

                                if (colcounter == 0)
                                {
                                    Session["savedFilename"] = helpers.Processes.CleanString(column);
                                }
                                else if (colcounter == 1)
                                {
                                    Session["properName"] = helpers.Processes.CleanString(column);
                                }
                            }
                            colcounter++;

                        }
                    }
                    else
                    {
                        strscript += "addRow('dataTable');";

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
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }

                            colcounter++;
                        }
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
                if(tbSponsorName.Text != xmldataitem.Sponsorname)
                   tbSponsorName.Text = xmldataitem.Sponsorname;
                if (tbSponsorAddress.Value != xmldataitem.Sponsoraddress)
                   tbSponsorAddress.Value = xmldataitem.Sponsoraddress;
                if(tbFootnote.Value != xmldataitem.Sponsorfootnote)
                   tbFootnote.Value = xmldataitem.Sponsorfootnote;
                if (tbDateRev.Text != xmldataitem.DateofRevision)
                   tbDateRev.Text = xmldataitem.DateofRevision;
                if(tbDatePrep.Text != xmldataitem.DateofPreparation)
                   tbDatePrep.Text = xmldataitem.DateofPreparation;
                if(tbControNum.Text != xmldataitem.SubmissionControlNumber)
                   tbControNum.Text = xmldataitem.SubmissionControlNumber;
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);  
        }

        protected void btnApplySumbol_Click(object sender, EventArgs e)
        {            
            try
            {
                if (fuBrnandSymbol.HasFile)
                {
                    FileInfo fi = new FileInfo(fuBrnandSymbol.FileName);
                    if (!fi.Extension.ToString().ToLower().Contains("jpeg") &&
                        !fi.Extension.ToString().ToLower().Contains("jpg") &&
                        !fi.Extension.ToString().ToLower().Contains("png") &&
                        !fi.Extension.ToString().ToLower().Contains("gif"))
                    {
                        lblError.Text = "Choose an image file";
                        return;
                    }
                }
                else
                {
                    lblError.Text = "Choose a file";
                    return;
                }

                System.Drawing.Bitmap bmp = new System.Drawing.Bitmap(fuBrnandSymbol.PostedFile.InputStream);
                TypeConverter converter = TypeDescriptor.GetConverter(typeof(Bitmap));
             
                Session["SymbolToBase64String"] = Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));
                Session["SymbolToByte"] = (byte[])converter.ConvertTo(bmp, typeof(byte[]));
                Session["SymbolFileName"] = fuBrnandSymbol.FileName;               
            }
            catch (Exception error)
            {
                lblError.Text = error.ToString();
            }

        }

        private XmlDocument SaveInMemory()
        {
            //if (Session["draft"] == null)  -- need to check Xml file in session -- note by Ching 
            //{
            //    lblError.Text = "no xml file in session";
            //    return null;
            //}
            //else
            //{

                XmlDocument doc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
                XmlNode rootnode = doc.DocumentElement;
                //int NodeCount = doc.ChildNodes.Count;

                //XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");

                int mRowCount = 0;

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
                    lblError.Text = error.ToString();
                    return null;
                }
                #endregion

                #region BrandProperDosage
                try
                {
                    XmlNodeList roa = doc.GetElementsByTagName("BrandProperDosage");
                    string strtemp = "0";
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
                            mRowCount = mRowCount + 1;
                        }
                        foreach (string dosageitem in HttpContext.Current.Request.Form.GetValues("tbProperName"))
                        {
                            properarray.Add(dosageitem);
                        }
                        foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbDosage"))
                        {
                            dosagearray.Add(ingredientitem);
                        }

                        string[] strStrengthVal = HttpContext.Current.Request.Form.GetValues("tbStrengthValue");
                        int tempLength = HttpContext.Current.Request.Form.GetValues("tbBrandName").Length;
                        if (strStrengthVal.Length == tempLength)
                        {
                           foreach (string strengthValueitem in HttpContext.Current.Request.Form.GetValues("tbStrengthValue"))
                           {
                              strengthvaluearray.Add(strengthValueitem);
                           }
                        }
                        else
                        {
                         
                           
                           for(int i = 0; i < tempLength; i++)
                           {

                              if(( i+1 ) <= strStrengthVal.Length )
                                  strengthvaluearray.Add(strStrengthVal[i]);
                              else
                                  strengthvaluearray.Add(strtemp);
                           }
                        }

                        foreach (string strengthUnititem in HttpContext.Current.Request.Form.GetValues("tbStrengthUnit"))
                        {
                           strengthunitarray.Add(strengthUnititem);
                        }

                    ////
                    string[] strStrengthperDosageVal = HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue");
                    int tempBrandLength = HttpContext.Current.Request.Form.GetValues("tbBrandName").Length;
                    if (strStrengthperDosageVal.Length == tempBrandLength)
                    {
                        foreach (string strengthperDosagehValitem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue"))
                        {
                            strengthperdosagevaluearray.Add(strengthperDosagehValitem);
                        }
                    }
                    else
                    {
                       

                        for (int j = 0; j < tempBrandLength; j++)
                        {

                            if ((j + 1) <= strStrengthperDosageVal.Length)
                                strengthperdosagevaluearray.Add(strStrengthperDosageVal[j]);
                            else
                                strengthperdosagevaluearray.Add(strtemp);
                        }
                    }


                        //foreach (string StrengthperDosageValueitem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue"))
                        //{
                         
                        //     //strengthperdosagevaluearray.Add(strtemp);   //test by Ching
                         
                        //     strengthperdosagevaluearray.Add(StrengthperDosageValueitem);
                        //}

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
                }
                catch (Exception error)
                {
                    lblError.Text = error.ToString();
                    return null;
                }
                #endregion

                helpers.Processes.ValidateAndSave(doc, rootnode, "PharmaceuticalStandard", "", tbPharmaceuticalStandard.Text, false);
                helpers.Processes.ValidateAndSave(doc, rootnode, "TherapeuticClassification", "Therapeutic Classification", tbTherapeuticClassifications.Text, true);
                helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorname", "Sponsor name", tbSponsorName.Text, true);
                helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsoraddress", "Sponsor address", tbSponsorAddress.Value, true);
                helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorfootnote", "Sponsor Footnote", tbFootnote.Value, true);

                #region Revision and Preparation dates

                string tbDatePrepVal = Request.Form[tbDatePrep.UniqueID];
                string tbDateRevVal = Request.Form[tbDateRev.UniqueID];
                helpers.Processes.ValidateAndSave(doc, rootnode, "DateofPreparation", "", tbDatePrepVal, false);
                helpers.Processes.ValidateAndSave(doc, rootnode, "DateofRevision", "", tbDateRevVal, false);

                #endregion

                helpers.Processes.ValidateAndSave(doc, rootnode, "SubmissionControlNumber", "Submission Control Number", tbControNum.Text, true);
                Session["draft"] = doc;

                return doc;
          //  }
        }
        
        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {      
            try
            {
                XmlDocument doc = SaveInMemory();
                LoadFromXML();   //why load again?? - note by Ching

                #region zip
                byte[] bytes = Encoding.Default.GetBytes(doc.OuterXml);  
               
                using (var compressedFileStream = new MemoryStream())
                {
                    if (Session["savedFilename"] != null)
                    {
                        strSaveFileName = (String)Session["savedFilename"];
                    }
                    else
                        strSaveFileName = "DraftPMForm";
                    //System.IO.Compression.ZipArchiveMode zipMode = ZipArchiveMode.Create;  -- note by Ching
                    //if (isClientXmlFile == false)
                    //    zipMode = ZipArchiveMode.Create;
                    //else
                    //    zipMode = ZipArchiveMode.Update;
                    using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Update, true))  //if loading file, use update
                    //using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Create, true))   //if not load, first time to create --- test by ching
                    {
                        if (doc != null)
                        {
                           var zipEntry = zipArchive.CreateEntry(strSaveFileName + strXmlExtension);
                            //using (Stream stream = zipEntry.Open())   //test by ching
                            //{
                            //    // Save the xml file into the zip
                            //    doc.Save(stream);
                            //}

                            using (var originalFileStream = new MemoryStream(bytes))
                            {
                                using (var zipEntryStream = zipEntry.Open())
                                {
                                    originalFileStream.CopyTo(zipEntryStream);
                                }
                            }
                        }
                    }

                    var buffer = compressedFileStream.ToArray();   //bug here -- note by Ching
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    if (buffer.Length > 0)
                    {
                        Response.ContentType = "application/zip";
                        Response.BinaryWrite(buffer);
                        var fileName = strSaveFileName + strZipExtension;
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
        protected void facilityResource()
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

            CoverPage.Text = Resources.Resource.CoverPage;
            lblSchedulingSymbol.InnerText = Resources.Resource.lblSchedulingSymbol;
        
            tbBName.Text = Resources.Resource.tbBName;
            tbPName.Text = Resources.Resource.tbPName;
            tbDForm.Text = Resources.Resource.tbDForm;
            tbStrength.Text = Resources.Resource.tbStrength;
            lblStrengthperDosage.Text = Resources.Resource.lblStrengthperDosage;
            tbSValue.Text = Resources.Resource.tbSValue;
            tbSUnit.Text = Resources.Resource.tbSUnit;
            tbDValue.Text = Resources.Resource.tbSValue;
            tbDUnit.Text = Resources.Resource.tbSUnit;
            PharmaceuticalStandard.Text = Resources.Resource.tbPharmaceuticalStandard;
          
            TherapeuticClassification.Text = Resources.Resource.TherapeuticClassification;
            lblSponsorName.Text = Resources.Resource.lblSponsorName;
            lblSponsorAddress.Text = Resources.Resource.lblSponsorAddress;
            lblDateOfPreparation.Text = Resources.Resource.lblDateOfPreparation;
            lblAndOr.Text = Resources.Resource.lblAndOr;
            lblDateOfRevision.Text = Resources.Resource.lblDateOfRevision;
            SubmissionControlNo.Text = Resources.Resource.SubmissionControlNo;
            footnote.Text = Resources.Resource.footnote;

            btnApplySumbol.Text = Resources.Resource.btnApplySumbol;
            btnSaveDraft.Text = Resources.Resource.btnSaveDraft;
            btnSaveDraft.ToolTip = Resources.Resource.btnSaveDraft_tooltip;

            btnAppendRow.Value = Resources.Resource.btnAppendRow;
            btnDeleteRow.Value = Resources.Resource.btnDeleteRow;
         
        }
    }
}


//MMM d, yyyy