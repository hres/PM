using System;
using System.Threading;
using System.Globalization;
using Product_Monograph.helpers;
using System.Web.UI.WebControls;

namespace Product_Monograph
{
    public partial class ProdMonoFr : System.Web.UI.MasterPage
    {
        public string pageTitleValue { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ////retrieve culture information from session
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.selectedLanguage))
            {
                if (!string.IsNullOrWhiteSpace(SessionHelper.Current.selectedLanguage))
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo(SessionHelper.Current.selectedLanguage);
            }

            if (!IsPostBack)
            {

            }
            this.pageTitle.Text = pageTitleValue;
            //this.brandName.Text = SessionHelper.Current.brandName;
            //this.properName.Text = SessionHelper.Current.properName;
        }

        protected void SwitchLanguageEnglish_Click(object sender, EventArgs e)
        {
            SessionHelper.Current.selectedLanguage = "fr-CA";
            SessionHelper.Current.masterPage = "ProdMonoFr.Master";
            Server.Transfer(Request.Path);
        }
    }
}
