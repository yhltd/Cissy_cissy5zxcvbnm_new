<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string sReturnJson = string.Empty;
        string sqlexe = string.Empty;
        string action = ParamsofEasyUI.RequstString("action");
        switch (action)
        {
            case "save":
                sReturnJson = save();
                break;
            case "del":
                sReturnJson = delete();
                break;

            //列表
            case "list":
            //查询
            case "query":
                sReturnJson = getData(action);
                break;

            case "get":
                sReturnJson = getSingleData();
                break;
            default:
                break;
        }
        context.Response.Write(sReturnJson);
    }

    /// <summary>
    /// 编辑前的查找
    /// </summary>
    /// <returns></returns>
    private string getSingleData()
    {
        string id = ParamsofEasyUI.RequstString("ID");
        //string sqlexe = @"select id, account,convert(varchar(10),datepart(YYYY,saleDate)) as years, convert(varchar(10),datepart(mm,saleDate)) as months,convert(varchar(10),datepart(dd,saleDate)) as days,type,sunSKU,quantity,fulfillment,city,state,sales,total from Sales where ID=" + id + "";
        string sqlexe = @"select id, account,convert(char(20),saleDate,120) as saleDate,type,sunSKU,quantity,fulfillment,city,state,sales,total from Sales where ID=" + id + "";
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onForm(dt);//{"ID":"25","Column1":"22221","Column2":"33331","Column3":"44441"}
    }

    //查询
    private string getData(string action)
    {

        string order = ParamsofEasyUI.order;
        string sort = ParamsofEasyUI.sort;
        int page = ParamsofEasyUI.page;
        int rows = ParamsofEasyUI.rows;

        string sWhere = string.Empty;
        string sqlexe = string.Empty;
        if (action.Equals("list"))
        {
            string PID = ParamsofEasyUI.RequstString("PID");
            if (!string.IsNullOrEmpty(PID))
            {
                sWhere = " where [parent]= '" + PID + "'";
                page = 1;
            }
        }
        else if (action.Equals("query"))
        {
            string stitle = ParamsofEasyUI.RequstString("title");
            if (!string.IsNullOrEmpty(stitle))
                sWhere = " where sunSKU like '%" + stitle + "%'";
        }
        //sqlexe = @"select top 10 ID,title,addTime from (select top 20 * from product " + PID + " order by [addTime] DESC,ID desc) as a";
        sqlexe = @"select id,account,saleDate,type,sunSKU,quantity,fulfillment,city,state,sales,total from Sales " + sWhere + " order by " + sort + " " + order;
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onDataGrid(dt, page, rows);
    }

    //删除
    private string delete()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("ID");
        string sqlexe = string.Format("delete from Sales where id in ({0})", id);
        if (SqlHelper.ExecuteUpdate(sqlexe))
            sReturnJson = "{success:true}";
        else
            sReturnJson = "{success:false}";
        return sReturnJson;
    }

    //保存或添加
    private string save()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("id");
        string account = ParamsofEasyUI.RequstForm("account");
        string saleDate = ParamsofEasyUI.RequstForm("saleDate");
        string type = ParamsofEasyUI.RequstForm("type");
        string sunSKU = ParamsofEasyUI.RequstForm("sunSKU");
        string quantity = ParamsofEasyUI.RequstForm("quantity");
        string fulfillment = ParamsofEasyUI.RequstForm("fulfillment");
        string city = ParamsofEasyUI.RequstForm("city");
        string state = ParamsofEasyUI.RequstForm("state");
        string sales = ParamsofEasyUI.RequstForm("sales");
        string total = ParamsofEasyUI.RequstForm("total");
        //string years = ParamsofEasyUI.RequstForm("years"); string months = ParamsofEasyUI.RequstForm("months"); string days = ParamsofEasyUI.RequstForm("days");
        string sqlexe = string.Empty;
        if (id.Length > 0)
        {
            sqlexe = string.Format("update Sales set account='{0}',saleDate='{1}',type='{2}',sunSKU='{3}',quantity='{4}',fulfillment='{5}',city='{6}',state='{7}',sales='{8}',total='{9}' where id={10}",
  account, saleDate, type, sunSKU, quantity, fulfillment, city, state, sales, total, Convert.ToInt32(id));
            if (SqlHelper.ExecuteUpdate(sqlexe))
                sReturnJson = "{success:true}";
            else
                sReturnJson = "{success:false}";
        }
        else
        {
            sqlexe = string.Format("insert Into Sales (account, saleDate, type, sunSKU, quantity, fulfillment, city, state, sales, total) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}')",
               account, saleDate, type, sunSKU, quantity, fulfillment, city, state, sales, total);
            if (SqlHelper.ExecuteUpdate(sqlexe))
                sReturnJson = "{success:true}";
            else
                sReturnJson = "{success:false,msg:'保存信息失败'}";
        }
        return sReturnJson;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}