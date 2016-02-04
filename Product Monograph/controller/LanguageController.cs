using System.Threading;
using System.Web.Mvc;

namespace Product_Monograph.controller
{
    public class LanguageController : Controller
    {
        public ActionResult SetLanguage(string name)
        {
            Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(name);
            Thread.CurrentThread.CurrentUICulture = Thread.CurrentThread.CurrentCulture;

            HttpContext.Session["culture"] = name;

            return RedirectToAction("Index", "Home");
        }
    }
}