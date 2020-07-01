<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Web.Script.Serialization;

public class Handler : IHttpHandler 
{

    public void ProcessRequest(HttpContext context)
    {
        HttpCookie cookies1 = System.Web.HttpContext.Current.Request.Cookies["conCookie"];
        context.Response.ContentType = "text/plain";
        string sReturnJson = "";
        
        string id = cookies1.Values["id"];

        string operation = ParamsofEasyUI.RequstString("operation");

        switch (operation) { 
            case "viewAccess":
                sReturnJson = getViewAccess(id);
                break;
            case "tableAccess":
                sReturnJson = getTableAccess(id);
                break;
        }
        
        
        context.Response.Write(sReturnJson);
    }

    private string updResult(string result) {
        string[] arr = result.Split(',');
        string newResult = "";
        for (int i = 1; i < arr.Length;i++ )
        {
            if (i == arr.Length-3)
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

        if (sReturnJson=="")
        {
            sReturnJson = "1,1,1,1,1,1,1,1,1,1";
        }


        return sReturnJson;
    }

    private string getTableAccess(string id)
    {
        string sql = "select look,ViewName from AccessManager where con_id = " + id;
        string sReturnJson = SqlHelper.sel(sql);
        sReturnJson = sReturnJson.Substring(0, sReturnJson.Length - 1);

        string[] arr = sReturnJson.Split(',');
        string newResult = "";
        for (int i = 0; i < arr.Length;i++ )
        {

            if (i == arr.Length - 1)
            {
                newResult += arr[i];
                continue;
            }
            if (i % 2 != 0)
            {
                newResult += arr[i] + ":";
            }
            else {
                newResult += arr[i] + ",";
            }
            
            
        }

        return newResult;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    
}