<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="frmShejibuyulu.aspx.cs" Inherits="EasyUI.frmShejibuyulu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="/Myadmin/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="/Myadmin/js/json2.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Openpic_file() {
            alert("请输入查找信息！");

            try {
                var Message = "\u8bf7\u9009\u62e9\u6587\u4ef6\u5939"; //选择框提示信息
                var Shell = new ActiveXObject("Shell.Application");
                var Folder = Shell.BrowseForFolder(0, Message, 64, 17); //起始目录为：我的电脑
                //var Folder = Shell.BrowseForFolder(0,Message,0); //起始目录为：桌面

                if (Folder != null) {
                    Folder = Folder.items(); // 返回 FolderItems 对象

                    Folder = Folder.item(); // 返回 Folderitem 对象
                    Folder = Folder.Path; // 返回路径

                    if (Folder.charAt(Folder.length - 1) != "\\") {
                        Folder = Folder + "\\";
                    }
                    document.getElementByIdx_x("pathname").value = Folder;
                    return Folder;
                }
            }
            catch (e) {
                alert(e.message);
            }
            //$.ajax({
            //    type: "post", //要用post方式                 
            //    url: "frmShejibuyulu.aspx/GetRankedUserDept",//方法所在页面和方法名
            //    contentType: "application/json; charset=utf-8",
            //    async: false,
            //    dataType: "json",
            //    data: JSON.stringify(postData),
            //    success: function (data) {

            //        alert(data.d);//返回的数据用data.d获取内容
            //        //  window.location.reload();
            //    },
            //    error: function (err) {
            //        alert(err);
            //    }
            //});


        }
        function test() {
            alert("sdsdsds！");
        }
        function Upload_openBrowse() {

            var ie = navigator.appName == "Microsoft Internet Explorer" ? true : false;
            if (ie) {
                document.getElementById("fileUpload").click();     // 通过document元素点击FileUpload控件
                //document.getElementById("filename").value = document.getElementById("FileUpload1").value;
            }
            else {
                var a = document.createEvent("MouseEvents");//FF的处理 
                a.initEvent("click", true, true);
                document.getElementById("fileUpload").dispatchEvent(a);
            }
        }



    </script>
</head>
<body>
    <form id="form1" runat="server">
        <%--        <input type="button" value="保存" onclick="document.execCommand('SaveAs')"/>--%>
        <%--<input type="button" id="addpic_id" value="up" onclick="Upload_openBrowse()" />--%>
        <%--<asp:Button ID="addpic_id" runat="server" Text="Button" OnClientClick="Upload_openBrowse()" />--%>
        <%--  <input type="text" id="pathname" /></td>--%>
        <div>
            <tr id="trUpload" runat="server">
                <td style="width: 35%">
                    <asp:FileUpload ID="fileUpload" Width="25%" runat="server" />
                </td>
                <td style="width: 10%" nowrap="nowrap">
                    <asp:Button ID="btnAddAttach" runat="server" Text="添加" CssClass="ui-btn ui-btn-add"
                        OnClick="btnAddAttach_Click" />
                </td>
            </tr>
            <asp:GridView ID="gvList" runat="server" Width="90%" AutoGenerateColumns="False"
                CssClass="mGrid" align="center"
                CellPadding="0" Style="margin-top: 5px; margin-right: 0px; margin-bottom: 0px;" GridLines="Vertical"
                EmptyDataText="&lt;span class='ui-icon ui-icon-remind' style='float: left; margin-right: .3em;'&gt;&lt;/span&gt;&lt;strong&gt;提醒：&lt;/strong&gt;对不起！您所查询的数据不存在。" OnRowCommand="GridView_OnRowCommand" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" ViewStateMode="Disabled" OnRowCreated="GridView1_RowCreated" OnRowDataBound="GridView_RowDataBound" OnDataBound="GridView1_DataBound" OnSelectedIndexChanged="gvList_SelectedIndexChanged">
                <Columns>

                    <asp:BoundField HeaderText="产品编号 " DataField="no">
                        <%--dengluzhanghao--%>
                        <%--<FooterStyle HorizontalAlign="Left" />--%>
                        <ControlStyle Width="60px" />
                        <ItemStyle HorizontalAlign="Center" Width="17%"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="产品子编号 " DataField="num">
                        <%--denglumima--%>
                        <ControlStyle Width="60px" />
                        <ItemStyle HorizontalAlign="Center" Width="17%"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField HeaderText="图片" DataField="img">
                        <%--suoshujigou--%>
                        <ControlStyle Width="30px" />
                        <ItemStyle HorizontalAlign="Center" Width="17%"></ItemStyle>
                    </asp:BoundField>

                    <asp:ButtonField ButtonType="Button" Text="删除" HeaderText="删除" CommandName="Btn_Operation">
                        <ControlStyle Width="50px" />
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:ButtonField>

                    <asp:CommandField HeaderText="编辑" ShowEditButton="true" Visible="False">

                        <ControlStyle Font-Bold="True" Width="50px" />
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CommandField>


                    <asp:ButtonField ButtonType="Button" Text="查看" HeaderText="查看图片" CommandName="Btn_View">
                        <ControlStyle Width="50px" />
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:ButtonField>

                    <asp:ButtonField ButtonType="Button" Text="上传" HeaderText="上传图片" CommandName="Btn_upload">
                        <ControlStyle Width="50px" />
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>

                    </asp:ButtonField>

                    <%--     <asp:ImageField HeaderText="图片" DataImageUrlField="image_path" " Visible="False">

                        <ControlStyle Width="30px" />
                        <ItemStyle HorizontalAlign="Center" Width="17%"></ItemStyle>
                    </asp:ImageField>--%>

                    <asp:TemplateField HeaderText="图片预览">
                        <ItemTemplate>
                            <img src='CQU_CHM_ShowImage.aspx?QiHao=<%# Eval("Order_id") %>' width="150px" height="100px" />

                        </ItemTemplate>

                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <%--  <asp:FileUpload runat="server" ID="FuTest" />--%>
        </div>
    </form>
</body>
</html>
