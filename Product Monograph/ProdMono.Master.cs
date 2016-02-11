using System;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
namespace Product_Monograph
{
    public partial class ProdMono : System.Web.UI.MasterPage
    {

        //public string lang = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.InnerText = "";

            lblTitleForm.Text = Resources.Resource.TitleForm;
        }
        public void RequestLanguageChange(object sender, EventArgs e)
        {
            try
            {
                LinkButton senderLink = sender as LinkButton;

                //store requested language as new culture in the session
                Session["SelectedLanguage"] = senderLink.CommandArgument;

                if (Session["SelectedLanguage"].ToString().Contains("en"))
                {
                    Session["masterpage"] = "ProdMono.master";
                    //set the new lang pass via parameter
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-CA");
                    Thread.CurrentThread.CurrentCulture = new CultureInfo("en-CA");


                }
                else
                {
                    Session["masterpage"] = "ProdMonoFr.master";
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo("fr-CA");
                    Thread.CurrentThread.CurrentCulture = new CultureInfo("fr-CA");

                }

            }
            catch (Exception ex)
            {
                var errorMessages = string.Format("ProdMono.Master.cs - Error Message:{0}", ex.Message);
                ExceptionHelper.LogException(ex, errorMessages);
            }
            finally
            {
                //reload last requested page with new culture
                Server.Transfer(Request.Path);
            }
            //reload last requested page with new culture
            Server.Transfer(Request.Path);

        }

    }
}
// <nav role="navigation" id="wb-sm-hc-prodmono" class="wb-menu visible-md visible-lg" data-trgt="mb-pnl">
//            <div class="container nvbar">
//                <div class="row">
//                    <ul class="list-inline menu">
//                        <li><a href="PMForm.aspx">Home</a></li>
//                        <li><a href="Coverpage.aspx">Cover</a></li>
//                        <li><a href="PartOne.aspx">Part 1</a></li>
//                        <li><a href="PartTwo.aspx">Part 2</a></li>
//                        <li><a href="PartThree.aspx">Part 3</a></li>
//                    </ul>
//                </div>
//            </div>
//        </nav> 


//<nav role="navigation" id="wb-sm-hc-prodmonobottom" class="wb-menu visible-md visible-lg" data-trgt="mb-pnl">
//            <div class="container nvbar">
//            <div class="row">
//                <ul class="list-inline menu">
//                    <li><a href="Coverpage.aspx">Cover</a></li>
//                    <li><a href="PartOne.aspx">Part 1</a></li>
//                    <li><a href="PartTwo.aspx">Part 2</a></li>
//                    <li><a href="PartThree.aspx">Part 3</a></li>
//                </ul>
//            </div>
//        </div>
//    </nav> 

