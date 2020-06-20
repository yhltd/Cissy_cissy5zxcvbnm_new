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
        string sqlexe = @"select ID,Column1,Column2,Column3 from Table_1 where id=" + id + "";
        DataTable dt =SqlHelper.dataTable(sqlexe);
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
                sWhere = " where [parent]=" + PID;
                page = 1;
            }
        }
        else if (action.Equals("query"))
        {
            string stitle = ParamsofEasyUI.RequstString("title");
            if (!string.IsNullOrEmpty(stitle))
                sWhere = " where title like '%" + stitle + "%'";
        }
        //sqlexe = @"select top 10 ID,title,addTime from (select top 20 * from product " + PID + " order by [addTime] DESC,ID desc) as a";
        sqlexe = @"select ID,Column1,Column2,Column3 from Table_1 " + sWhere + " order by " + sort + " " + order;
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onDataGrid(dt, page, rows);
    }
    
    //删除
    private string delete()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("id");
        string sqlexe = string.Format("delete from Table_1 where id in ({0})", id);
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
        string Column1 = ParamsofEasyUI.RequstForm("Column1");
        string Column2 = ParamsofEasyUI.RequstForm("Column2");
        string Column3 = ParamsofEasyUI.RequstForm("Column3");
        string sqlexe = string.Empty;
        if (id.Length > 0)
        {
            sqlexe = string.Format("update Table_1 set Column1='{0}',Column2='{1}',Column3='{2}' where id={3}",
   Column1, Column2, Column3, Convert.ToInt32(id));
            if (SqlHelper.ExecuteUpdate(sqlexe))
                sReturnJson = "{success:true}";
            else
                sReturnJson = "{success:false}";
        }
        else
        {
            sqlexe = string.Format("insert Into Table_1 (Column1,Column2,Column3) values ('{0}','{1}','{2}')",
               Column1, Column2, Column3);
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