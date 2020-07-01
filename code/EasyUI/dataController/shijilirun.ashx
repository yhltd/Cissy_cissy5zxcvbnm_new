﻿<%@ WebHandler Language="C#" Class="Handler" %>

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
            
                
                //列表
            case "list":
                //查询
            case "query":
                sReturnJson = getData(action);
                break;
            
            default:
                break;
        }
        context.Response.Write(sReturnJson);
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
                //sWhere = " where [parent]= '" + PID + "'";
                sWhere = "";
                page = 1;
            }
        }
        else if (action.Equals("query"))
        {
            string stitle = ParamsofEasyUI.RequstString("title");
            if (!string.IsNullOrEmpty(stitle))
                sWhere = " where Sale.sunSKU like '%" + stitle + "%'";
        }
        //sqlexe = @"select top 10 ID,title,addTime from (select top 20 * from Product " + PID + " order by [addTime] DESC,ID desc) as a";
        //sqlexe = @"SELECT row_number() over( order by  Sales.sunSKU) as id,Sales.sunSKU,SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.sales * Sales.quantity END ) AS 销售额,SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.quantity END ) AS 售出数量,SUM ( CASE WHEN Sales.type= 'Refund' THEN Sales.sales * Sales.quantity END ) AS 退货额,SUM ( CASE WHEN Sales.type= 'Refund' THEN Sales.quantity END ) AS 退货数量,ROUND(CAST(SUM ( CASE WHEN Sales.type= 'Refund' THEN Sales.quantity END ) as float)/CAST(SUM ( CASE WHEN Sales.type= 'Refund' or Sales.type= 'Order' THEN Sales.quantity END )as float),3) as 退货率,SUM ((Sales.total*Sale.rate - Product.cost- Product.freight)*Sales.quantity ) AS 利润 FROM Sales LEFT JOIN Sale ON Sale.sunSKU= Sales.sunSKU LEFT JOIN Product ON Sale.name = Product.name  GROUP BY Sales.sunSKU" + sWhere + " order by " + sort + " " + order;
        sqlexe = @"SELECT
	row_number () OVER ( ORDER BY Sale.sunSKU ) AS id,
	Sale.account,
	Sale.name,
	Sale.sunSKU,
	aa.[利润] AS 利润
FROM
	[dbo].[Sale]
	LEFT JOIN (
	SELECT 
		Sales.sunSKU AS sunSKU,
        Sales.account AS account,
		SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.sales * Sales.quantity END ) AS 销售额,
		SUM ((
						CASE
								
								WHEN Sales.type = 'Refund' THEN
								Sales.sales * Sales.quantity * Sale.rate 
								WHEN Sales.type = 'Transfer' THEN
								0 
                                WHEN Sales.type = 'Order' THEN
								(Sales.total- ( Sales.cost + Freight.freight )) * Sales.quantity * Sale.rate ELSE Sales.total * Sales.quantity* Sale.rate  
							END 
							) 
						) AS 利润,
		
			SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.quantity WHEN Sales.type= 'Refund' THEN - Sales.quantity END ) AS 净售出数量 
		FROM
			Sales
			LEFT JOIN Sale ON Sale.sunSKU= Sales.sunSKU AND Sale.account = Sales.account
			LEFT JOIN Product ON Sale.name = Product.name 
            LEFT JOIN Country ON Country.account = Sales.account
			LEFT JOIN Freight ON Freight.country = Country.country 
		GROUP BY
			Sales.sunSKU,Sales.account 
		) AS aa ON aa.sunSKU = Sale.sunSKU AND aa.account = Sale.account
		LEFT JOIN Peizhi ON Peizhi.star = Sale.star" + sWhere + " order by " + sort + " " + order;
        DataTable dt = SqlHelper.dataTable(sqlexe);
        return Json4EasyUI.onDataGrid(dt, page, rows);
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}