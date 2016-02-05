﻿using System;
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

namespace Product_Monograph
{
    public partial class Coverpage : System.Web.UI.Page
    {
        string strscript = "";

        public class Field
        {
            public string FieldLabel { get; set; }

            public string FieldID { get; set; }
        }

        List<Field> fields = new List<Field>();

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
        }

        private void LoadFromXML()
        {
            XmlDocument xmldoc = (XmlDocument)Session["draft"];
            //XmlDocument xmldoc = (XmlDocument)helpers.Processes.XMLDraft;            
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

              
                int rowcounter = 1;

                foreach (var row in rows)
                {                   
                    strscript += "AddBrandProperDosageTextBoxLoadFromXML();";

                    string[] colarray = "tbBrandName;tbProperName;tbDosage;tbStrengthValue;tbStrengthUnit;tbStrengthperDosageValue;tbStrengthperDosageUnit".Split(';');
                    int colcounter = 0;
                    foreach (string column in row.columns)
                    {
                        if (colarray[colcounter].Equals("tbDosage"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                            "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                "var $option = $(this).text();" +
                                                "$('<option>' + $option + '</option>').appendTo('#tbDosage" + rowcounter + "');" +
                                            "});" +
                                            "}).done(function () {" +
                                                "$('#tbDosage" + rowcounter + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                            "});";
                        }
                        else if (colarray[colcounter].Equals("tbStrengthUnit"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('unit').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbStrengthUnit" + rowcounter + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbStrengthUnit" + rowcounter + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                        }
                        else if (colarray[colcounter].Equals("tbStrengthperDosageUnit"))
                        {
                            strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('unit').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbStrengthperDosageUnit" + rowcounter + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbStrengthperDosageUnit" + rowcounter + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
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
            
            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              SchedulingSymbol = (string)item.Element("SchedulingSymbol"),
                              SchedulingSymbolImageName = (string)item.Element("SchedulingSymbolImageName"),
                              SchedulingSymbolImageData = (string)item.Element("SchedulingSymbolImageData"),
                              BrandName = (string)item.Element("BrandName"),
                              ProperName = (string)item.Element("ProperName"),
                              DosageFormStrength = (string)item.Element("DosageFormStrength"),
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
                
                tbPharmaceuticalStandard.Text = xmldataitem.PharmaceuticalStandard;
                tbTherapeuticClassifications.Text = xmldataitem.TherapeuticClassification;
                tbSponsorName.Text = xmldataitem.Sponsorname;
                tbSponsorAddress.Value = xmldataitem.Sponsoraddress;
                tbFootnote.Value = xmldataitem.Sponsorfootnote;
                tbDateRev.Text = xmldataitem.DateofRevision;
                tbDatePrep.Text = xmldataitem.DateofPreparation;
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
                //imgSymbol.Src = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])converter.ConvertTo(bmp, typeof(byte[])));
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
            XmlDocument doc = (XmlDocument)Session["draft"]; // helpers.Processes.XMLDraft;
            XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");
   

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
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbStrengthValue"))
                    {
                        strengthvaluearray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbStrengthUnit"))
                    {
                        strengthunitarray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageValue"))
                    {
                        strengthperdosagevaluearray.Add(ingredientitem);
                    }
                    foreach (string ingredientitem in HttpContext.Current.Request.Form.GetValues("tbStrengthperDosageUnit"))
                    {
                        strengthperdosageunitarray.Add(ingredientitem);
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
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = properarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = strengthvaluearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = strengthunitarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = strengthperdosagevaluearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = strengthperdosageunitarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col7));
                        subnode.AppendChild(subsubnode);
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
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = properarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = strengthvaluearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = strengthunitarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);

                        string col6 = strengthperdosagevaluearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col6));
                        subnode.AppendChild(subsubnode);

                        string col7 = strengthperdosageunitarray[ar].ToString();
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

            helpers.Processes.ValidateAndSave(doc, rootnode, "PharmaceuticalStandard", "", tbPharmaceuticalStandard.Text, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "TherapeuticClassification", "Therapeutic Classification", tbTherapeuticClassifications.Text, true);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorname", "Sponsor name", tbSponsorName.Text, true);

            //String sponsoradressval = Regex.Replace(tbSponsorAddress.Value, @"<([^>]+)>", String.Empty);
            //if (sponsoradressval.Length > maxchar)
            //{
            //    lblError.Text = "Sponsor name cannot be more than 1500 characters";
            //    return null;
            //}
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsoraddress", "Sponsor address", tbSponsorAddress.Value, true);

            //String footnoteval = Regex.Replace(tbFootnote.Value, @"<([^>]+)>", String.Empty);
            //if (footnoteval.Length > maxchar)
            //{
            //    lblError.Text = "Footnote cannot be more than 1500 characters";
            //    return null;
            //}
            helpers.Processes.ValidateAndSave(doc, rootnode, "Sponsorfootnote", "Sponsor Footnote", tbFootnote.Value, true);

            #region Revision and Preparation dates
            string tbDatePrepVal = Request.Form[tbDatePrep.UniqueID];
            string tbDateRevVal = Request.Form[tbDateRev.UniqueID];
            helpers.Processes.ValidateAndSave(doc, rootnode, "DateofPreparation", "", tbDatePrepVal, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DateofRevision", "", tbDateRevVal, false);
            //if (tbDatePrep.Text.Trim() == string.Empty)
            //{
            //    helpers.Processes.ValidateAndSave(doc, rootnode, "DateofRevision", "Date of Revision", tbDateRev.Text, true);
            //    helpers.Processes.ValidateAndSave(doc, rootnode, "DateofPreparation", "", tbDatePrep.Text, false);
            //}
            //else
            //{
            //    helpers.Processes.ValidateAndSave(doc, rootnode, "DateofPreparation", "", tbDatePrep.Text, false);
            //    helpers.Processes.ValidateAndSave(doc, rootnode, "DateofRevision", "", tbDateRev.Text, false);
            //}
            #endregion

            helpers.Processes.ValidateAndSave(doc, rootnode, "SubmissionControlNumber", "Submission Control Number", tbControNum.Text, true);

            //helpers.Processes.XMLDraft = doc;
            Session["draft"] = doc;

            return doc;
        }
        
        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            string strSaveFileName = string.Empty;
            string strXmlExtension = ".xml";
            string strZipExtension = ".zip";
            try
            {

                XmlDocument doc = SaveInMemory();

                LoadFromXML();

                //get BrandName AS file name which saved as zip file -- Add code by Ching Chang
                if (HttpContext.Current.Request.Form.GetValues("tbBrandName") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbBrandName"))
                    {
                        item.TrimEnd();
                        if (item.Length > 0)
                        {
                            strSaveFileName = item;
                            if (strSaveFileName.Length > 0)
                            {
                                break;
                            }
                        }
                    }
                }
                else  //if not find the Brand name in the session, then use default TempfileName "ProductMonograph"
                    strSaveFileName = "DraftPMForm";

                #region zip
                byte[] bytes = Encoding.Default.GetBytes(doc.OuterXml);

                using (var compressedFileStream = new MemoryStream())
                {
                    using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Update, true))
                    {
                        if (doc != null)
                        {
                            var zipEntry = zipArchive.CreateEntry(strSaveFileName + strXmlExtension);
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
            //if(SaveInMemory() != null)  //ching disable it, because it was not the same code as the project on Feb 3, 2016
            SaveInMemory();
            Response.Redirect(submenutabs.SelectedValue + ".aspx");
        }

        protected void submenutabsbottom_MenuItemClick(object sender, MenuEventArgs e)
        {
            SaveInMemory();
            Response.Redirect(submenutabsbottom.SelectedValue + ".aspx");
        }

    }
}


//<div style="width:18.8%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">
//        <input type="text" id="tbBrandName0" name="tbBrandName" style="width:100%; border:0px; height:38px;" />
//    </div>  
//    <div style="width:18.8%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">
//        <input type="text" id="tbProperName0" name="tbProperName" style="width:100%; border:0px; height:38px;" />
//    </div> 
//    <div style="width:18.8%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">        
//        <select id="tbDosage0" name="tbDosage" style="width:100%; height:38px; border:0px;" ></select>
//    </div>  
//    <div style="width:18.8%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">
//        <input type="number" id="tbStrength0" name="tbStrength" style="width:100%; border:0px; height:38px;" />   
//    </div> 
//    <div style="width:18.8%; float:left; border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">
//        <select id="tbUnitofMeasure0" name="tbUnitofMeasure" style="width:100%; height:38px; border:0px;" ></select>              
//    </div>  
//    <div style="width:5%; float:left; padding-left: 0px;">
//        <input style="cursor:pointer !important; width:58px; height:40px; font-size:12px; padding-left:2px;" onclick="RemoveBrandProperDosageTextBox(0)" type="button" value="REMOVE" />                                                          
//    </div>  

//MMM d, yyyy