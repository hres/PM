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
using System.Collections;
using System.IO.Compression;
using System.Threading;
using System.Globalization;
using Product_Monograph.helpers;

namespace Product_Monograph
{
    public partial class PartOne : BasePage
    {
        string strscript = string.Empty;
        bool isClientLoadXML = false;
        protected static string sumProdInfo;
        protected static string sumIndications;
        protected static string sumContraindications;
        protected static string sumWarnings;
        protected static string sumAdverseReactions;
        protected static string sumDrugInteractions;
        protected static string sumDosage;
        protected static string sumOverdosage;
        protected static string sumClinicalPharmacology;
        protected static string sumStorage;
        protected static string sumSpecialHandling;
        protected static string sumDosageForm;
        protected static string indicatedFor;
        protected static string geriatrics;
        protected static string geriatricsAge;
        protected static string pediatrics;
        protected static string periatricsAgeX;
        protected static string pediatricsAge;
        protected static string contraindications;
        protected static string seriousWarnings;
        protected static string adverseReaction;
        protected static string seriousInteractions;
        protected static string dosingConsiderations;
        protected static string recommendedDose;
        protected static string missedDose;
        protected static string administration;
        protected static string reconstitution;
        protected static string oralSolutions;
        protected static string parenteralProd;
        protected static string vialSize;
        protected static string volumediluent;
        protected static string availableVolume;
        protected static string concentration;
        protected static string routeAdministration;
        protected static string dosageForm;
        protected static string strength;
        protected static string nonmedIngred;
        protected static string headings;
        protected static string addWarnings;
        protected static string interactionOverview;
        protected static string overdosage;        
        protected static string mechanismAction;
        protected static string pharmacodynamics;
        protected static string populationsConditions;
        protected static string storagestability;
        protected static string handlingInstruction;
        protected static string compositionPackaging;
        protected static string brandNameTitle;
        protected static string properNameTitle;
        protected static string information;
        protected static string dosingConsiderationsInfo;
        protected static string recommendedDoseInfo;
        protected static string mechanismActionInfo;
        protected static string seriousInteractionsInfo;
        protected static string headingsInfo;
        protected static string contraindicationsInfo;
        protected static string indicatedForInfo;
        protected static string seriousWarningsInfo;
        protected static string adverseReactionInfo;
        protected static string interactionOverviewInfo;
        protected static string parenteralProdInfo;
        protected static string addButton;
        protected static string removeButton;
        protected static string overdoseInstruction;
        protected static string productInfoTableTitle;
        protected static string parenteralProdTitle;
        protected static string pharmacokinetics;
        protected static string PharmacokineticsTableTitle;
        protected static string CTAdverseReaction;
        protected static string CTAdverseReactionInfo;
        protected static string CTAdverseReactionTable;
        protected static string CTAdReactSupplement;
        protected static string CTAdReactSupplementInfo;
        protected static string drugDrugInteraction;
        protected static string refTitle;
        protected static string refInfo;
        protected static string effect;
        protected static string effectInfo;
        protected static string clinicalComment;
        protected static string clinicalCommentInfo;
        protected static string legendInfo;
        protected static string cmax;
        protected static string halfLifeTitle;
        protected static string auc;
        protected static string clearance;
        protected static string volDistribution;
        protected static string pharmacokineticParameters;
        protected static string resetButton;

        void Page_PreInit(Object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(SessionHelper.Current.masterPage))
            {
                this.MasterPageFile = SessionHelper.Current.masterPage;
            }

            if (this.lang.Equals("fr"))
            {
                ((ProdMonoFr)Page.Master).pageTitleValue = Resources.Resource.partOne;
            }
            else
            {
                ((ProdMono)Page.Master).pageTitleValue = Resources.Resource.partOne;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                brandNameTitle = Resources.Resource.brandNameTitle;
                properNameTitle = Resources.Resource.properNameTitle;
                sumProdInfo = Resources.Resource.sumProdInfo;
                sumIndications = Resources.Resource.sumIndications;
                sumContraindications = Resources.Resource.sumContraindications;
                sumWarnings = Resources.Resource.sumWarnings;
                sumAdverseReactions = Resources.Resource.sumAdverseReactions;
                sumDrugInteractions = Resources.Resource.sumDrugInteractions;
                sumDosage = Resources.Resource.sumDosage;
                sumOverdosage = Resources.Resource.sumOverdosage;
                sumClinicalPharmacology = Resources.Resource.sumClinicalPharmacology;
                sumStorage = Resources.Resource.sumStorage;
                sumSpecialHandling = Resources.Resource.sumSpecialHandling;
                sumDosageForm = Resources.Resource.sumDosageForm;
                indicatedFor = Resources.Resource.indicatedFor;
                geriatrics = Resources.Resource.geriatrics;
                geriatricsAge = Resources.Resource.geriatricsAge;
                pediatrics = Resources.Resource.pediatrics;
                pediatricsAge = Resources.Resource.pediatricsAge;
                periatricsAgeX = Resources.Resource.pediatricsAgeX;
                contraindications = Resources.Resource.contraindications;
                seriousWarnings = Resources.Resource.seriousWarnings;
                adverseReaction = Resources.Resource.adverseReaction;
                seriousInteractions = Resources.Resource.seriousInteractions;
                dosingConsiderations = Resources.Resource.dosingConsiderations;
                recommendedDose = Resources.Resource.recommendedDose;
                missedDose = Resources.Resource.missedDose;
                administration = Resources.Resource.administration;
                reconstitution = Resources.Resource.reconstitution;
                oralSolutions = Resources.Resource.oralSolutions;
                parenteralProd = Resources.Resource.parenteralProd;
                vialSize = Resources.Resource.vialSize;
                volumediluent = Resources.Resource.volumediluent;
                availableVolume = Resources.Resource.availableVolume;                
                concentration = Resources.Resource.concentration;
                routeAdministration = Resources.Resource.routeAdministration;
                dosageForm = Resources.Resource.dosageForm;
                strength = Resources.Resource.strength;
                nonmedIngred = Resources.Resource.nonmedIngred;
                headings = Resources.Resource.headings;
                addWarnings = Resources.Resource.addWarnings;
                interactionOverview = Resources.Resource.interactionOverview;
                overdosage = Resources.Resource.overdosage;                
                mechanismAction = Resources.Resource.mechanismAction;
                pharmacodynamics = Resources.Resource.pharmacodynamics;
                populationsConditions = Resources.Resource.populationsConditions;
                storagestability = Resources.Resource.storagestability;
                handlingInstruction = Resources.Resource.handlingInstruction;
                compositionPackaging = Resources.Resource.compositionPackaging;
                information = Resources.Resource.information;
                dosingConsiderationsInfo = Resources.Resource.dosingConsiderationsInfo;
                recommendedDoseInfo = Resources.Resource.recommendedDoseInfo;
                mechanismActionInfo = Resources.Resource.mechanismActionInfo;
                seriousInteractionsInfo = Resources.Resource.seriousInteractionsInfo;
                headingsInfo = Resources.Resource.headingsInfo;
                contraindicationsInfo = Resources.Resource.contraindicationsInfo;
                indicatedForInfo = Resources.Resource.indicatedForInfo;
                seriousWarningsInfo = Resources.Resource.seriousWarningsInfo;
                adverseReactionInfo = Resources.Resource.adverseReactionInfo;
                interactionOverviewInfo = Resources.Resource.interactionOverviewInfo;
                parenteralProdInfo = Resources.Resource.parenteralProdInfo;
                addButton = Resources.Resource.addButton;
                removeButton = Resources.Resource.removeButton;
                tbOverdosage.Value= Resources.Resource.overdoseInstruction;
                btnSaveDraft.Text = Resources.Resource.saveButton;
                btnSaveDraft.Attributes["Title"] = Resources.Resource.saveButtonTitle;
                productInfoTableTitle = Resources.Resource.productInfoTableTitle;
                parenteralProdTitle = Resources.Resource.parenteralProdTitle;
                pharmacokinetics = Resources.Resource.pharmacokinetics;
                PharmacokineticsTableTitle  = Resources.Resource.pharmacokinetics;
                CTAdverseReaction = Resources.Resource.CTAdverseReaction;
                CTAdverseReactionInfo = Resources.Resource.CTAdverseReactionInfo;
                CTAdverseReactionTable = Resources.Resource.CTAdverseReactionTable;
                CTAdReactSupplement = Resources.Resource.CTAdReactSupplement;
                CTAdReactSupplementInfo = Resources.Resource.CTAdReactSupplementInfo;
                drugDrugInteraction = Resources.Resource.drugDrugInteraction;
                refTitle = Resources.Resource.refTitle;
                refInfo = Resources.Resource.refInfo;
                effect = Resources.Resource.effect;
                effectInfo = Resources.Resource.effectInfo;
                clinicalComment = Resources.Resource.clinicalComment;
                clinicalCommentInfo = Resources.Resource.clinicalCommentInfo;
                legendInfo = Resources.Resource.legendInfo;
                cmax = Resources.Resource.cmax;
                halfLifeTitle = Resources.Resource.halfLifeTitle;
                auc = Resources.Resource.auc;
                clearance = Resources.Resource.clearance;
                volDistribution = Resources.Resource.volDistribution;
                pharmacokineticParameters = Resources.Resource.pharmacokineticParameters;
                resetButton = Resources.Resource.resetButton;


                try
                {
                    LoadFromXML();
                    if (!string.IsNullOrEmpty(SessionHelper.Current.brandName))
                    {
                        this.brandName.Text = SessionHelper.Current.brandName;
                    }
                    if (!string.IsNullOrEmpty(SessionHelper.Current.properName))
                    {
                        this.properName.Text = SessionHelper.Current.properName;
                    }
                }
                catch
                {
                   // lblError.Text = "Please load a new template or a previously saved draft.";
                }
            }
            else
            {
                if(isClientLoadXML)
                    LoadFromXML();
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                XmlDocument doc = SaveInMemory();
                if (doc == null)
                {
                    return;
                }
                else
                {
                    if (!string.IsNullOrWhiteSpace(SessionHelper.Current.brandName))
                    {
                        var common = new helpers.Common(SessionHelper.Current.brandName);
                        common.SaveXmlFile(doc);
                        SessionHelper.Current.draftForm = doc;
                    }
                }
            }
            catch (Exception error)
            {
            }
        }

 
        private XmlDocument SaveInMemory()
        {
            XmlDocument doc = SessionHelper.Current.draftForm;
            XmlNode rootnode = doc.SelectSingleNode("ProductMonographTemplate");

            #region Summary product information - RouteOfAdministration
            try
            {
                XmlNodeList roa = doc.GetElementsByTagName("RouteOfAdministration");

                ArrayList routearray = new ArrayList();
                ArrayList dosagearray = new ArrayList();
                ArrayList strengtharray = new ArrayList();
                ArrayList ingredientsarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbRouteOfAdminDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbDosageFormDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbStrengthDynamic") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevant") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbRouteOfAdminDynamic"))
                    {
                        routearray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbDosageFormDynamic"))
                    {
                        dosagearray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbStrengthDynamic"))
                    {
                        strengtharray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbClinicallyRelevant"))
                    {
                        ingredientsarray.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("RouteOfAdministration");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < routearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = routearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = strengtharray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ingredientsarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("RouteOfAdministration");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < routearray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = routearray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = dosagearray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = strengtharray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = ingredientsarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                return null;
            }
            #endregion
            #region IndicationsClinicalUse
            helpers.Processes.ValidateAndSave(doc, rootnode, "BrandNameIndicatedFor", "", tbbrandName.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "GeriatricsAge", "", tbGeriatricsAge.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Geriatrics", "", tbGeriatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeX", "", tbPediatricsAgeX.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeY", "", tbPediatricsAgeY.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "PediatricsAgeZ", "", tbPediatricsAgeZ.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Pediatrics", "", tbPediatrics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseReactions", "", tbAdverseReactions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseDrugReactions", "", tbAdverseDrugReactions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseReactionsSupplement", "", tbAdverseReactionsSupplement.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DrugInteractions", "", tbDrugInteractions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SeriousDrugInteractions", "", tbSeriousDrugInteractions.Value, false);
            #endregion
            #region Contraindications
            //try
            //{
            //    XmlNodeList con = doc.GetElementsByTagName("Contraindications");

            //    ArrayList contraarray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("tbContraindications") != null)
            //    {
            //        foreach (string routeitem in HttpContext.Current.Request.Form.GetValues("tbContraindications"))
            //        {
            //            contraarray.Add(routeitem);
            //        }
            //    }

            //    if (con.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("Contraindications");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < contraarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = contraarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        con[0].RemoveAll();

            //        XmlNodeList xnode = doc.GetElementsByTagName("Contraindications");
            //        rootnode.AppendChild(xnode[0]);

            //        for (int ar = 0; ar < contraarray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = contraarray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //   // lblError.Text = error.ToString();
            //    return null;
            //}
            #endregion
            #region Warnings and precautions
            //try
            //{
            //    XmlNodeList swp = doc.GetElementsByTagName("SeriousWarningsandPrecautions");
            //    ArrayList swparray = new ArrayList();
            //    if (HttpContext.Current.Request.Form.GetValues("tbSeriousWarnings") != null)
            //    {
            //        foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbSeriousWarnings"))
            //        {
            //            swparray.Add(swpitem);
            //        }
            //    }

            //    if (swp.Count < 1)
            //    {
            //        XmlNode xnode = doc.CreateElement("SeriousWarningsandPrecautions");
            //        rootnode.AppendChild(xnode);

            //        for (int ar = 0; ar < swparray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode.AppendChild(subnode);

            //            string col1 = swparray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //    else
            //    {
            //        swp[0].RemoveAll();
            //        XmlNodeList xnode = doc.GetElementsByTagName("SeriousWarningsandPrecautions");
            //        rootnode.AppendChild(xnode[0]);
            //        for (int ar = 0; ar < swparray.Count; ar++)
            //        {
            //            XmlNode subnode = doc.CreateElement("row");
            //            xnode[0].AppendChild(subnode);

            //            string col1 = swparray[ar].ToString();
            //            XmlNode subsubnode = doc.CreateElement("column");
            //            subsubnode.AppendChild(doc.CreateTextNode(col1));
            //            subnode.AppendChild(subsubnode);
            //        }
            //    }
            //}
            //catch (Exception error)
            //{
            //    //lblError.Text = error.ToString();
            //    return null;
            //}

            helpers.Processes.ValidateAndSave(doc, rootnode, "SeriousWarningsandPrecautions", "", tbSeriousWarnings.Value, false);         

            #endregion
            #region Warnings and Precautions Headings
            try
            {
                XmlNodeList wph = doc.GetElementsByTagName("WarningHeadings");
                ArrayList headingddarray = new ArrayList();
                ArrayList headingtxtarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("dlHeadings") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbHeadings") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("dlHeadings"))
                    {
                        headingddarray.Add(swpitem);
                    }
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbHeadings"))
                    {
                        headingtxtarray.Add(swpitem);
                    }
                }

                if (wph.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("WarningHeadings");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    wph[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("WarningHeadings");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
               // lblError.Text = error.ToString();
                return null;
            }
            #endregion
            #region Adverse reactions
            try
            {
                #region Clinical trial adverse drug reactions table
                XmlNodeList roa = doc.GetElementsByTagName("AdverseReactionsTable");

                var clinicalTrialArray = new ArrayList();
                var drugNameArray = new ArrayList();
                var placeboArray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbClinicalTrial") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbDrugName") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbPlacebo") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbClinicalTrial"))
                    {
                        clinicalTrialArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbDrugName"))
                    {
                        drugNameArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbPlacebo"))
                    {
                        placeboArray.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("AdverseReactionsTable");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < clinicalTrialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = clinicalTrialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = drugNameArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = placeboArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("AdverseReactionsTable");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < clinicalTrialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = clinicalTrialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = drugNameArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = placeboArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }
            #endregion
            #region Dosage and administration
            try
            {
                XmlNodeList swp = doc.GetElementsByTagName("DosageConsiderations");
                ArrayList swparray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbDosageConsiderations") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbDosageConsiderations"))
                    {
                        swparray.Add(swpitem);
                    }
                }

                if (swp.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DosageConsiderations");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    swp[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("DosageConsiderations");
                    rootnode.AppendChild(xnode[0]);
                    for (int ar = 0; ar < swparray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = swparray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
              //  lblError.Text = error.ToString();
                return null;
            }
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageAdjustment", "", tbDosageAdjustment.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageMissed", "", tbDosageMissed.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageAdministration", "", tbDosageAdministration.Value, false);
            //helpers.Processes.ValidateAndSave(doc, rootnode, "DosageReconstitution", "", tbDosageReconstitution.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageOral", "", tbDosageOral.Value, false);
            try
            {
                #region DosageParenteralProducts
                XmlNodeList roa = doc.GetElementsByTagName("DosageParenteralProducts");

                var vialArray = new ArrayList();
                var volumeArray = new ArrayList();
                var approximateArray = new ArrayList();
                var nominaArray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbVial") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbVolume") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbApproximate") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbNominal") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbVial"))
                    {
                        vialArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbVolume"))
                    {
                        volumeArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbApproximate"))
                    {
                        approximateArray.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbNominal"))
                    {
                        nominaArray.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DosageParenteralProducts");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < vialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = vialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = volumeArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approximateArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = nominaArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("DosageParenteralProducts");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < vialArray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = vialArray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = volumeArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = approximateArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = nominaArray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
               // lblError.Text = error.ToString();
                return null;
            }
            #endregion
            #region Drug Interactions Headings
            try
            {
                XmlNodeList wph = doc.GetElementsByTagName("DrugInteractionsHeadings");
                ArrayList headingddarray = new ArrayList();
                ArrayList headingtxtarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("dlDrugHeadings") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbDrugHeadings") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("dlDrugHeadings"))
                    {
                        headingddarray.Add(swpitem);
                    }
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbDrugHeadings"))
                    {
                        headingtxtarray.Add(swpitem);
                    }
                }

                if (wph.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DrugInteractionsHeadings");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    wph[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("DrugInteractionsHeadings");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }
            #endregion
            try
            {
                #region Drug-drug interaction Table
                XmlNodeList roa = doc.GetElementsByTagName("DrugInteractionTable");
                var properNameList = new ArrayList();
                var refList = new ArrayList();
                var effectList = new ArrayList();
                var clinicaleList = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbProperName") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbRef") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbEffect") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbClinical") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbProperName"))
                    {
                        properNameList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbRef"))
                    {
                        refList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbEffect"))
                    {
                        effectList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbClinical"))
                    {
                        clinicaleList.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("DrugInteractionTable");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < properNameList.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = properNameList[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = refList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = effectList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = clinicaleList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("DrugInteractionTable");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < properNameList.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = properNameList[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = refList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = effectList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = clinicaleList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }
            #region Action and clinical pharmacology Headings
            try
            {
                XmlNodeList wph = doc.GetElementsByTagName("PharmacokineticsHeadings");
                ArrayList headingddarray = new ArrayList();
                ArrayList headingtxtarray = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("dlActionHeadings") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbActionHeadings") != null)
                {
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("dlActionHeadings"))
                    {
                        headingddarray.Add(swpitem);
                    }
                    foreach (string swpitem in HttpContext.Current.Request.Form.GetValues("tbActionHeadings"))
                    {
                        headingtxtarray.Add(swpitem);
                    }
                }

                if (wph.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("PharmacokineticsHeadings");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    wph[0].RemoveAll();
                    XmlNodeList xnode = doc.GetElementsByTagName("PharmacokineticsHeadings");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < headingddarray.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = headingddarray[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = headingtxtarray[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);
                    }
                }
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }

            try
            {
                #region Pharmacokinetics Table
                XmlNodeList roa = doc.GetElementsByTagName("Pharmacokinetics");
                var cmaxList = new ArrayList();
                var t12hList = new ArrayList();
                var aucList = new ArrayList();
                var clearanceList = new ArrayList();
                var volumeDisList = new ArrayList();
                if (HttpContext.Current.Request.Form.GetValues("tbCmax") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbT12h") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbAuc") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbClearance") != null &&
                    HttpContext.Current.Request.Form.GetValues("tbVolumeDis") != null)
                {
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbCmax"))
                    {
                        cmaxList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbT12h"))
                    {
                        t12hList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbAuc"))
                    {
                        aucList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbClearance"))
                    {
                        clearanceList.Add(item);
                    }
                    foreach (string item in HttpContext.Current.Request.Form.GetValues("tbVolumeDis"))
                    {
                        volumeDisList.Add(item);
                    }
                }

                if (roa.Count < 1)
                {
                    XmlNode xnode = doc.CreateElement("Pharmacokinetics");
                    rootnode.AppendChild(xnode);

                    for (int ar = 0; ar < cmaxList.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode.AppendChild(subnode);

                        string col1 = cmaxList[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = t12hList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = aucList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = clearanceList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = volumeDisList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);
                    }
                }
                else
                {
                    roa[0].RemoveAll();

                    XmlNodeList xnode = doc.GetElementsByTagName("Pharmacokinetics");
                    rootnode.AppendChild(xnode[0]);

                    for (int ar = 0; ar < cmaxList.Count; ar++)
                    {
                        XmlNode subnode = doc.CreateElement("row");
                        xnode[0].AppendChild(subnode);

                        string col1 = cmaxList[ar].ToString();
                        XmlNode subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col1));
                        subnode.AppendChild(subsubnode);

                        string col2 = t12hList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col2));
                        subnode.AppendChild(subsubnode);

                        string col3 = aucList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col3));
                        subnode.AppendChild(subsubnode);

                        string col4 = clearanceList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col4));
                        subnode.AppendChild(subsubnode);

                        string col5 = volumeDisList[ar].ToString();
                        subsubnode = doc.CreateElement("column");
                        subsubnode.AppendChild(doc.CreateTextNode(col5));
                        subnode.AppendChild(subsubnode);
                    }
                }
                #endregion
            }
            catch (Exception error)
            {
                // lblError.Text = error.ToString();
                return null;
            }



            #endregion
            helpers.Processes.ValidateAndSave(doc, rootnode, "Contraindications", "", tbContraindications.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Overdosage", "", tbOverdosage.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "MechanismAction", "", tbMechanismAction.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "Pharmacodynamics", "", tbPharmacodynamics.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialPopulationsConditions", "", tbSpecialPopulationsConditions.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "StorageStability", "", tbStorageStability.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "SpecialHandling", "", tbSpecialHandling.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "DosageCompositionPackaging", "", tbDosageCompositionPackaging.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTableReactionsTableNo", "", tbReactionsTableNo.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTableReactionsTableTitle", "", tbReactionsTableTitle.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTableDrugnameTitle", "", tbDrugnameTitle.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTableDrugnameNo", "", tbDrugnameNo.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTablePalcebo", "", tbPalcebo.Value, false);
            helpers.Processes.ValidateAndSave(doc, rootnode, "AdverseTablePalceboNo", "", tbPalceboNo.Value, false);

            SessionHelper.Current.draftForm = doc;
            return doc;
        }

        private void LoadFromXML()
        {
            XmlDocument xmldoc = SessionHelper.Current.draftForm;
            XDocument doc = XDocument.Parse(xmldoc.OuterXml);
            #region Summary product information -RouteOfAdmin
            XmlNodeList roa = xmldoc.GetElementsByTagName("RouteOfAdministration");
            if (roa.Count > 0)
            {
                var rows = from row in doc.Root.Elements("RouteOfAdministration").Descendants("row")
                           select new
                           {
                               columns = from column in row.Elements("column")
                                         select (string)column
                           };

                //bool ran = false;
                int rowcounter = 0;
                foreach (var row in rows)
                {
                    string[] colarray = "tbRouteOfAdminDynamic;tbDosageFormDynamic;tbStrengthDynamic;tbClinicallyRelevant".Split(';');
                    int colcounter = 0;
                    if (rowcounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbRouteOfAdminDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('route').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbRouteOfAdminDynamic option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else if (colarray[colcounter].Equals("tbDosageFormDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbDosageFormDynamic option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddRouteOfAdminTextBox('dataTable1');";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("tbRouteOfAdminDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('route').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbRouteOfAdminDynamic" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbRouteOfAdminDynamic" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else if (colarray[colcounter].Equals("tbDosageFormDynamic"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                "$(xmlcontolledlist).find('dosageform').each(function () {" +
                                                    "var $option = $(this).text();" +
                                                    "$('<option>' + $option + '</option>').appendTo('#tbDosageFormDynamic" + rowcounter.ToString() + "');" +
                                                "});" +
                                                "}).done(function () {" +
                                                    "$('#tbDosageFormDynamic" + rowcounter.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                             }
                            colcounter++;
                        }
                    }
                    rowcounter++;
                }                         
            }
            #endregion
            #region Contraindications
            //XmlNodeList con = xmldoc.GetElementsByTagName("Contraindications");
            //if (con.Count > 0)
            //{
            //    var rowsC = from rowcont in doc.Root.Elements("Contraindications").Descendants("row")
            //                select new
            //                {
            //                    columns = from column in rowcont.Elements("column")
            //                              select (string)column
            //                };

            //    bool ranC = false;
            //    int rowcounterC = 0;
            //    foreach (var rowC in rowsC)
            //    {
            //        if (!ranC)
            //        {
            //            string[] colarray = "tbContraindications".Split(';');
            //            int colcounter = 0;
            //            foreach (string columnC in rowC.columns)
            //            {
            //                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
            //                colcounter++;
            //            }
            //            ranC = true;
            //        }
            //        else
            //        {
            //            strscript += "AddContraindications();";
            //            string[] colarray = "tbContraindications".Split(';');
            //            int colcounter = 0;
            //            foreach (string columnC in rowC.columns)
            //            {
            //                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
            //                colcounter++;
            //            }
            //        }

            //        rowcounterC++;
            //    }                
            //}
            #endregion
            #region Warnings and precautions
            //XmlNodeList swp = xmldoc.GetElementsByTagName("SeriousWarningsandPrecautions");
            //if (swp.Count > 0)
            //{
            //    var rowsC = from rowcont in doc.Root.Elements("SeriousWarningsandPrecautions").Descendants("row")
            //                select new
            //                {
            //                    columns = from column in rowcont.Elements("column")
            //                              select (string)column
            //                };

            //    bool ranC = false;
            //    int rowcounterC = 0;

            //    foreach (var rowC in rowsC)
            //    {
            //        if (!ranC)
            //        {
            //            string[] colarray = "tbSeriousWarnings".Split(';');
            //            int colcounter = 0;
            //            foreach (string columnC in rowC.columns)
            //            {
            //                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
            //                colcounter++;
            //            }
            //            ranC = true;
            //        }
            //        else
            //        {
            //            strscript += "AddSeriousWarnings();";
            //            string[] colarray = "tbSeriousWarnings".Split(';');
            //            int colcounter = 0;
            //            foreach (string columnC in rowC.columns)
            //            {
            //                strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
            //                colcounter++;
            //            }
            //        }
            //        rowcounterC++;
            //    }
            //}

            XmlNodeList wph = xmldoc.GetElementsByTagName("WarningHeadings");
            if (wph.Count > 0)
            {
                #region Headings
                var rowsH = from rowcont in doc.Root.Elements("WarningHeadings").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int rowcounterH = 0;
                foreach (var row in rowsH)
                {
                    string[] colarray = "dlHeadings;tbHeadings".Split(';');
                    int colcounter = 0;
                    if (rowcounterH == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                  "$(xmlcontolledlist).find('warning').each(function () {" +
                                                      "var $option = $(this).text();" +
                                                      "$('<option>' + $option + '</option>').appendTo('#dlHeadings');" +
                                                  "});" +
                                                  "}).done(function () {" +
                                                      "$('#dlHeadings option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                  "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddHeadings();";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                   "$(xmlcontolledlist).find('warning').each(function () {" +
                                                       "var $option = $(this).text();" +
                                                       "$('<option>' + $option + '</option>').appendTo('#dlHeadings" + rowcounterH.ToString() + "');" +
                                                   "});" +
                                                   "}).done(function () {" +
                                                       "$('#dlHeadings" + rowcounterH.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                   "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                   rowcounterH++;
                }
                #endregion
            }
            #endregion
            #region Adverse reactions
            XmlNodeList adverse = xmldoc.GetElementsByTagName("AdverseReactionsTable");
            if (adverse.Count > 0)
            {
                #region AdverseReactionsTable Tables
                var adverseRows = from rowcont in doc.Root.Elements("AdverseReactionsTable").Descendants("row")
                                  select new
                                  {
                                      columns = from column in rowcont.Elements("column")
                                                select (string)column
                                  };

                int adverseRowCounter = 0;
                foreach (var row in adverseRows)
                {
                    string[] colarray = "tbClinicalTrial;tbDrugName;tbPlacebo".Split(';');
                    int colcounter = 0;
                    if (adverseRowCounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddAdverseReactionsTable('adverseReactionsTable');";
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + adverseRowCounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    adverseRowCounter++;
                }
                #endregion
            }
            #endregion
            #region Drug interactions
            XmlNodeList dih = xmldoc.GetElementsByTagName("DrugInteractionsHeadings");
            if (dih.Count > 0)
            {
                #region Drug Interactions Headings
                var rowsH = from rowcont in doc.Root.Elements("DrugInteractionsHeadings").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int rowcounterH = 0;
                foreach (var row in rowsH)
                {
                    string[] colarray = "dlDrugHeadings;tbDrugHeadings".Split(';');
                    int colcounter = 0;
                    if (rowcounterH == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlDrugHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                  "$(xmlcontolledlist).find('interactions').each(function () {" +
                                                      "var $option = $(this).text();" +
                                                      "$('<option>' + $option + '</option>').appendTo('#dlDrugHeadings');" +
                                                  "});" +
                                                  "}).done(function () {" +
                                                      "$('#dlDrugHeadings option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                  "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddDrugHeadings();";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlDrugHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                   "$(xmlcontolledlist).find('interactions').each(function () {" +
                                                       "var $option = $(this).text();" +
                                                       "$('<option>' + $option + '</option>').appendTo('#dlDrugHeadings" + rowcounterH.ToString() + "');" +
                                                   "});" +
                                                   "}).done(function () {" +
                                                       "$('#dlDrugHeadings" + rowcounterH.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                   "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    rowcounterH++;
                }
                #endregion
            }
            XmlNodeList drug = xmldoc.GetElementsByTagName("DrugInteractionTable");
            if (drug.Count > 0)
            {
                #region DrugInteractionTable Tables
                var drugRows = from rowcont in doc.Root.Elements("DrugInteractionTable").Descendants("row")
                               select new
                               {
                                   columns = from column in rowcont.Elements("column")
                                             select (string)column
                               };

                int drugRowCounter = 0;
                foreach (var row in drugRows)
                {
                    string[] colarray = "tbProperName;tbRef;tbEffect;tbClinical".Split(';');
                    int colcounter = 0;
                    if (drugRowCounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddDruginteractionTable('druginteractionTable');";
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + drugRowCounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    drugRowCounter++;
                }
                #endregion
            }

            #endregion
            #region DosageAdministration
            XmlNodeList dosage = xmldoc.GetElementsByTagName("DosageConsiderations");
            if (dosage.Count > 0)
            {
                #region DosageConsiderations
                var rowsC = from rowcont in doc.Root.Elements("DosageConsiderations").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                bool ranC = false;
                int rowcounterC = 0;

                foreach (var rowC in rowsC)
                {
                    string[] colarray = "tbDosageConsiderations".Split(';');
                    if (!ranC)
                    {
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                        ranC = true;
                    }
                    else
                    {
                        strscript += "AddDosageConsiderations();";
                        int colcounter = 0;
                        foreach (string columnC in rowC.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + rowcounterC.ToString() + "').val(\"" + helpers.Processes.CleanString(columnC) + "\");";
                            colcounter++;
                        }
                    }
                    rowcounterC++;
                }
                #endregion
            }

            XmlNodeList dpp = xmldoc.GetElementsByTagName("DosageParenteralProducts");
            if (dpp.Count > 0)
            {
                #region DosageParenteralProducts Tables
                var dppRows = from rowcont in doc.Root.Elements("DosageParenteralProducts").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int dppRowCounter = 0;
                foreach (var row in dppRows)
                {
                    string[] colarray = "tbVial;tbVolume;tbApproximate;tbNominal".Split(';');
                    int colcounter = 0;
                    if (dppRowCounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddParenteralProducts('dataTable2');";
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + dppRowCounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    dppRowCounter++;
                }
                #endregion
            }
            #endregion
            #region Action and clinical pharmacology
            XmlNodeList ph = xmldoc.GetElementsByTagName("PharmacokineticsHeadings");
            if (ph.Count > 0)
            {
                #region Pharmacokinetics Headings
                var rowsH = from rowcont in doc.Root.Elements("PharmacokineticsHeadings").Descendants("row")
                            select new
                            {
                                columns = from column in rowcont.Elements("column")
                                          select (string)column
                            };

                int rowcounterH = 0;
                foreach (var row in rowsH)
                {
                    string[] colarray = "dlActionHeadings;tbActionHeadings".Split(';');
                    int colcounter = 0;
                    if (rowcounterH == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlActionHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                  "$(xmlcontolledlist).find('kinetics').each(function () {" +
                                                      "var $option = $(this).text();" +
                                                      "$('<option>' + $option + '</option>').appendTo('#dlActionHeadings');" +
                                                  "});" +
                                                  "}).done(function () {" +
                                                      "$('#dlActionHeadings option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                  "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddActionHeadings();";
                        foreach (string column in row.columns)
                        {
                            if (colarray[colcounter].Equals("dlActionHeadings"))
                            {
                                strscript += "$.get('ControlledList.xml', function (xmlcontolledlist) {" +
                                                   "$(xmlcontolledlist).find('interactions').each(function () {" +
                                                       "var $option = $(this).text();" +
                                                       "$('<option>' + $option + '</option>').appendTo('#dlActionHeadings" + rowcounterH.ToString() + "');" +
                                                   "});" +
                                                   "}).done(function () {" +
                                                       "$('#dlActionHeadings" + rowcounterH.ToString() + " option').each(function () { if ($(this).html() == '" + column + "') { $(this).attr('selected', 'selected'); return; } });" +
                                                   "});";
                            }
                            else
                            {
                                strscript += "$('#" + colarray[colcounter] + rowcounterH.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            }
                            colcounter++;
                        }
                    }
                    rowcounterH++;
                }
                #endregion
            }
            XmlNodeList phar = xmldoc.GetElementsByTagName("Pharmacokinetics");
            if (phar.Count > 0)
            {
                #region Pharmacokinetics Tables
                var pharRows = from rowcont in doc.Root.Elements("Pharmacokinetics").Descendants("row")
                               select new
                               {
                                   columns = from column in rowcont.Elements("column")
                                             select (string)column
                               };

                int pharRowCounter = 0;
                foreach (var row in pharRows)
                {
                    string[] colarray = "tbCmax;tbT12h;tbAuc;tbClearance;tbVolumeDis".Split(';');
                    int colcounter = 0;
                    if (pharRowCounter == 0)
                    {
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    else
                    {
                        strscript += "AddPharmacokineticsTable('pharmacokineticsTable');";
                        foreach (string column in row.columns)
                        {
                            strscript += "$('#" + colarray[colcounter] + pharRowCounter.ToString() + "').val(\"" + helpers.Processes.CleanString(column) + "\");";
                            colcounter++;
                        }
                    }
                    pharRowCounter++;
                }
                #endregion
            }

            #endregion
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "LoadEventsScript", strscript.ToString(), true);

            var xmldata = from item in doc.Elements("ProductMonographTemplate")
                          select new
                          {
                              BrandNameIndicatedFor = (string)item.Element("BrandNameIndicatedFor"),
                              GeriatricsAge = (string)item.Element("GeriatricsAge"),
                              Geriatrics = (string)item.Element("Geriatrics"),
                              PediatricsAgeX = (string)item.Element("PediatricsAgeX"),
                              PediatricsAgeY = (string)item.Element("PediatricsAgeY"),
                              PediatricsAgeZ = (string)item.Element("PediatricsAgeZ"),
                              Pediatrics = (string)item.Element("Pediatrics"),                             
                              DosageAdjustment = (string)item.Element("DosageAdjustment"),
                              DosageMissed = (string)item.Element("DosageMissed"),
                              DosageAdministration = (string)item.Element("DosageAdministration"),
                              DosageReconstitution = (string)item.Element("DosageReconstitution"),
                              DosageOral = (string)item.Element("DosageOral"),
                              Overdosage = (string)item.Element("Overdosage"),
                              MechanismAction = (string)item.Element("MechanismAction"),
                              Pharmacodynamics = (string)item.Element("Pharmacodynamics"),
                              SpecialPopulationsConditions = (string)item.Element("SpecialPopulationsConditions"),
                              StorageStability = (string)item.Element("StorageStability"),
                              SpecialHandling = (string)item.Element("SpecialHandling"),
                              DosageCompositionPackaging = (string)item.Element("DosageCompositionPackaging"),
                              AdverseReactions = (string)item.Element("AdverseReactions"),
                              AdverseDrugReactions = (string)item.Element("AdverseDrugReactions"),
                              AdverseReactionsSupplement = (string)item.Element("AdverseReactionsSupplement"),
                              AdverseTableReactionsTableNo = (string)item.Element("AdverseTableReactionsTableNo"),
                              AdverseTableReactionsTableTitle = (string)item.Element("AdverseTableReactionsTableTitle"),
                              AdverseTableDrugnameTitle = (string)item.Element("AdverseTableDrugnameTitle"),
                              AdverseTableDrugnameNo = (string)item.Element("AdverseTableDrugnameNo"),
                              AdverseTablePalcebo = (string)item.Element("AdverseTablePalcebo"),
                              AdverseTablePalceboNo = (string)item.Element("AdverseTablePalceboNo"),
                              DrugInteractions = (string)item.Element("DrugInteractions"),
                              SeriousDrugInteractions = (string)item.Element("SeriousDrugInteractions"),
                              SpecialGeriatricsAge = (string)item.Element("SpecialGeriatricsAge"),
                              SpecialGeriatrics = (string)item.Element("SpecialGeriatrics"),
                              SpecialPediatricsAgeX = (string)item.Element("SpecialPediatricsAgeX"),
                              SpecialPediatricsAgeY = (string)item.Element("SpecialPediatricsAgeY"),
                              SpecialPediatricsAgeZ = (string)item.Element("SpecialPediatricsAgeZ"),
                              SpecialPediatrics = (string)item.Element("SpecialPediatrics"),
                              WarningsPregnant = (string)item.Element("WarningsPregnant"),
                              WarningsNursing = (string)item.Element("WarningsNursing"),
                              WarningsMonitoring = (string)item.Element("WarningsMonitoring"),
                              SeriousWarningsandPrecautions = (string)item.Element("SeriousWarningsandPrecautions"),
                              Contraindications = (string)item.Element("Contraindications"),
                          };
            foreach (var xmldataitem in xmldata)
            {
                tbbrandName.Value = xmldataitem.BrandNameIndicatedFor;
                tbGeriatricsAge.Value = xmldataitem.GeriatricsAge;
                tbGeriatrics.Value = xmldataitem.Geriatrics;
                tbPediatricsAgeX.Value = xmldataitem.PediatricsAgeX;
                tbPediatricsAgeY.Value = xmldataitem.PediatricsAgeY;
                tbPediatricsAgeZ.Value = xmldataitem.PediatricsAgeZ;
                tbPediatrics.Value = xmldataitem.Pediatrics;
                tbDosageAdministration.Value = xmldataitem.DosageAdministration;
                tbDosageOral.Value = xmldataitem.DosageOral;
                tbDosageMissed.Value = xmldataitem.DosageMissed;
                tbDosageAdjustment.Value = xmldataitem.DosageAdjustment;
                tbOverdosage.Value = xmldataitem.Overdosage;
                tbMechanismAction.Value = xmldataitem.MechanismAction;
                tbPharmacodynamics.Value = xmldataitem.Pharmacodynamics;
                tbSpecialPopulationsConditions.Value = xmldataitem.SpecialPopulationsConditions;
                tbStorageStability.Value = xmldataitem.StorageStability;
                tbSpecialHandling.Value = xmldataitem.SpecialHandling;
                tbDosageCompositionPackaging.Value = xmldataitem.DosageCompositionPackaging;
                tbAdverseReactions.Value = xmldataitem.AdverseReactions;
                tbAdverseReactions.Value = xmldataitem.AdverseDrugReactions;
                tbAdverseReactionsSupplement.Value = xmldataitem.AdverseReactionsSupplement;
                tbReactionsTableNo.Value = xmldataitem.AdverseTableReactionsTableNo;
                tbReactionsTableTitle.Value = xmldataitem.AdverseTableReactionsTableTitle;
                tbDrugnameTitle.Value = xmldataitem.AdverseTableDrugnameTitle;
                tbDrugnameNo.Value = xmldataitem.AdverseTableDrugnameNo;
                tbPalcebo.Value = xmldataitem.AdverseTablePalcebo;
                tbPalceboNo.Value = xmldataitem.AdverseTablePalceboNo;
                tbDrugInteractions.Value = xmldataitem.DrugInteractions;
                tbSeriousDrugInteractions.Value = xmldataitem.SeriousDrugInteractions;
                tbSeriousWarnings.Value = xmldataitem.SeriousWarningsandPrecautions;
                tbContraindications.Value = xmldataitem.Contraindications;
                //tbSpecialPediatricsAgeX.Value = xmldataitem.SpecialPediatricsAgeX;
                //tbSpecialPediatricsAgeY.Value = xmldataitem.SpecialPediatricsAgeY;
                //tbSpecialPediatricsAgeZ.Value = xmldataitem.SpecialPediatricsAgeZ;
                //tbSpecialPediatrics.Value = xmldataitem.SpecialPediatrics;
                //tbPregnant.Value = xmldataitem.WarningsPregnant;
                //tbNursing.Value = xmldataitem.WarningsNursing;
                //tbMonitoring.Value = xmldataitem.WarningsMonitoring;
            }
        }
    }
}

