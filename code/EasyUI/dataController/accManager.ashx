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
        string operation = ParamsofEasyUI.RequstString("operation");
        string access_id = ParamsofEasyUI.RequstString("access_id");

        switch (operation) { 
            case "viewAccess":
                sReturnJson = getViewAccess(access_id);
                    break;
                
            case "updAccess":
                sReturnJson = updAccess(access_id);
                    break;
        }
        
        context.Response.Write(sReturnJson);
    }

    private string updResult(string result)
    {
        string[] arr = result.Split(',');
        string newResult = "";
        for (int i = 1; i < arr.Length; i++)
        {
            if (i == arr.Length - 3)
            {
                newResult += arr[i];
                break;
                ;
            }
            newResult += arr[i] + ",";
        }
        return newResult;
    }

    private string getViewAccess(string id)
    {
        string table_name = ParamsofEasyUI.RequstString("tableName");

        string sql = "SELECT * from AccessManager where con_id = '" + id + "' and viewName = (select id from viewNames where ViewName = '" + table_name + "')";
        string sReturnJson = updResult(SqlHelper.sel(sql));


        return sReturnJson;
    }

    private string updAccess(string id)
    {
        string table_name = ParamsofEasyUI.RequstString("tableName");
        string caozuo = ParamsofEasyUI.RequstString("caozuo");
        string arr = ParamsofEasyUI.RequstString("arr");

        string[] newArr = arr.Split(',');

        string sql = "";

        if (caozuo.Equals("upd"))
        {
            sql = "update AccessManager set [add] = '" + newArr[0] + "',upd = '" + newArr[1] + "',del = '" + newArr[2] + "',sel = '" + newArr[3] + "',selAll='" + newArr[4] + "',exportExcel='" + newArr[5] + "'," +
            "importExcel='" + newArr[6] + "',empty='" + newArr[7] + "',look='" + newArr[8] + "',importImage='" + newArr[9] + "' where con_id='" + id + "' and ViewName = (select id from viewNames where ViewName = '" + table_name + "')";
        }
        else {
            sql = "insert into AccessManager(con_id,[add],del,upd,sel,selAll,exportExcel,importExcel,empty,look,importImage,ViewName) values(";
            for (int i = 0; i < newArr.Length;i++ )
            {
                if(i==0){
                    sql += "'" + id + "',";
                }
                sql += "'" + newArr[i] + "',";

                if (i == newArr.Length - 1)
                {
                    sql += "(select id from viewNames where ViewName = '" + table_name + "'))";
                }
            }
        }

        string result = SqlHelper.ExecuteUpdate(sql).ToString();


        return result;
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}