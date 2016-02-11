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
using System.Configuration;
using System.Threading;
using System.Globalization;
namespace Product_Monograph
{
    public partial class ProdMonoFr : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            lblError.InnerText = "";
            
            lblTitleForm.Text = Resources.Resource.TitleForm;
        }
        protected void RequestLanguageChange_Click(object sender, EventArgs e)
        {
            try { 
                LinkButton senderLink = sender as LinkButton;

                //store requested language as new culture in the session
                Session["SelectedLanguage"] = senderLink.CommandArgument;

                if (Session["SelectedLanguage"].ToString().Contains("en"))
                {
                    Session["masterpage"] = "ProdMono.master";
                }
                else
                {
                    Session["masterpage"] = "ProdMonoFr.master";
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
            Server.Transfer(Request.Path); try
            {
                LinkButton senderLink = sender as LinkButton;

                //store requested language as new culture in the session
                Session["SelectedLanguage"] = senderLink.CommandArgument;

                if (Session["SelectedLanguage"].ToString().Contains("en"))
                {
                    Session["masterpage"] = "ProdMono.master";
                }
                else
                {
                    Session["masterpage"] = "ProdMonoFr.master";
                }

            }
            catch (Exception ex)
            {
                var errorMessages = string.Format("ProdMonoFr.Master.cs - Error Message:{0}", ex.Message);
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

