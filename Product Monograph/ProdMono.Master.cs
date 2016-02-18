using System;
using System.Globalization;
using System.Threading;

namespace Product_Monograph
{
    public partial class ProdMono : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //retrieve culture information from session
            string culture = Convert.ToString(Session["SelectedLanguage"]);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            lblError.InnerText = "";
           lblTitleForm.Text = Resources.Resource.TitleForm;
        }

        protected void SwitchLanguageFrench_Click(object sender, EventArgs e)
        {
            Session["SelectedLanguage"] = "fr-CA";
            Session["masterpage"] = "ProdMonoFr.Master";
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

