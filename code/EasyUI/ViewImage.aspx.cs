using clsBuiness;
using SDZdb;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EasyUI
{
    public partial class ViewImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                clsAllnew BusinessHelp = new clsAllnew();
                string QiHao = Request.QueryString["QiHao"];


                string sql2 = "select * from Detailed where   id='" + QiHao + "'";

                List<clt_detail_info> readCards = BusinessHelp.Readt_PICServer(sql2);


                if (readCards.Count > 0 && readCards[0].imagebytes != null)
                {
                    MemoryStream imageBytes = new MemoryStream(readCards[0].imagebytes);

                    ////System.Drawing.Bitmap image = (Bitmap)BusinessHelp.Base64ToImage(imageBytes);
                    //System.Drawing.Bitmap image = new Bitmap(imageBytes);
                    //System.IO.MemoryStream MStream = new System.IO.MemoryStream();
                    //image.Save(MStream, System.Drawing.Imaging.ImageFormat.Gif);
                    //Response.ClearContent();
                    Response.ContentType = "image/Gif";
                    //Response.BinaryWrite(MStream.ToArray());
                    Response.BinaryWrite(readCards[0].imagebytes);
                }
            }
        }
    }
}