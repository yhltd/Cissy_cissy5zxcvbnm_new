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
            sReturnJson=getSingleData();
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
        string id = ParamsofEasyUI.RequstString("id");
        string sqlexe = @"select id,no, grouping, name, cost, buyer, sale, length, width, high, weight, pack from Product where id=" + id + "";
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
                sWhere = " where no like '%" + stitle + "%'";
        }
        //sqlexe = @"select top 10 ID,title,addTime from (select top 20 * from Product " + PID + " order by [addTime] DESC,ID desc) as a";
        sqlexe = @"select id, no, grouping, name, cost, buyer, sale, length, width, high, weight, pack from Product " + sWhere + " order by " + sort + " " + order;
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onDataGrid(dt, page, rows);
    }
    
    //删除
    private string delete()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("id");
        string sqlexe = string.Format("delete from Product where id in ({0})", id);
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
        string no = ParamsofEasyUI.RequstForm("no");
        string grouping = ParamsofEasyUI.RequstForm("grouping");
        string name = ParamsofEasyUI.RequstForm("name");
        string cost = ParamsofEasyUI.RequstForm("cost");
        string buyer = ParamsofEasyUI.RequstForm("buyer");
        string sale = ParamsofEasyUI.RequstForm("sale");
        string length = ParamsofEasyUI.RequstForm("length");
        string width = ParamsofEasyUI.RequstForm("width");
        string high = ParamsofEasyUI.RequstForm("high");
        string weight = ParamsofEasyUI.RequstForm("weight");
        string pack = ParamsofEasyUI.RequstForm("pack");
        string sqlexe = string.Empty;
        if (id.Length > 0)
        {
            sqlexe = string.Format("update Product set no='{0}',grouping='{1}',name='{2}',cost='{3}',buyer='{4}',sale='{5}',length='{6}',width='{7}',high='{8}',weight='{9}',pack='{10}' where id={11}",
   no, grouping, name, cost, buyer, sale, length, width, high, weight, pack, Convert.ToInt32(id));
            if (SqlHelper.ExecuteUpdate(sqlexe))
                sReturnJson = "{success:true}";
            else
                sReturnJson = "{success:false}";
        }
        else
        {
            sqlexe = string.Format("insert Into Product (no, grouping, name, cost, buyer, sale, length, width, high, weight, pack) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}')",
               no, grouping, name, cost, buyer, sale, length, width, high, weight, pack);
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