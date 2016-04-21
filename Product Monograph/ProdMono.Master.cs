using Product_Monograph.helpers;
using System;
using System.Globalization;
using System.Threading;
using System.Web.UI.WebControls;

namespace Product_Monograph
{
    public partial class ProdMono : System.Web.UI.MasterPage
    {
        public string pageTitleValue { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if( !string.IsNullOrWhiteSpace(SessionHelper.Current.selectedLanguage))
            {
                if (!string.IsNullOrWhiteSpace(SessionHelper.Current.selectedLanguage))
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo(SessionHelper.Current.selectedLanguage);
            }

            if (!IsPostBack)
            {

            }
            this.pageTitle.Text = pageTitleValue;
        }

        protected void SwitchLanguageFrench_Click(object sender, EventArgs e)
        {
            SessionHelper.Current.selectedLanguage = "fr-CA";
            SessionHelper.Current.masterPage = "ProdMonoFr.Master";
            Server.Transfer(Request.Path);
        }
    }
}

