<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="00caiwubiao2.aspx.cs" Inherits="EasyUI._0caiwubiao2" %>--%>

<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._0caiwubiao2" EnableEventValidation="false" CodeBehind="00caiwubiao2.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/caiwubiao2.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 35px;
            width: 100px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px; overflow-y: hidden">
        <div id="grid">
        </div>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 800px; height: 400px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
                <table>
                    <tr>
                        <td>销售账户：
                        </td>
                        <td>
                            <input name="sale" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                        <td>实时汇率：
                        </td>
                        <td>
                            <input name="rate" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>产品名称：
                        </td>
                        <td>
                            <input name="name" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>单件运营提成占比：
                        </td>
                        <td>
                            <input name="commission" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>广告占比：
                        </td>
                        <td>
                            <input name="advertisment" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>退货率：
                        </td>
                        <td>
                            <input name="returnRate" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>平台佣金率：
                        </td>
                        <td>
                            <input name="commissionRate" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div id="search-window" title="查询窗口" style="width: 350px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
                <table>
                    <tr>
                        <td>产品名称：
                        </td>
                        <td>
                            <input name="s_title" id="s_title" style="width: 150px;" />
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
            <form id="Form2" method="post" action="">
                <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Height="88px" style="margin-left: 27px; margin-top: 15px" Width="853px">
                    <Columns>
                        <asp:BoundField DataField="销售账户" HeaderText="销售账户" SortExpression="销售账户" />
                        <asp:BoundField DataField="实时汇率" HeaderText="实时汇率" SortExpression="实时汇率" />
                        <asp:BoundField DataField="产品名称            " HeaderText="产品名称            " SortExpression="产品名称            " />
                        <asp:BoundField DataField="单件运营提成占比（试算）" HeaderText="单件运营提成占比（试算）" SortExpression="单件运营提成占比（试算）" />
                        <asp:BoundField DataField="广告占比（试算）" HeaderText="广告占比（试算）" SortExpression="广告占比（试算）" />
                        <asp:BoundField DataField="退货率（试算）" HeaderText="退货率（试算）" SortExpression="退货率（试算）" />
                        <asp:BoundField DataField="平台佣金率（试算）" HeaderText="平台佣金率（试算）" SortExpression="平台佣金率（试算）" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select sale as '销售账户',rate as '实时汇率',name as '产品名称            ',commission as '单件运营提成占比（试算）',advertisment as '广告占比（试算）',returnRate as '退货率（试算）',commissionRate as '平台佣金率（试算）' from Trial"></asp:SqlDataSource>
            </form>

        </div>
    </div>

</body>
</html>
