<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections.Generic;
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
    
    private class Arr{
        public string viewName;
        public string caozuo;
        public string[] arr;
        public bool isUpd;
    }

    private string updAccess(string id)
    {
        string arr = ParamsofEasyUI.RequstString("sqlarr");
        JavaScriptSerializer js = new JavaScriptSerializer();
        List<Arr> list = js.Deserialize<List<Arr>>(arr);

        StringBuilder sql = new StringBuilder();
        
        for (int i = 0; i < list.Count; i++) {
            Arr arrClass = new Arr();
            arrClass = list[i];
            if (arrClass.isUpd)
            {
                if (arrClass.caozuo.Equals("upd"))
                {
                    sql.Append("update AccessManager set [add] = '" + arrClass.arr[0] + "',upd = '" + arrClass.arr[1] + "',del = '" + arrClass.arr[2] + "',sel = '" + arrClass.arr[3] + "',selAll='" + arrClass.arr[4] + "',exportExcel='" + arrClass.arr[5] + "'," +
                    "importExcel='" + arrClass.arr[6] + "',empty='" + arrClass.arr[7] + "',look='" + arrClass.arr[8] + "',importImage='" + arrClass.arr[9] + "' where con_id='" + id + "' and ViewName = (select id from viewNames where ViewName = '" + arrClass.viewName + "');");
                }
                else
                {
                    sql.Append("insert into AccessManager(con_id,[add],del,upd,sel,selAll,exportExcel,importExcel,empty,look,importImage,ViewName) values(");
                    for (int j = 0; j < arrClass.arr.Length; j++)
                    {
                        if (j == 0)
                        {
                            sql.Append("'" + id + "',");
                        }
                            sql.Append("'" + arrClass.arr[j] + "',");

                        if (j == arrClass.arr.Length - 1)
                        {
                            sql.Append("(select id from viewNames where ViewName = '" + arrClass.viewName + "'));");
                        }
                    }
                }
            }
            
        }

        string result = "";
        if (!sql.ToString().Equals(""))
        {
            result = SqlHelper.ExecuteUpdate(sql.ToString()).ToString();
        }
        else {
            result = "isNotUpd";
        }

        


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