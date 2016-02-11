using System;
using System.Web;
using System.IO;
using System.Xml;
using System.Text;
using System.Threading;
using System.Globalization;


namespace Product_Monograph
{
    public partial class PMForm : BasePage
    {
        void Page_PreInit(Object sender, EventArgs e)
        {
            if (Session["masterpage"] != null)
            {
                this.MasterPageFile = (String)Session["masterpage"];
            }
        }

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
            Thread.CurrentThread.CurrentUICulture = new CultureInfo((lang == "") ? "en" : lang);
            Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;

            lblUsingxml.Text = Resources.Resource.UsingXMLPM;

            lblBody.Text = ResourceHelpers.WrapTextBlockIntoParagraphs(Resources.Resource.Body).ToString().Replace("qmark", "<img src='images/qmark.jpg' style='width: 15px; height: 15px;' />");

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
                        lblError.Text = "Please choose an xml file.";
                        return;
                    }

                }
                else
                {
                    lblError.Text = "Please choose an xml file.";
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
