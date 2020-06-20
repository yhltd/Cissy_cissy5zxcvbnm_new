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

namespace EasyUI
{
    public partial class no_xiaoshouluru : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private string fileName = null; //文件名
        private IWorkbook workbook = null;
        private FileStream fs = null;
        public void Export_Click(object sender, EventArgs e)
        {
            ISheet sheet = null;
            string fileName = fileId.FileName;
            string savePath = Server.MapPath("~/file/");
            fileId.SaveAs(savePath + fileName);
            fs = new FileStream(savePath + fileName, FileMode.OpenOrCreate, FileAccess.ReadWrite); //Path.GetDirectoryName();
            string str1111 = fileId.PostedFile.FileName;
            string str1 = Path.GetFullPath(fileId.PostedFile.FileName);
            string str2 = fileId.PostedFile.FileName;


            if (fileName.IndexOf(".xlsx") > 0) // 2007版本
                workbook = new XSSFWorkbook(fs);
            else if (fileName.IndexOf(".xls") > 0) // 2003版本
                workbook = new HSSFWorkbook(fs);
            if (workbook != null)
            {
                SqlConnection conn = new SqlConnection("Data Source=sqloledb;server=yhocn.cn;Database=Cissy;Uid=sa;Pwd=Lyh07910_001;");  //数据库连接。
                conn.Open();
                SqlTransaction str = conn.BeginTransaction();//利用事务处理 防止中断  
                int k = 0;
                sheet = workbook.GetSheet("Sheet1");
                try
                {
                    if (sheet != null)
                    {
                        Console.WriteLine(1);
                    }
                    for (int i = 0; i < sheet.LastRowNum; i++)
                    {

                        IRow row = sheet.GetRow(i + 1);
                        string sqlStr = "insert into Sale(account,smallGroup,saler,type,asin,sunSKU,name,fatherSKU,FBA,three,thirty,)values";
                        sqlStr += "('" + row.GetCell(0) + "',";
                        sqlStr += "'" + row.GetCell(1) + "',";
                        sqlStr += "'" + row.GetCell(2) + "',";
                        sqlStr += "'" + row.GetCell(3) + "',";
                        sqlStr += "'" + row.GetCell(4) + "',";
                        sqlStr += "'" + row.GetCell(5) + "',";
                        sqlStr += "'" + row.GetCell(6) + "',";
                        sqlStr += "'" + row.GetCell(7) + "',";
                        sqlStr += "'" + row.GetCell(8) + "',";
                        sqlStr += "'" + row.GetCell(9) + "',";
                        sqlStr += "'" + row.GetCell(10) + "')";
                        //sheet = workbook.GetSheet("sheet1") as HSSFSheet;
                        if (i == 0)
                        {
                            sqlStr = "truncate table Product;" + sqlStr;
                        }
                        SqlCommand cmd = new SqlCommand(sqlStr, conn, str);
                        cmd.Transaction = str;
                        k += cmd.ExecuteNonQuery();
                    }
                    str.Commit();
                }
                catch (Exception ex)
                {
                    Response.Write("发生异常,数据已回滚/n信息/n" + ex.Message);
                    str.Rollback();
                }
                finally
                {
                    Response.Write("上传成功" + k + "条");
                    //File.Delete(filePath);
                }

            }
        }
        //public void Export_Click1(object sender, EventArgs e)
        //{
        //    if (GridView1.Rows.Count > 0)
        //    {
        //        //调用导出方法  
        //        ExportGridViewForUTF8(GridView1, DateTime.Now.ToShortDateString() + ".xls");
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
        //    Response.Charset = "utf-8";
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






        //2020.6.20老板的代码，可以解决excel导出中文乱码问题
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }
        protected void Export_Click1(object sender, EventArgs e)
        {
            //bind();
            //toExcel(gvList);
            Response.Clear();
            string fileName = "System  Info" + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

            Response.AddHeader("content-disposition",

            "attachment;filename=" + fileName);

            Response.Charset = "";

            // If you want the option to open the Excel file without saving than

            // comment out the line below

            // Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.ContentType = "application/vnd.xlsx";

            System.IO.StringWriter stringWrite = new System.IO.StringWriter();

            System.Web.UI.HtmlTextWriter htmlWrite =
            new HtmlTextWriter(stringWrite);

            // turn off paging 
            GridView1.AllowPaging = false;
            //bind();


            GridView1.RenderControl(htmlWrite);

            Response.Write(stringWrite.ToString());

            Response.End();

            // turn the paging on again 
            GridView1.AllowPaging = true;
            //bind();

        }
    }
}