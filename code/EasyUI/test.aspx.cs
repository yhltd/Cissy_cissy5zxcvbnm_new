using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Web
{
    public partial class test : System.Web.UI.Page
    {
        private SqlConnection conn = null;
        private SqlCommand cmd = null;
        //private SqlDataAdapter adapter = null;
        //为了方便，设为全局对象的sql语句
        private string sql = null;
        public void openDatabase()
        {
            conn = new SqlConnection();
            conn.ConnectionString = "Data Source=yhocn.cn;initial catalog=test;User ID =sa;password=Lyh07910_001";
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                //Response.Write("<script>alert('Connected!');</script>");
            }
        }
        //默认加载页面的方法 找到年龄最大的加载
        //有些问题，年龄不能相同，加载中前台的textbox里只能显示一条记录，数据拿到之后有多条只显示一条
        public void load()
        {
            openDatabase();
            cmd = new SqlCommand("select * from aaa where id=(select max(id) from aaa)", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                tbId.Text = (String)dr[0].ToString().Trim();
                tbName.Text = (String)dr[1].ToString().Trim();
                tbAge.Text = (String)dr[2].ToString().Trim();
            }
            /*
             * while(dr.Read())
             * {
             *  
             * }
             */
            conn.Close();

        }
        //根据sql语句加载信息，重载两个textbox
        public void load(String sql)
        {
            openDatabase();
            cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                tbId.Text = (String)dr[0].ToString().Trim();
                tbName.Text = (String)dr[1].ToString().Trim();
                tbAge.Text = (String)dr[2].ToString().Trim();
            }
            conn.Close();
        }
        //封装的数据库语句执行的方法
        public void execute(String sql)
        {
            openDatabase();
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            conn.Close();

        }


        //页面加载时ASP.NET首先会调用这个方法
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { load(); }//如果页面不是刷新，则执行，这个很重要
        }
        //四个按钮的方法，增删改查
        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            sql = "insert into aaa(name,age) values('" + tbName.Text.ToString().Trim() + "','" + tbAge.Text.ToString().Trim() + "')";
            execute(sql);
        }

        protected void BtnDel_Click(object sender, EventArgs e)
        {
            sql = "delete from aaa where name='" + tbName.Text.ToString().Trim() + "'";
            execute(sql);
            load();
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            sql = "update  aaa set age='" + tbAge.Text.ToString().Trim() + "' where name='" + tbName.Text.ToString().Trim() + "'";
            execute(sql);
        }

        protected void BtnSelect_Click(object sender, EventArgs e)
        {
            sql = "select * from aaa where name='" + tbName.Text.ToString().Trim() + "'";
            load(sql);
        }


    }
}