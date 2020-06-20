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
    public partial class excel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
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
                        string sqlStr = "insert into Finance(no,num,rate,storageCost,advertisementCost,commission,returnCost)values";
                        sqlStr += "('" + row.GetCell(0) + "',";
                        sqlStr += "'" + row.GetCell(1) + "',";
                        sqlStr += "'" + row.GetCell(2) + "',";
                        sqlStr += "'" + row.GetCell(3) + "',";
                        sqlStr += "'" + row.GetCell(4) + "',";
                        sqlStr += "'" + row.GetCell(5) + "',";
                        sqlStr += "'" + row.GetCell(6) + "')";
                        //sheet = workbook.GetSheet("sheet1") as HSSFSheet;
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
    }
}