<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01shejibiao.aspx.cs" Inherits="EasyUI._01shejibiao" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01shejibiao"  EnableEventValidation = "false"  CodeBehind="01shejibiao.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/datagrid-export.js" type="text/javascript"></script>
    <script src="/dataPage/shejibiao.js" type="text/javascript"></script>
    <script type="text/javascript">

        //单击事件写法
        ShowDetail1 = function (id) {
            alert("上传"+id);
        },
        ShowDetail2 = function (id) {
            alert("下载"+id);
        }

    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px; overflow-y: hidden">
        <div id="grid">
        </div>
        <%--<button onclick=""><img src="file/1.jpg"></img></button>--%>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 800px; height: 400px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
                <table>
                    <tr>
                        <td>产品编号：
                        </td>
                        <td>
                            <input name="no" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                        <td>产品子编号：
                        </td>
                        <td>
                            <input name="num" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>图片：
                        </td>
                        <td>
                            <input name="img" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>  
                    </tr>

                    
                </table>
            </form>
        </div>
    </div>
    <div id="search-window" title="查询窗口" style="width: 350px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post" style="width: 218px">
                <br />
                <br />
                <table>
                    <tr>
                        <td>序号：
                        </td>
                        <td>
                            <input name="s_title" id="s_title" style="width: 150px; height: 35px;" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="SearchOK()" id="btn-search" icon="icon-ok">确定</a>
            <a href="javascript:void(0)" onclick="closeSearchWindow()" id="btn-search-cancel" icon="icon-cancel">取消</a>
        </div>
    </div>
    <div id="excelWin" title="从excel导入" style="width: 350px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form id="Form1" method="post" runat="server">
                <table>
                    <tr>
                        <asp:FileUpload ID="fileId" runat="server" Width="433px" />
                        <asp:Button ID="Button1" runat="server" Text="上传" OnClientClick="return check()" OnClick="Export_Click" />
                    </tr>
                </table>
            </form>
        </div>
        <%--<div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">取消</a>
        </div>--%>
    </div>

    <div id="excelWin1" title="导出预览" style="width: 1000px; height: 300px;">
        
        <div style="padding: 20px 20px 40px 80px; text-align: center">
                <table>
                    <tr>
                        <button id="Button2" runat="server" text="下载表格" onclick="Export_Click1" />
                    </tr>
                </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" Width="654px">
                <Columns>
                    <asp:BoundField DataField="no" HeaderText="no" SortExpression="no" />
                    <asp:BoundField DataField="grouping" HeaderText="grouping" SortExpression="grouping" />
                    <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                    <asp:BoundField DataField="cost" HeaderText="cost" SortExpression="cost" />
                    <asp:BoundField DataField="buyer" HeaderText="buyer" SortExpression="buyer" />
                    <asp:BoundField DataField="sale" HeaderText="sale" SortExpression="sale" />
                    <asp:BoundField DataField="length" HeaderText="length" SortExpression="length" />
                    <asp:BoundField DataField="width" HeaderText="width" SortExpression="width" />
                    <asp:BoundField DataField="high" HeaderText="high" SortExpression="high" />
                    <asp:BoundField DataField="weight" HeaderText="weight" SortExpression="weight" />
                    <asp:BoundField DataField="pack" HeaderText="pack" SortExpression="pack" />
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#487575" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#275353" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select no, grouping, name, cost, buyer, sale, length, width, high, weight, pack from Product"></asp:SqlDataSource>

        </div>
    </div>

</body>
</html>
