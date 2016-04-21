using System;
using System.Text;
using System.Web;
using System.Xml;

namespace Product_Monograph.helpers
{
    public class Processes
    {
        public const string strXmlExtension = ".xml";
        public const string strZipExtension = ".zip";
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

        public static class ResourceHelpers
        {
            public static IHtmlString WrapTextBlockIntoParagraphs(string s)
            {
                if (s == null) return new HtmlString(string.Empty);

                var blocks = s.Split(new string[] { "\r\n", "\n" },
                                      StringSplitOptions.RemoveEmptyEntries);

                StringBuilder htmlParagraphs = new StringBuilder();
                foreach (string block in blocks)
                {
                    htmlParagraphs.Append("<p>" + block + "</p>");
                }

                return new HtmlString(htmlParagraphs.ToString());
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