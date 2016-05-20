using System;
using System.Web;
using System.IO;
using System.Xml;
using System.Text;
using Product_Monograph.helpers;

namespace Product_Monograph
{
    public partial class PMForm : BasePage
    {
        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }
            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.formInstruction;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.formInstruction;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if ( lang.Equals("fr"))
                {
                    sectionEng.Visible = false;
                    sectionFra.Visible = true;
                }
                else
                {
                    sectionEng.Visible = true;
                    sectionFra.Visible = false;
                }
            }
        }

        protected void btnLoadTemplate_Click(object sender, EventArgs e)
        {
            XmlDocument doc = new XmlDocument();
            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            doc.AppendChild(docNode);

            XmlNode rootnode = doc.CreateElement("ProductMonographTemplate");
            doc.AppendChild(rootnode);

            XmlNode xnode = doc.CreateElement("TemplateVersion");
            xnode.AppendChild(doc.CreateTextNode(ddlTemplate.Value));
            rootnode.AppendChild(xnode);

            SessionHelper.Current.draftForm = doc;
            SessionHelper.Current.brandName = string.Empty;
            SessionHelper.Current.properName = string.Empty;
            Response.Redirect("Coverpage.aspx");
        }

        protected void btnLoadXml_Click(object sender, EventArgs e)
        {

            try
            {
                if (fuXmlDraft.HasFile)
                {
                    int idirectory = fuXmlDraft.PostedFile.FileName.LastIndexOf("\\");
                    FileInfo fi = new FileInfo(fuXmlDraft.FileName);
                    if (!fi.Extension.ToString().ToLower().Contains("xml"))
                    {
                        return;
                    }
                    if(fi.FullName.Contains("©"))
                    {
                        errorSection.Visible = true;
                        return;
                    }
                }
                else
                {
                    return;
                }

                XmlDocument doc = new XmlDocument();
                doc.Load(fuXmlDraft.PostedFile.InputStream);
                SessionHelper.Current.draftForm = doc;
                Response.Redirect("Coverpage.aspx");
            }
            catch (Exception err)
            {

            }
        }

    }

    
}