using clsBuiness;
using SDZdb;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EasyUI
{
    public partial class CQU_CHM_ShowImage : System.Web.UI.Page
    {
        clsAllnew BusinessHelp = new clsAllnew();

        protected void Page_Load(object sender, EventArgs e)
        {
            //int chm_rowid = Convert.ToInt32(Request.QueryString["chm_rowid"].ToString());

            ////string imageNo = Request.QueryString["imageNo"];

            //CHMPropertyBLL _CHMPropertyBLL = new CHMPropertyBLL();

            //DataTable dt = _CHMPropertyBLL.GetByPrimaryKey(chm_rowid);
            string QiHao = Request.QueryString["QiHao"];

            string sql2 = "select * from Detailed where   id='" + QiHao + "'";

            List<clt_detail_info> readCards = BusinessHelp.Readt_PICServer(sql2);

            if (readCards.Count > 0 && readCards[0].imagebytes != null)
            {
                MemoryStream stream = new MemoryStream();

                byte[] image = readCards[0].imagebytes;

                stream.Write(image, 0, image.Length);

                Bitmap bitmap = new Bitmap(stream);

                Response.ContentType = "image/jpeg";

                bitmap.Save(Response.OutputStream, ImageFormat.Jpeg);

                stream.Close();

            }



        }
    }
}