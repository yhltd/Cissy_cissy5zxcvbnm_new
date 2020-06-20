using clsBuiness;
using SDZdb;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace EasyUI
{
    public partial class frmShejibuyulu : System.Web.UI.Page
    {
        List<clt_detail_info> readCards;
        clsAllnew BusinessHelp = new clsAllnew();

        public string sFilePath;
        public string txtFilePath;
        string picpath;
        string _id;

        private SortableBindingList<clt_detail_info> sortablePendingOrderList;

        public class SortableBindingList<T> : BindingList<T>
        {
            private bool isSortedCore = true;
            private ListSortDirection sortDirectionCore = ListSortDirection.Ascending;
            private PropertyDescriptor sortPropertyCore = null;
            private string defaultSortItem;

            public SortableBindingList() : base() { }

            public SortableBindingList(IList<T> list) : base(list) { }

            protected override bool SupportsSortingCore
            {
                get { return true; }
            }

            protected override bool SupportsSearchingCore
            {
                get { return true; }
            }

            protected override bool IsSortedCore
            {
                get { return isSortedCore; }
            }

            protected override ListSortDirection SortDirectionCore
            {
                get { return sortDirectionCore; }
            }

            protected override PropertyDescriptor SortPropertyCore
            {
                get { return sortPropertyCore; }
            }

            protected override int FindCore(PropertyDescriptor prop, object key)
            {
                for (int i = 0; i < this.Count; i++)
                {
                    if (Equals(prop.GetValue(this[i]), key)) return i;
                }
                return -1;
            }

            protected override void ApplySortCore(PropertyDescriptor prop, ListSortDirection direction)
            {
                isSortedCore = true;
                sortPropertyCore = prop;
                sortDirectionCore = direction;
                Sort();
            }

            protected override void RemoveSortCore()
            {
                if (isSortedCore)
                {
                    isSortedCore = false;
                    sortPropertyCore = null;
                    sortDirectionCore = ListSortDirection.Ascending;
                    Sort();
                }
            }

            public string DefaultSortItem
            {
                get { return defaultSortItem; }
                set
                {
                    if (defaultSortItem != value)
                    {
                        defaultSortItem = value;
                        Sort();
                    }
                }
            }

            private void Sort()
            {
                List<T> list = (this.Items as List<T>);
                list.Sort(CompareCore);
                ResetBindings();
            }

            private int CompareCore(T o1, T o2)
            {
                int ret = 0;
                if (SortPropertyCore != null)
                {
                    ret = CompareValue(SortPropertyCore.GetValue(o1), SortPropertyCore.GetValue(o2), SortPropertyCore.PropertyType);
                }
                if (ret == 0 && DefaultSortItem != null)
                {
                    PropertyInfo property = typeof(T).GetProperty(DefaultSortItem, BindingFlags.Public | BindingFlags.GetProperty | BindingFlags.Instance | BindingFlags.IgnoreCase, null, null, new Type[0], null);
                    if (property != null)
                    {
                        ret = CompareValue(property.GetValue(o1, null), property.GetValue(o2, null), property.PropertyType);
                    }
                }
                if (SortDirectionCore == ListSortDirection.Descending) ret = -ret;
                return ret;
            }

            private static int CompareValue(object o1, object o2, Type type)
            {
                if (o1 == null) return o2 == null ? 0 : -1;
                else if (o2 == null) return 1;
                else if (type.IsPrimitive || type.IsEnum) return Convert.ToDouble(o1).CompareTo(Convert.ToDouble(o2));
                else if (type == typeof(DateTime)) return Convert.ToDateTime(o1).CompareTo(o2);
                else return String.Compare(o1.ToString().Trim(), o2.ToString().Trim());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            picpath = @"D:\all\公司素材\软件设计图片素材\psd素材\116ae547bbc0baa3528d6b3f81cb7812.jpg";

            //if (IsPostBack)
            InitialSystemInfo();
           


        }
        private void InitialSystemInfo()
        {
            readCards = new List<clt_detail_info>();
            FileStream fs;
            string file = @"C:\" + DateTime.Now.ToString("yyyyMMddHHmmssff") + ".BMP";

            fs = new FileStream(file, FileMode.OpenOrCreate, FileAccess.Write);

            for (int i = 0; i < 100; i++)
            {
                clt_detail_info item = new clt_detail_info();

                item.Order_id = i.ToString();
                item.num = "nmm" + i.ToString();
                item.no = "no" + i.ToString();
                #region 绑定图片列 HTTP
                //string mdbpath2_Ctirx = AppDomain.CurrentDomain.BaseDirectory + "\\116ae547bbc0baa3528d6b3f81cb7812.jpg";//记录 Status  click 和选择哪个服务器
                //mdbpath2_Ctirx = "https://images.cnblogs.com/cnblogs_com/dylanwind/Photo.PNG";

                //item.image_path = mdbpath2_Ctirx;


                //string sql2 = "select * from Detailed where   id='" + item.Order_id + "'";

                //List<clt_detail_info> readCards1 = BusinessHelp.Readt_PICServer(sql2);



                //if (readCards1.Count > 0 && readCards1[0].imagebytes != null)
                //{
                //    file = @"C:\" + DateTime.Now.ToString("yyyyMMddHHmmssff") + ".BMP";

                //    fs = new FileStream(file, FileMode.OpenOrCreate, FileAccess.Write);
                //    fs.Write(readCards1[0].imagebytes, 0, readCards1[0].imagebytes.GetUpperBound(0));

                //    item.image_path = file;
                //} 
                #endregion
                readCards.Add(item);


            }
            fs.Close();

            //绑定dav 

            this.gvList.AutoGenerateColumns = false;
            sortablePendingOrderList = new SortableBindingList<clt_detail_info>(readCards);

            this.gvList.DataSource = sortablePendingOrderList;
            gvList.DataKeyNames = new string[] { "Order_id" };//主键
            this.gvList.DataBind();

        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {


        }
        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string sdd = e.Row.Cells[5].Text;

            //if (e.Row.RowType == DataControlRowType.Header && sdd == "查看图片")
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //可以弹窗 但是不固定位置 需判断 列序列

                //e.Row.Attributes.Add("onclick", "Upload_openBrowse()");
            }
        }
        protected void GridView1_DataBound(object sender, EventArgs e)
        {


        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gvList.EditIndex = e.NewEditIndex;


        }
        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {


        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvList.EditIndex = -1;
        }
        protected void GridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {

            //删除图片功能
            if (e.CommandName == "Btn_Operation")
            {
                int RowRemark = Convert.ToInt32(e.CommandArgument);
                if (RowRemark >= 0)
                {
                    string QiHao = gvList.DataKeys[RowRemark].Value.ToString();
                    QiHao = "8";

                    List<clt_detail_info> cloumnlist = readCards.FindAll(s => s.Order_id != null && s.Order_id == "8");
                    cloumnlist[0].img = null;
                    cloumnlist[0].FFileName = "";
                    BusinessHelp.changePIC_server(cloumnlist);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('删除成功')</script>");
                }
            }
            //查看图片功能
            else if (e.CommandName == "Btn_View")
            {
                int RowRemark = Convert.ToInt32(e.CommandArgument);
                if (RowRemark >= 0)
                {
                    BusinessHelp = new clsAllnew();
                    string QiHao = gvList.DataKeys[RowRemark].Value.ToString();
                    QiHao = "8";
                    Response.Redirect("~/ViewImage.aspx?QiHao=" + QiHao);
                }

            }
            //弹窗选择图片路径
            else if (e.CommandName == "Btn_upload")
            {
                int RowRemark = Convert.ToInt32(e.CommandArgument);
                if (RowRemark >= 0)
                {
                    //在此处 调用 弹出窗选择图片路径

                    #region MyRegion
                    //ClientScript.RegisterStartupScript(Page.GetType(), "", "addpic_id();", true);
                    //this.ClientScript.RegisterStartupScript(this.GetType(), "tr", "<script>addpic_id();</script>");

                    //  addpic_id.Attributes.Add("onclick", "Upload_openBrowse()");
                    //ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript", "<script>Upload_openBrowse();</script>");

                    //  this.ClientScript.RegisterStartupScript(this.GetType(), "tr", "<script>Upload_openBrowse();</script>");
                    //Button1.Attributes.Add("onclick", "Upload_openBrowse()");
                    //ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript", "<script>Upload_openBrowse();</script>");
                    //gvList.Rows[RowRemark].Cells["上传图片"].Attributes.Add("onclick", "Upload_openBrowse()"); 



                    //Response.Write("<script type='text/javascript'>function Openpic_file(){}</script>");
                    //this.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>Openpic_file();</script>");
                    //var username = Request.Form["pathname"];
                    //_id = gvList.DataKeys[RowRemark].Value.ToString();



                    //string _upfilepath = fileUpload.FileName;
                    //if (_upfilepath != "" && _upfilepath != null)
                    //{
                    //    string fname = fileUpload.FileName.Substring(0, fileUpload.FileName.IndexOf('.'));
                    //    string ftype = fileUpload.FileName.Substring(fileUpload.FileName.IndexOf('.'), fileUpload.FileName.Length - fileUpload.FileName.IndexOf('.'));
                    //    string FileName = "../user/file/" + Path.GetFileName(fileUpload.FileName);
                    //    string namestr = fileUpload.FileName;
                    //    if (File.Exists(Server.MapPath(FileName)))
                    //    {
                    //        Random rad = new Random();//实例化随机数产生器rad；
                    //        string value = rad.Next(1000, 10000).ToString();//用rad生成大于等于1000，小于等于9999的随机数；
                    //        FileName = "../user/file/" + Path.GetFileName(fname + value + ftype);
                    //        namestr = fname + value + ftype;
                    //    }
                    //    //将文件保存至指定文件夹
                    //    fileUpload.SaveAs(Server.MapPath(FileName)); 

                    //}
                    #endregion


                    //添加此路径的图片到数据库上功能



                }
            }
        }
        //添加图片功能
        protected void btnAddAttach_Click(object sender, EventArgs e)
        {

            //string fileNameNo1 = Path.GetFileName(fileUpload.PostedFile.FileName); //获取文件名和扩展名
            //string DirectoryName1 = Path.GetDirectoryName(fileUpload.PostedFile.FileName); //获取文件所在目录
            //string Extension = Path.GetExtension(fileUpload.PostedFile.FileName); //获取扩展名
            //string fileName1 = Path.GetFileNameWithoutExtension(fileUpload.PostedFile.FileName); //获取文件名（不包括扩展名）
            //string fullPath = Path.GetFullPath(fileUpload.PostedFile.FileName); //获取文件的绝对路径
            //string PathRoot = Path.GetPathRoot(fileUpload.PostedFile.FileName); //获取文件所在地分区


            var username = Request.Form["fileUpload"];
            string DirectoryName = Path.GetFullPath(fileUpload.PostedFile.FileName);
            string fileNameNo = Path.GetFileName(fileUpload.PostedFile.FileName);
            clsAllnew BusinessHelp = new clsAllnew();
            string image64 = "";
            DirectoryName = @"D:\all\公司素材\软件设计图片素材\psd素材\116ae547bbc0baa3528d6b3f81cb7812.jpg";

            if (File.Exists(DirectoryName))
            {
                image64 = BusinessHelp.ImgToBase64String(DirectoryName);
            }
            List<clt_detail_info> cloumnlist = readCards.FindAll(s => s.Order_id != null && s.Order_id == "8");
            cloumnlist[0].img = image64;
            cloumnlist[0].FFileName = fileNameNo;
            BusinessHelp.createPIC_info_Server(cloumnlist);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('添加成功')</script>");

        }


    }
}