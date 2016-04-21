using System;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Web;
using System.Xml;

namespace Product_Monograph.helpers
{
    public class Common
    {
        public const string strXmlExtension = ".xml";
        public const string strZipExtension = ".zip";
        private string strSaveFileName { get; set; }

        public Common(string xmlFileName)
        {
            if (string.IsNullOrWhiteSpace(xmlFileName))
            {
                strSaveFileName = "DraftPMForm";
            }
            else
            {
                strSaveFileName = xmlFileName;
            }
        }

        public void SaveXmlFile(XmlDocument doc)
        {
            byte[] bytes = Encoding.Default.GetBytes(doc.OuterXml);

            using (var compressedFileStream = new MemoryStream())
            {
               using (var zipArchive = new ZipArchive(compressedFileStream, ZipArchiveMode.Update, true))                                                                                                             
                {
                    if (doc != null)
                    {
                        var zipEntry = zipArchive.CreateEntry(strSaveFileName + strXmlExtension);
                        using (var originalFileStream = new MemoryStream(bytes))
                        {
                            using (var zipEntryStream = zipEntry.Open())
                            {
                                originalFileStream.CopyTo(zipEntryStream);
                            }
                        }
                    }
                }

                var buffer = compressedFileStream.ToArray();   //bug here -- note by Ching
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ClearHeaders();
                if (buffer.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/zip";
                    HttpContext.Current.Response.BinaryWrite(buffer);
                    var fileName = strSaveFileName + strZipExtension;
                    HttpContext.Current.Response.AddHeader("content-disposition", string.Format(@"attachment;filename=""{0}""", fileName));
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
    }

}