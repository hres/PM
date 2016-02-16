using System;
using System.Globalization;
using System.Threading;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Product_Monograph
{
    public partial class ProdMono : System.Web.UI.MasterPage
    {

        //public string lang = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.InnerText = "";

            lblTitleForm.Text = Resources.Resource.TitleForm;
             btnSetFrench.Attributes.Add("OnClick", "SwitchLanguage_Click()");
           // HtmlButton buttonControl = new HtmlButton();
            btnSetFrench.Click += new System.EventHandler(SwitchLanguage_Click);
            // btnSetFrench.Server += new EventHandler(SwitchLanguage_Click);
            btnSetFrench.PostBackUrl = Request.RawUrl;

        }

        protected void SwitchLanguage_Click(object sender, EventArgs e)
        {

            Session["SelectedLanguage"] = "fr-CA";
            Session["masterpage"] = "ProdMonoFr.master";
            Server.Transfer(Request.Path);
        }


        //protected void RequestLanguageChangeFrench_Click(object sender, EventArgs e) 
        //{
        //    //LinkButton senderLink = sender as LinkButton;

        //    ////store requested language as new culture in the session
        //    Session["SelectedLanguage"] = "fr";

        //    //if (Session["SelectedLanguage"].ToString().Contains("en"))
        //    //{
        //    //    Session["masterpage"] = "ProdMono.master";
        //    //}
        //    //else
        //    //{
        //        Session["masterpage"] = "ProdMonoFr.master";
        //    //}
        //    //reload last requested page with new culture
        //    Server.Transfer(Request.Path);
        //}


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

