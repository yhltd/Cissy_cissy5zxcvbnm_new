<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="00caiwubiao3.aspx.cs" Inherits="EasyUI._0caiwubiao3" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._0caiwubiao3"  EnableEventValidation = "false"  CodeBehind="00caiwubiao3.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/caiwubiao3.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 39px;
            width: 130px;
        }
    </style>
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
                        date/time：
                    </td>
                    <td><input name="saleDate"  class="easyui-validatebox"  style="width: 170px;" /></td>
                </tr>
                <tr>
                    <td>
                        account：
                    </td>
                    <td>
                        <input name="account" class="easyui-validatebox" required="true" style="width: 150px;" />
                    </td>
                    <td>
                        sku：
                    </td>
                    <td>
                        <input name="sunSKU" class="easyui-validatebox"  style="width: 150px;" />
                    </td>  
                </tr>
                <tr>                  
                    <td>
                        type：
                    </td>
                    <td>
                        <input name="type" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        quantity：
                    </td>
                    <td>
                        <input name="quantity" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        fulfillment：
                    </td>
                    <td>
                        <input name="fulfillment" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        order city：
                    </td>
                    <td>
                        <input name="city" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr> 
                <tr>
                    <td>
                        order state：
                    </td>
                    <td>
                        <input name="state" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        product sales：
                    </td>
                    <td>
                        <input name="sales" class="easyui-validatebox"  style="width: 150px;" />
                    </td>      
                </tr>
                <tr>
                    <td>
                        total：
                    </td>
                    <td>
                        <input name="total" class="easyui-validatebox"  style="width: 150px;" />
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
                    <td>
                        sku：
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
            <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">
                取消</a>
        </div>--%>
    </div>

    <div id="excelWin1" title="导出预览" style="width: 1000px; height: 300px;">
        
        <div style="padding: 20px 20px 40px 80px; text-align: center">
                <form id="Form2" method="post" action="">
                <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" style="margin-left: 56px; margin-top: 36px" Width="802px">
                        <Columns>
                            <asp:BoundField DataField="account" HeaderText="account" SortExpression="account" />
                            <asp:BoundField DataField="saleDate" HeaderText="saleDate" ReadOnly="True" SortExpression="saleDate" />
                            <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                            <asp:BoundField DataField="sunSKU" HeaderText="sunSKU" SortExpression="sunSKU" />
                            <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity" />
                            <asp:BoundField DataField="fulfillment" HeaderText="fulfillment" SortExpression="fulfillment" />
                            <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                            <asp:BoundField DataField="state" HeaderText="state" SortExpression="state" />
                            <asp:BoundField DataField="sales" HeaderText="sales" SortExpression="sales" />
                            <asp:BoundField DataField="total" HeaderText="total" SortExpression="total" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select id, account,convert(char(20),saleDate,120) as saleDate,type,sunSKU,quantity,fulfillment,city,state,sales,total from Sales"></asp:SqlDataSource>
                </form>

        </div>
    </div>


</body>
</html>

