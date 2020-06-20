using System;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.Data;

/// <summary>
///Json4EasyUI 的摘要说明
/// </summary>
public class Json4EasyUI
{
	public Json4EasyUI()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public static string onDataGrid1(DataTable dt, int start, int end)
    {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.Append("{\"total\":" + dt.Rows.Count + ",\"rows\":[");
        for (int i = start; i < end; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]}");
        return jsonBuilder.ToString();
    }
    /// <summary>
    /// 填充DataGrid的Json数据格式
    /// </summary>
    /// <param name="dt">数据集</param>
    /// <param name="page">页数</param>
    /// <param name="rows">每页行数</param>
    /// <returns></returns>
    public static string onDataGrid(DataTable dt, int page, int rows)
    {
        page = (page == 0) ? 1 : page;
        rows = (rows == 0) ? 10 : rows;
        int start = (page - 1) * rows;
        int end = page * rows;
        end = (end > dt.Rows.Count) ? dt.Rows.Count : end;
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.Append("{\"total\":" + dt.Rows.Count + ",\"rows\":[");
        for (int i = start; i < end; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]}");
        return jsonBuilder.ToString();
    }
    /// <summary>
    /// 填充DataGrid分页的Json数据格式
    /// </summary>
    /// <param name="dt">分页数据集</param>
    /// <param name="total">总条数</param>
    /// <returns></returns>
    public static string onDataGrid(DataTable dt,int total)
    {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.Append("{\"total\":" + total + ",\"rows\":[");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]}");
        return jsonBuilder.ToString();
    }
    /// <summary>
    /// 用于初始化表单的Json数据
    /// </summary>
    /// <param name="dt">数据集,仅一条记录</param>
    /// <returns></returns>
    public static string onForm(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();
        if (dt.Rows.Count > 0)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[0][j].ToString());
                jsonBuilder.Append("\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("}");
        }
        return jsonBuilder.ToString();
    }
}

/// <summary>
/// EasyUI控件可传参数
/// </summary>
public class ParamsofEasyUI
{
    public ParamsofEasyUI() { }
    public static string RequstForm(string name)
    {
        return (HttpContext.Current.Request.Form[name] == null ? string.Empty : HttpContext.Current.Request.Form[name].ToString().Trim());
    }
    public static string RequstString(string sParam)
    {
        return (HttpContext.Current.Request[sParam] == null ? string.Empty : HttpContext.Current.Request[sParam].ToString().Trim());
    }
    public static int RequstInt(string sParam)
    {
        int iValue;
        string sValue = RequstString(sParam);
        int.TryParse(sValue, out iValue);
        return iValue;
    }
    public static string order
    {
        get { return RequstString("order"); }
    }
    public static string sort
    {
        get { return RequstString("sort"); }
    }
    public static int page
    {
        get { return RequstInt("page"); }
    }
    public static int rows
    {
        get { return RequstInt("rows"); }
    }
}