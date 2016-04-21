using System;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using Product_Monograph.helpers;



namespace Product_Monograph
{
    /// <summary>
    /// Summary description for BasePage
    /// </summary>
    public class BasePage : Page
    {
        private const string m_DefaultCulture = "en-CA";
        public string lang { get; set; }

        protected override void InitializeCulture()
        {
            //check whether a culture is stored in the session
            if (!string.IsNullOrEmpty(SessionHelper.Current.selectedLanguage))
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(SessionHelper.Current.selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(SessionHelper.Current.selectedLanguage);
            }
            else
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(m_DefaultCulture);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(m_DefaultCulture);
            }
            lang = Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;
            
            //call base class
            base.InitializeCulture();
           }

    }
}