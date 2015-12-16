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

namespace Product_Monograph.helpers
{
    public class Processes
    {
        public static void ValidateAndSave(XmlDocument doc, XmlNode rootnode, string element, string label, string textboxvalue, bool mandatory)
        {
            XmlNodeList xmlnode = doc.GetElementsByTagName(element);
            if (xmlnode.Count < 1)
            {
                CreateXMLElement(doc, rootnode, element, label, textboxvalue, mandatory);
            }
            else
            {
                xmlnode[0].InnerText = textboxvalue;
            }
        }

        public static string CleanString( string value)
        {
            return value = value.Replace("\"", "\\\"").Replace("\n","");
        }

        public static void CreateXMLElement(XmlDocument doc, XmlNode rootnode, string element, string label, string textboxvalue, bool mandatory)
        {
            if (mandatory)
            {
                if (textboxvalue.Trim() == string.Empty)
                {
                    //fields.Add(new Field() { FieldLabel = label, FieldID = "_div" });
                }
                else
                {
                    XmlNode xnode = doc.CreateElement(element);
                    xnode.AppendChild(doc.CreateTextNode(textboxvalue));
                    rootnode.AppendChild(xnode);
                }
            }
            else
            {
                XmlNode xnode = doc.CreateElement(element);
                xnode.AppendChild(doc.CreateTextNode(textboxvalue));
                rootnode.AppendChild(xnode);
            }
        }

        public static Object XMLDraft
        {
            get
            {
                return _xmldraft;
            }
            set
            {
                _xmldraft = value;

            }
        }

        static Object _xmldraft;

        public static string XMLPath
        {
            get { return _xmppath; }
            set { _xmppath = value; }
        }

        static string _xmppath;
    }
}