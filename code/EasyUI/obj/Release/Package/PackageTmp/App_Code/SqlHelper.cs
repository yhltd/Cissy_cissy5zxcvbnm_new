using System;
using System.Data;
using System.Web;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Collections;
using System.Text;


/// <summary>
/// 
/// </summary>
public class SqlHelper
{
    protected static SqlConnection conn = new SqlConnection();
    protected static SqlCommand comm = new SqlCommand();

    public SqlHelper()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary> 
    /// 打开数据库连接 
    /// </summary> 

    private static void openConnection()
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            comm.Connection = conn;
            try
            {
                conn.Open();

            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }
    }
    /// <summary> 
    /// 关闭当前数据库连接 
    /// </summary> 
    private static void closeConnection()
    {
        if (conn.State == ConnectionState.Open)
            conn.Close();
        conn.Dispose();
        comm.Dispose();
    }


    /// <summary>
    /// 权限管理函数，用于拼接字符串
    /// </summary>
    public static string sel(string sql)
    {
        SqlDataReader dr = null;
        StringBuilder sb = new StringBuilder();
        try
        {
            openConnection();
            comm = new SqlCommand(sql, conn);
            dr = comm.ExecuteReader();
            while (dr.Read())
            {

                for (int i = 0; i < dr.FieldCount; i++)
                {
                    sb.Append(dr[i].ToString().Trim() + ",");
                }

            }
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            dr.Close();
            closeConnection();
        }
        return sb.ToString();
    }
    /// <summary> 
    /// 执行Sql查询语句 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    public static void ExecuteSql(string sqlstr)
    {
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            comm.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
    }
    public static Boolean ExecuteNonQuery(string sqlstr, SqlParameter[] parm)
    {
        Boolean b = false;
        try
        {
            openConnection();
            comm.CommandText = sqlstr;
            foreach (SqlParameter parmitem in parm)
            {
                comm.Parameters.Add(parmitem);
            }
            comm.CommandType = CommandType.Text;
            comm.ExecuteNonQuery();
            b = true;
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        return b;
    }
    /// <summary> 
    /// 执行Sql更新语句 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param>
    /// <returns>布尔值</returns>
    public static bool ExecuteUpdate(string sqlstr)
    {
        int isUpdateOk = 0;
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            isUpdateOk = Convert.ToInt32(comm.ExecuteNonQuery());
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        if (isUpdateOk > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }


    public static DataRow GetDataRow(string strSQL)
    {
        //查询数据，取得数据行
        try
        {
            openConnection();
            SqlDataAdapter OleAdp = new SqlDataAdapter(strSQL, conn);
            
            DataSet Rs = new DataSet();
            OleAdp.Fill(Rs);
            if (Rs.Tables[0].Rows.Count != 0)
                return Rs.Tables[0].Rows[0];
            else
                return null;
        }
        catch
        {
            return null;
        }

    }
    public static DataView GetDataView(string strSQL)
    {
        //查询数据，取得数据视图
        try
        {
            openConnection();
            SqlDataAdapter OleAdp = new SqlDataAdapter(strSQL, conn);
            DataSet Rs = new DataSet();
            OleAdp.Fill(Rs);
            return Rs.Tables[0].DefaultView;

        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }

    }
    public static bool SearchTable(string strSQL)
    {
        SqlDataReader OleDr = null;
        try
        {
            openConnection();
            comm.CommandText = strSQL;
            comm.CommandType = CommandType.Text;
            OleDr = comm.ExecuteReader(CommandBehavior.CloseConnection);
            if (OleDr.Read())
            {

                return true;
            }
            else
            {

                return false;
            }
        }
        catch
        {
            try
            {
                OleDr.Close();
                closeConnection();
            }
            catch
            {
            }
            return false;
        }
        finally
        {
            if (OleDr != null)
                OleDr.Close();
        }

    }
    public static string SearchValue(string strSQL)
    {
        //查找
        SqlDataReader OleDr = null;
        try
        {
            openConnection();
            comm.CommandText = strSQL;
            comm.CommandType = CommandType.Text;
            OleDr = comm.ExecuteReader(CommandBehavior.CloseConnection);
            if (OleDr.Read())
            {

                return OleDr[0].ToString();
            }
            else
                return "";
        }
        catch
        {
            try
            {
                OleDr.Close();
                closeConnection();
            }
            catch
            {
            }
            return "";
        }
        finally
        {
            if (OleDr != null)
                OleDr.Close();
        }

    }
    /// <summary> 
    /// 执行Sql查询语句并返回第一行的第一条记录,返回值为object 使用时需要拆箱操作 -> Unbox 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <returns>object 返回值 </returns> 
    public static object ExecuteScalar(string sqlstr)
    {
        object obj = new object();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            obj = comm.ExecuteScalar();
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        return obj;
    }
    /// <summary> 
    /// 返回指定Sql语句的SqlDataReader，请注意，在使用后请关闭本对象，同时将自动调用closeConnection()来关闭数据库连接 
    /// 方法关闭数据库连接 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <returns>SqlDataReader对象</returns> 
    public static SqlDataReader dataReader(string sqlstr)
    {
        SqlDataReader dr = null;
        try
        {
            openConnection();
            comm.CommandText = sqlstr;
            comm.CommandType = CommandType.Text;
            dr = comm.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch
        {
            try
            {
                dr.Close();
                closeConnection();
            }
            catch
            {
            }
        }
        return dr;
    }

    ///<summary>
    ///关闭datareader
    ///传入SqlDataReader的ref
    ///</summary>
    public static void closeDataReader(ref SqlDataReader sdr)
    {
        try
        {
            sdr.Close();
            sdr.Dispose();
        }
        catch (Exception)
        { }
    }

    /// <summary> 
    /// 返回指定Sql语句的DataSet 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <returns>DataSet</returns> 
    public static DataSet dataSet(string sqlstr)
    {
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(ds);
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        return ds;
    }

    /// <summary> 
    /// 返回指定Sql语句的DataSet 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <param name="ds">传入的引用DataSet对象</param> 
    public static void dataSet(string sqlstr, ref DataSet ds)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(ds);
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }

        finally
        {
            closeConnection();
        }
    }
    /// <summary> 
    /// 返回指定Sql语句的DataTable 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <returns>DataTable</returns> 
    public static DataTable dataTable(string sqlstr)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable datatable = new DataTable();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(datatable);
        }
        catch (Exception)
        {
        }
        finally
        {
            closeConnection();
        }
        return datatable;
    }

    /// <summary> 
    /// 执行指定Sql语句,同时给传入DataTable进行赋值 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <param name="dt">ref DataTable dt </param> 
    public static void dataTable(string sqlstr, ref DataTable dt)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(dt);
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
    }

    /// <summary> 
    /// 执行指定Sql语句 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    public static DataView dataView(string sqlstr)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataView dv = new DataView();
        DataSet ds = new DataSet();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(ds);
            dv = ds.Tables[0].DefaultView;
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        return dv;
    }

    /// <summary> 
    /// 执行指定Sql语句,开始记录位置,和返回记录数 
    /// </summary> 
    /// <param name="sqlstr">传入的Sql语句</param> 
    /// <param name="StartIndex">开始记录位置</param>
    /// <param name="pageSize">返回记录数</param> 
    public static DataView dataView(string sqlstr, int StartIndex, int pageSize)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataView dv = new DataView();
        DataSet ds = new DataSet();
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            da.SelectCommand = comm;
            da.Fill(ds, StartIndex, pageSize, "pagelist");
            dv = ds.Tables["pagelist"].DefaultView;
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        return dv;
    }
    /// <summary>
    /// 验证是否正确
    /// </summary>
    /// <param name="userName">传入sql语句</param>
    /// <returns>布尔值</returns>
    public static bool chkExist(string sqlstr)
    {
        int isExit = 0;
        try
        {
            openConnection();
            comm.CommandType = CommandType.Text;
            comm.CommandText = sqlstr;
            isExit = Convert.ToInt32(comm.ExecuteScalar());
        }
        catch (Exception e)
        {
            throw new Exception(e.Message);
        }
        finally
        {
            closeConnection();
        }
        if (isExit > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}