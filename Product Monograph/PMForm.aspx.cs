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
using System.Threading;
using System.Globalization;

namespace Product_Monograph
{
    public partial class PMForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lang = "";
            if (Request.QueryString["lang"] == null)
            { }
            else
            {
                lang = Request.QueryString["lang"].ToString();
            }
            
            //set the new lang pass via parameter
            Thread.CurrentThread.CurrentUICulture = new CultureInfo((lang == "") ? "en-CA" : lang);
            Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;



            lblUsingxml.Text = Resources.Resource.UsingXMLPM;

            lblBody.Text = ResourceHelpers.WrapTextBlockIntoParagraphs(Resources.Resource.Body).ToString().Replace("qmark","<img src='images/qmark.jpg' style='width: 15px; height: 15px;' />");
            
            lblTechSpec.Text = Resources.Resource.TechnicalSpecs;
            lblTitleFormInstructions.Text = Resources.Resource.TitleFormInstructions;
            lblBottomBody.Text = ResourceHelpers.WrapTextBlockIntoParagraphs(Resources.Resource.BottomBody).ToString();

            lblError.Text = "";
        }

        protected void btnLoadXml_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuXmlDraft.HasFile)
                {
                    int idirectory = fuXmlDraft.PostedFile.FileName.LastIndexOf("\\"); ;
                    //helpers.Processes.XMLPath = fuXmlDraft.PostedFile.FileName.Substring(0, idirectory);
                    FileInfo fi = new FileInfo(fuXmlDraft.FileName);
                    if (!fi.Extension.ToString().ToLower().Contains("xml"))
                    {
                        lblError.Text = "Choose an xml file";
                        return;
                    }

                }
                else
                {
                    lblError.Text = "Choose a file";
                    return;
                }

                XmlDocument doc = new XmlDocument();
                doc.Load(fuXmlDraft.PostedFile.InputStream);
                //helpers.Processes.XMLDraft = doc;
                Session["draft"] = doc;
                Response.Redirect("Coverpage.aspx");
            }
            catch (Exception err)
            {
                lblError.Text = err.ToString();
            }
        }  
    }

    public static class ResourceHelpers
    {
        public static IHtmlString WrapTextBlockIntoParagraphs(string s)
        {
            if (s == null) return new HtmlString(string.Empty);

            var blocks = s.Split(new string[] { "\r\n", "\n" },
                                  StringSplitOptions.RemoveEmptyEntries);

            StringBuilder htmlParagraphs = new StringBuilder();
            foreach (string block in blocks)
            {
                htmlParagraphs.Append("<p>" + block + "</p>");
            }

            return new HtmlString(htmlParagraphs.ToString());
        }
    }
}
