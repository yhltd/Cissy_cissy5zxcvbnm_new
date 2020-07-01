using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.SessionState;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Web.Caching;
using clsBuiness;
using SDZdb;
using System.Threading;
using System.Windows.Forms;


namespace EasyUI
{
    public partial class _01shejibiao : System.Web.UI.Page
    {

        private string fileName = null; //文件名
        private IWorkbook workbook = null;
        private FileStream fs = null;
        private string fileName1 = null; //图片文件名

        List<clt_detail_info> readCards;
        clsAllnew BusinessHelp = new clsAllnew();

        string id;

        protected void Page_Load(object sender, EventArgs e)
        {
            InitialSystemInfo();
            HttpCookie cookie = new HttpCookie("img_id");
            HttpCookie cookie1 = new HttpCookie("img_id1");
        }

        private void InitialSystemInfo()
        {
            readCards = new List<clt_detail_info>();
            //FileStream fs;
            //string file = @"C:\" + DateTime.Now.ToString("yyyyMMddHHmmssff") + ".BMP";

            //fs = new FileStream(file, FileMode.OpenOrCreate, FileAccess.Write);

            for (int i = 0; i < 100; i++)
            {
                clt_detail_info item = new clt_detail_info();

                item.Order_id = i.ToString();
                item.num = "nmm" + i.ToString();
                item.no = "no" + i.ToString();
                #region 绑定图片列 HTTP
                //string mdbpath2_Ctirx = AppDomain.CurrentDomain.BaseDirectory + "\\116ae547bbc0baa3528d6b3f81cb7812.jpg";//记录 Status  click 和选择哪个服务器
                //mdbpath2_Ctirx = "https://images.cnblogs.com/cnblogs_com/dylanwind/Photo.PNG";

                //item.image_path = mdbpath2_Ctirx;


                //string sql2 = "select * from Detailed where   id='" + item.Order_id + "'";

                //List<clt_detail_info> readCards1 = BusinessHelp.Readt_PICServer(sql2);



                //if (readCards1.Count > 0 && readCards1[0].imagebytes != null)
                //{
                //    file = @"C:\" + DateTime.Now.ToString("yyyyMMddHHmmssff") + ".BMP";

                //    fs = new FileStream(file, FileMode.OpenOrCreate, FileAccess.Write);
                //    fs.Write(readCards1[0].imagebytes, 0, readCards1[0].imagebytes.GetUpperBound(0));

                //    item.image_path = file;
                //} 
                #endregion
                readCards.Add(item);


            }
            //fs.Close();

            //不绑定dav 

        }


        //添加图片功能
        protected void btnAddAttach_Click(object sender, EventArgs e)
        {            
            string id = HttpContext.Current.Request.Cookies["img_id"].Value;
            int size = fileUpload.PostedFile.ContentLength;  //大小，可以判断是否获取到了文件
            string path = Server.MapPath("~/file/");
            string image64 = "";
            string filename = System.IO.Path.GetFileName(fileUpload.PostedFile.FileName);
            string wanzheng = path + filename;
            fileUpload.SaveAs(wanzheng);
            //string DirectoryName = Path.GetFullPath(fileUpload.PostedFile.FileName);
            //string fileNameNo = Path.GetFileName(fileUpload.PostedFile.FileName);
            //clsAllnew BusinessHelp = new clsAllnew();
            //if (File.Exists(DirectoryName))
            //{
            //    image64 = BusinessHelp.ImgToBase64String(DirectoryName);
            //}

            if (System.IO.File.Exists(wanzheng))
            {
                image64 = BusinessHelp.ImgToBase64String(wanzheng);
            }
            
            List<clt_detail_info> cloumnlist = readCards.FindAll(s => s.Order_id != null && s.Order_id == id);
            cloumnlist[0].img = image64;
            cloumnlist[0].FFileName = filename;
            BusinessHelp.createPIC_info_Server(cloumnlist);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", );
            string script = "<script>alert('添加成功')</script>";
            Response.Write(script);

        }




        //public void show_Image(string id) 
        //{
        //    string idd = this.id;
        //    string script = "<script>alert('" + idd + "')</scritp>";
        //    Response.Write(script);
        //    Response.Redirect("~/ViewImage.aspx?id=" + idd);
        //}
        


        //excel导入导出
        //public void Export_Click1(object sender, EventArgs e)
        //{
        //    if (GridView1.Rows.Count > 0)
        //    {
        //        //调用导出方法  
        //        ExportGridViewForUTF8(GridView1, DateTime.Now.ToShortDateString() + ".xlsx");
        //    }
        //    else
        //    {
        //    }
        //}

        //private void ExportGridViewForUTF8(GridView GridView, string filename)
        //{
        //    string attachment = "attachment; filename=" + filename;
        //    Response.ClearContent();
        //    Response.Buffer = true;
        //    Response.AddHeader("content-disposition", attachment);
        //    Response.Charset = "GB2312";
        //    Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        //    Response.ContentType = "application/vnd.ms-excel";
        //    System.IO.StringWriter sw = new System.IO.StringWriter();
        //    HtmlTextWriter htw = new HtmlTextWriter(sw);
        //    GridView.RenderControl(htw);
        //    Response.Charset = null;
        //    Response.Output.Write(sw);
        //    Response.Flush();
        //    Response.End();
        //}
        //public override void VerifyRenderingInServerForm(Control control)
        //{
        //    //base.VerifyRenderingInServerForm(control);
        //}












        //public void Export_Click(object sender, EventArgs e)
        //{
        //    ISheet sheet = null;
        //    string fileName = fileId.FileName;
        //    string savePath = Server.MapPath("~/file/");
        //    fileId.SaveAs(savePath + fileName);
        //    fs = new FileStream(savePath + fileName, FileMode.OpenOrCreate, FileAccess.ReadWrite); //Path.GetDirectoryName();
        //    string str1111 = fileId.PostedFile.FileName;
        //    string str1 = Path.GetFullPath(fileId.PostedFile.FileName);
        //    string str2 = fileId.PostedFile.FileName;


        //    if (fileName.IndexOf(".xlsx") > 0) // 2007版本
        //        workbook = new XSSFWorkbook(fs);
        //    else if (fileName.IndexOf(".xls") > 0) // 2003版本
        //        workbook = new HSSFWorkbook(fs);
        //    if (workbook != null)
        //    {
        //        SqlConnection conn = new SqlConnection("Data Source=sqloledb;server=yhocn.cn;Database=Cissy;Uid=sa;Pwd=Lyh07910_001;");  //数据库连接。
        //        conn.Open();
        //        SqlTransaction str = conn.BeginTransaction();//利用事务处理 防止中断  
        //        int k = 0;
        //        sheet = workbook.GetSheet("Sheet1");
        //        try
        //        {
        //            if (sheet != null)
        //            {
        //                Console.WriteLine(1);
        //            }
        //            for (int i = 0; i < sheet.LastRowNum; i++)
        //            {
        //                IRow row = sheet.GetRow(i + 1);
        //                string sqlStr = "insert into Product(no,grouping,name,cost,buyer,sale,length,width,high,weight,pack)values";
        //                sqlStr += "('" + row.GetCell(0) + "',";
        //                sqlStr += "'" + row.GetCell(1) + "',";
        //                sqlStr += "'" + row.GetCell(2) + "',";
        //                sqlStr += "'" + row.GetCell(3) + "',";
        //                sqlStr += "'" + row.GetCell(4) + "',";
        //                sqlStr += "'" + row.GetCell(5) + "',";
        //                sqlStr += "'" + row.GetCell(6) + "',";
        //                sqlStr += "'" + row.GetCell(7) + "',";
        //                sqlStr += "'" + row.GetCell(8) + "',";
        //                sqlStr += "'" + row.GetCell(9) + "',";
        //                sqlStr += "'" + row.GetCell(10) + "')";
        //                //sheet = workbook.GetSheet("sheet1") as HSSFSheet;
        //                if (i == 0)
        //                {
        //                    sqlStr = "truncate table Product;" + sqlStr;
        //                }
        //                SqlCommand cmd = new SqlCommand(sqlStr, conn, str);
        //                cmd.Transaction = str;
        //                k += cmd.ExecuteNonQuery();
        //            }
        //            str.Commit();
        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("发生异常,数据已回滚/n信息/n" + ex.Message);
        //            str.Rollback();
        //        }
        //        finally
        //        {
        //            Response.Write("上传成功" + k + "条");
        //            //File.Delete(filePath);
        //        }

        //    }
        //}

        //2020.6.20老板的代码，可以解决excel导出中文乱码问题
        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }
        //protected void Export_Click1(object sender, EventArgs e)
        //{
        //    //bind();
        //    //toExcel(gvList);
        //    Response.Clear();
        //    string fileName = "System  Info" + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

        //    Response.AddHeader("content-disposition",

        //    "attachment;filename=" + fileName);

        //    Response.Charset = "";

        //    // If you want the option to open the Excel file without saving than

        //    // comment out the line below

        //    // Response.Cache.SetCacheability(HttpCacheability.NoCache);

        //    Response.ContentType = "application/vnd.xlsx";

        //    System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        //    System.Web.UI.HtmlTextWriter htmlWrite =
        //    new HtmlTextWriter(stringWrite);

        //    // turn off paging 
        //    GridView1.AllowPaging = false;
        //    //bind();


        //    GridView1.RenderControl(htmlWrite);

        //    Response.Write(stringWrite.ToString());

        //    Response.End();

        //    // turn the paging on again 
        //    GridView1.AllowPaging = true;
        //    //bind();

        //}
    }
}