using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace EasyUI
{
    public partial class Login : System.Web.UI.Page
    {
        bool is_AdminIS = false;
        public string user;
        public string pass;
        private SqlConnection conn = null;
        private SqlCommand cmd = null;
        private string sql = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public void openDatabase()
        {
            conn = new SqlConnection();
            conn.ConnectionString = "Data Source=yhocn.cn;initial catalog=Cissy;User ID =sa;password=Lyh07910_001";
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                //Response.Write("<script>alert('Connected!');</script>");
            }
        }
        public void execute(String sql)
        {
            openDatabase();
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            conn.Close();

        }
        public void load(string sql) 
        {
            openDatabase();
            cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            /*
             * while(dr.Read())
             * {
             *  
             * }
             */
            conn.Close();
        }
        protected void denglu(object sender, EventArgs e)
        {
            Session.Timeout = 10000;
            string account = Request.Form["account"];
            string password = Request.Form["password"]; 
            user = account;
            pass = password;
            HttpCookie cookie = new HttpCookie("MyCook");
            if ((account == "" && password == "") || account == "")
            {
                Response.Write("<script>alert('账户名不能为空!')</script>");
            }
            else if (password == "")
            {
                Response.Write("<script>alert('密码不能为空!')</script>");
            }
            else 
            {
                sql = "select pwd,LV from  Account where account='" + account + "'";
                openDatabase();
                cmd = new SqlCommand(sql, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    
                    if ((String)dr[0].ToString().Trim() == password)
                    {
                        if ((String)dr[1].ToString().Trim() == "admin")
                        {
                            Session["account"] = account;
                            Response.Redirect("index.aspx");
                        }
                        else if ((String)dr[1].ToString().Trim() == "normal")
                        {
                            Response.Redirect("NO_index.aspx");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('输入密码有误，请重试')</script>");
                    }
                }
                else 
                {
                    Response.Write("<script>alert('输入账户名有误，请重试')</script>");
                }
                 
                conn.Close();

                
            }
        }
    }
}