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

namespace Product_Monograph
{
    public partial class PMForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
}