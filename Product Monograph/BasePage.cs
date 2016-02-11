using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



namespace Product_Monograph
{
    /// <summary>
    /// Summary description for BasePage
    /// </summary>
    public class BasePage : Page
    {
        private const string m_DefaultCulture = "en-CA";

        protected override void InitializeCulture()
        {
            //retrieve culture information from session
            string culture = Convert.ToString(Session["SelectedLanguage"]);

            //check whether a culture is stored in the session
            if (!string.IsNullOrEmpty(culture)) Culture = culture;
            else Culture = m_DefaultCulture;

            //set culture to current thread
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);

            //call base class
            base.InitializeCulture();
        }
    }
}