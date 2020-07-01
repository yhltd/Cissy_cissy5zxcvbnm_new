<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01lirunshisuan.aspx.cs" Inherits="EasyUI._01lirunshisuan" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01lirunshisuan"  EnableEventValidation = "false"  CodeBehind="01lirunshisuan.aspx.cs" %>

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
    <script src="/dataPage/lirunshisuan.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 46px;
            width: 141px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid">
            
        </div>
        <%--<button onclick=""><img src="file/1.jpg"></img></button>--%>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 414px; height: 247px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        拟定产品售价：
                    </td>
                    <td>
                        <input name="price" class="easyui-validatebox"  style="width: 150px;" />
                    </td> 
                </tr>
            </table>
            </form>
        </div>
    </div>
   <div id="search-window" title="查询窗口" style="width: 425px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        产品子编号：
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

        <div id="excelWin1" title="导出预览" style="width: 1183px; height: 300px;">
        
            <div style="padding: 20px 20px 40px 80px; text-align: center; margin-left: 40px;">
                    <form id="Form2" method="post" action="">
                    <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </form>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="999px" style="margin-left: 0px; margin-top: 28px">
                    <Columns>
                        <asp:BoundField DataField="产品编号" HeaderText="产品编号" SortExpression="产品编号" />
                        <asp:BoundField DataField="产品子编号" HeaderText="产品子编号" SortExpression="产品子编号" />
                        <asp:BoundField DataField="产品名称" HeaderText="产品名称" SortExpression="产品名称" />
                        <asp:BoundField DataField="拟定产品售价" HeaderText="拟定产品售价" SortExpression="拟定产品售价" />
                        <asp:BoundField DataField="采购成本" HeaderText="采购成本" SortExpression="采购成本" />
                        <asp:BoundField DataField="产品汇率" HeaderText="产品汇率" SortExpression="产品汇率" />
                        <asp:BoundField DataField="运营提成占比" HeaderText="运营提成占比" SortExpression="运营提成占比" />
                        <asp:BoundField DataField="广告费占比" HeaderText="广告费占比" SortExpression="广告费占比" />
                        <asp:BoundField DataField="退货率" HeaderText="退货率" SortExpression="退货率" />
                        <asp:BoundField DataField="平台佣金占比" HeaderText="平台佣金占比" SortExpression="平台佣金占比" />
                        <asp:BoundField DataField="实际到手价" HeaderText="实际到手价" ReadOnly="True" SortExpression="实际到手价" />
                        <asp:BoundField DataField="利润" HeaderText="利润" ReadOnly="True" SortExpression="利润" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="SELECT 
	Trial.no as '产品编号',
	Trial.num as '产品子编号',
              Trial.name as '产品名称',
	Trial.price as '拟定产品售价',
	Trial.cost as '采购成本',
	Trial.rate as '产品汇率',
	Trial.commission AS '运营提成占比',
	Trial.advertisment AS '广告费占比',
	Trial.returnRate AS '退货率',
	Trial.commissionRate AS '平台佣金占比',
	Trial.price - Trial.price*Trial.commissionRate - Trial.price*Trial.advertisment - Trial.FBA - Trial.three - Trial.thirty as '实际到手价',
	(Trial.price - Trial.price*Trial.commissionRate - Trial.price*Trial.advertisment - Trial.FBA - Trial.three - Trial.thirty)*Trial.rate - Trial.cost -  Freight.freight - Trial.cost*Trial.returnRate - Trial.price*Trial.commission AS '利润'
FROM
	[dbo].[Trial]
LEFT JOIN Country on Country.account = Trial.sale
LEFT JOIN Freight on Freight.country = Country.country"></asp:SqlDataSource>

            </div>
        </div>


</body>
</html>
