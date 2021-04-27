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

            case "dell":
                sReturnJson = dellete();
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
        string sqlexe = @"select id,account ,smallGroup ,saler ,type ,asin ,sunSKU ,name ,REPLACE(fatherSKU, CHAR(10) , '') as fatherSKU  ,FBA ,three,thirty  from Sale where id=" + id + "";
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
        sqlexe = @"select id,account ,smallGroup ,saler ,type ,asin ,sunSKU ,name ,REPLACE(fatherSKU, CHAR(10) , '') as fatherSKU ,FBA ,three,thirty,CONVERT(varchar(10), time,120)as time  from Sale " + sWhere + " order by " + sort + " " + order;
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onDataGrid(dt, page, rows);
    }
    
    //删除
    private string delete()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("ID");
        string sqlexe = string.Format("delete from Sale where id in ({0})", id);
     
        if (SqlHelper.ExecuteUpdate(sqlexe))
            sReturnJson = "{success:true}";
        else
            sReturnJson = "{success:false}";
        return sReturnJson;
    }

    //清空
    private string dellete()
    {
        string sReturnJson = string.Empty;
        string sqlexe = string.Format("truncate table Sale;");
        SqlHelper.ExecuteUpdate(sqlexe);
        sReturnJson = "{success:true}";

        return sReturnJson;
    }
    
    //保存或添加
    private string save()
    {
        string sReturnJson = string.Empty;
        string id = ParamsofEasyUI.RequstString("id");
        string account = ParamsofEasyUI.RequstForm("account");
        string smallGroup = ParamsofEasyUI.RequstForm("smallGroup");
        string saler = ParamsofEasyUI.RequstForm("saler");
        string type = ParamsofEasyUI.RequstForm("type");
        string asin = ParamsofEasyUI.RequstForm("asin");
        string sunSKU = ParamsofEasyUI.RequstForm("sunSKU");
        string name = ParamsofEasyUI.RequstForm("name");
        string fatherSKU = ParamsofEasyUI.RequstForm("fatherSKU");
        string FBA = ParamsofEasyUI.RequstForm("FBA");
        string three = ParamsofEasyUI.RequstForm("three");
        string thirty = ParamsofEasyUI.RequstForm("thirty");
        string sqlexe = string.Empty;
        if (id.Length > 0)
        {
            sqlexe = string.Format("update Sale set account='{0}',smallGroup='{1}',saler='{2}',type='{3}',asin='{4}',sunSKU='{5}',name='{6}' ,fatherSKU='{7}',FBA='{8}',three='{9}',thirty='{10}'where id={11}",
   account, smallGroup, saler, type, asin, sunSKU, name, fatherSKU, FBA, three, thirty, Convert.ToInt32(id));
            if (SqlHelper.ExecuteUpdate(sqlexe))
                sReturnJson = "{success:true}";
            else
                sReturnJson = "{success:false}";
        }
        else
        {
            sqlexe = string.Format("insert Into Sale ( account, smallGroup, saler, type, asin, sunSKU, name, fatherSKU, FBA, three, thirty) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}')",
                account, smallGroup, saler, type, asin, sunSKU, name, fatherSKU, FBA, three, thirty);
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