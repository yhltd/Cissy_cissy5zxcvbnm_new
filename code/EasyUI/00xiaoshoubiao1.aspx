<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="00xiaoshoubiao1.aspx.cs" Inherits="EasyUI.no_xiaoshouluru" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI.no_xiaoshouluru"  EnableEventValidation = "false"  CodeBehind="00xiaoshoubiao1.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/xiaoshoubiao1.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid" >
        </div>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 800px; height: 400px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        销售账户：
                    </td>
                    <td>
                        <input name="account" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr
                <tr>
                    <td>
                        小组：
                    </td>
                    <td>
                        <input name="smallGroup" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        销售专员：
                    </td>
                    <td>
                        <input name="saler" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        货件类型：
                    </td>
                    <td>
                        <input name="type" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        ASIN：
                    </td>
                    <td>
                        <input name="asin" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        子SKU：
                    </td>
                    <td>
                        <input name="sunSKU" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        产品名称：
                    </td>
                    <td>
                        <input name="name" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        父SKU：
                    </td>
                    <td>
                        <input name="fatherSKU" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        FBA派送费：
                    </td>
                    <td>
                        <input name="FBA" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        第三方派送费：
                    </td>
                    <td>
                        <input name="three" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        30天仓租费：
                    </td>
                    <td>
                        <input name="thirty" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
   <div id="search-window" title="查询窗口"  style="width: 350px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        子SKU：
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
            <a href="javascript:void(0)" onclick="closeSearchWindow()" id="btn-search-cancel" icon="icon-cancel">
                取消</a>
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
                <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" style="margin-left: 0px; margin-top: 22px" Width="796px">
                        <Columns>
                            <asp:BoundField DataField="销售账户" HeaderText="销售账户" SortExpression="销售账户" />
                            <asp:BoundField DataField="小组" HeaderText="小组" SortExpression="小组" />
                            <asp:BoundField DataField="销售专员" HeaderText="销售专员" SortExpression="销售专员" />
                            <asp:BoundField DataField="货件类型" HeaderText="货件类型" SortExpression="货件类型" />
                            <asp:BoundField DataField="ASIN" HeaderText="ASIN" SortExpression="ASIN" />
                            <asp:BoundField DataField="子SKU" HeaderText="子SKU" SortExpression="子SKU" />
                            <asp:BoundField DataField="产品名称" HeaderText="产品名称" SortExpression="产品名称" />
                            <asp:BoundField DataField="父SKU" HeaderText="父SKU" SortExpression="父SKU" />
                            <asp:BoundField DataField="FBA派送费" HeaderText="FBA派送费" SortExpression="FBA派送费" />
                            <asp:BoundField DataField="第三方派送费" HeaderText="第三方派送费" SortExpression="第三方派送费" />
                            <asp:BoundField DataField="30天仓租费" HeaderText="30天仓租费" SortExpression="30天仓租费" />
                        </Columns>
                    </asp:GridView>
&nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select account as '销售账户',smallGroup as '小组',saler as '销售专员',type as '货件类型',asin as 'ASIN',sunSKU as '子SKU',name as '产品名称',fatherSKU as '父SKU',FBA as 'FBA派送费',three as '第三方派送费',thirty as '30天仓租费' from Sale"></asp:SqlDataSource>
                </form>

        </div>
    </div>
</body>
</html>