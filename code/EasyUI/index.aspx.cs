using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EasyUI
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string backname()
        {
            string aa;
            HttpCookie cookies1 = System.Web.HttpContext.Current.Request.Cookies["conCookie"];
            if (cookies1 != null)
            {
                aa = cookies1["shengfen"];
            }
            else
            {
                aa = "δ֪";
            }
            return aa;
        }
        public int conCookie { get; set; }
    }
}