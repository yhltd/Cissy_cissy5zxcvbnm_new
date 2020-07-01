<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01xiaoshouqingkuang2.aspx.cs" Inherits="EasyUI._01xiaoshouqingkuang2" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01xiaoshouqingkuang2"  EnableEventValidation = "false"  CodeBehind="01xiaoshouqingkuang2.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/xiaoshouqingkuang2.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 51px;
            width: 154px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid" >
        </div>
    </div>

   
   <div id="search-window" title="查询窗口" style="width: 411px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        州名：
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

        <div id="excelWin1" title="导出预览" style="width: 1095px; height: 300px;">
        
            <div style="padding: 20px 20px 40px 80px; text-align: center; margin-left: 40px;">
                    <form id="Form2" method="post" action="">
                    <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    </form>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="843px" style="margin-left: 0px; margin-top: 36px">
                    <Columns>
                        <asp:BoundField DataField="州" HeaderText="州" SortExpression="州" />
                        <asp:BoundField DataField="售出数量" HeaderText="售出数量" SortExpression="售出数量" ReadOnly="True" />
                        <asp:BoundField DataField="商品销售额" HeaderText="商品销售额" SortExpression="商品销售额" ReadOnly="True" />
                        <asp:BoundField DataField="退货数量" HeaderText="退货数量" SortExpression="退货数量" ReadOnly="True" />
                        <asp:BoundField DataField="退货金额" HeaderText="退货金额" ReadOnly="True" SortExpression="退货金额" />
                        <asp:BoundField DataField="退货率" HeaderText="退货率" ReadOnly="True" SortExpression="退货率" />
                        <asp:BoundField DataField="利润" HeaderText="利润" ReadOnly="True" SortExpression="利润" />
                        <asp:BoundField DataField="利润率" HeaderText="利润率" ReadOnly="True" SortExpression="利润率" />
                        <asp:BoundField DataField="广告占总销售" HeaderText="广告占总销售" ReadOnly="True" SortExpression="广告占总销售" />
                        <asp:BoundField DataField="仓储占总销售" HeaderText="仓储占总销售" ReadOnly="True" SortExpression="仓储占总销售" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="SELECT
	Sales.state AS '州',
	SUM( CASE WHEN Sales.type = 'Order' THEN Sales.quantity ELSE 0 END ) AS 售出数量,
	SUM( CASE WHEN Sales.type = 'Order' THEN Sales.sales * Sales.quantity ELSE 0 END ) AS 商品销售额,
	SUM( CASE WHEN Sales.type = 'Refund' THEN Sales.quantity ELSE 0 END ) AS 退货数量,
	SUM( CASE WHEN Sales.type = 'Refund' THEN Sales.total * Sales.quantity ELSE 0 END ) AS 退货金额,
	ROUND(
	CAST ( SUM( CASE WHEN Sales.type = 'Refund' THEN Sales.quantity ELSE 0 END ) AS FLOAT ) / CAST ( SUM( CASE WHEN Sales.type = 'Refund' OR Sales.type = 'Order' THEN Sales.quantity END ) AS FLOAT ),
	4 
	) AS 退货率,
	(
	SUM(
	(
CASE
	
	WHEN Sales.type = 'Refund' THEN
	Sales.sales * Sales.quantity * Sale.rate 
	WHEN Sales.type = 'Transfer' THEN
	0 
	WHEN Sales.type = 'Order' THEN
	( Sales.total - ( Sales.cost + Product.freight ) ) * Sales.quantity * Sale.rate ELSE Sales.total * Sales.quantity * Sale.rate 
END 
	) 
	) 
	) AS 利润,
	ROUND(
		(
			(
				SUM(
					(
					CASE
							
							WHEN Sales.type = 'Refund' THEN
							Sales.sales * Sales.quantity * Sale.rate 
							WHEN Sales.type = 'Transfer' THEN
							0 
							WHEN Sales.type = 'Order' THEN
							( Sales.total - ( Sales.cost + Product.freight ) ) * Sales.quantity * Sale.rate ELSE Sales.total * Sales.quantity * Sale.rate 
						END 
						) 
					) 
				) / SUM( CASE WHEN Sales.type = 'Order' THEN Sales.sales * Sales.quantity * Sale.rate ELSE 0 END ) 
			),
			4 
		) AS 利润率,
		SUM( CASE WHEN Sales.type = 'Service Fee' THEN Sales.total * Sales.quantity ELSE 0 END ) / SUM( CASE WHEN Sales.type = 'Order' THEN Sales.sales * Sales.quantity END ) AS 广告占总销售,
		SUM( CASE WHEN Sales.type = 'FBA Inventory Fee' THEN Sales.total * Sales.quantity ELSE 0 END ) / SUM( CASE WHEN Sales.type = 'Order' THEN Sales.sales * Sales.quantity END ) AS 仓储占总销售 
	FROM
		Sales
		LEFT JOIN Sale ON Sale.sunSKU = Sales.sunSKU AND Sale.account = Sales.account
		LEFT JOIN Product ON Sale.NAME = Product.NAME 
        LEFT JOIN Country ON Country.account = Sales.account
		LEFT JOIN Freight ON Freight.country = Country.country 
GROUP BY
Sales.state,Sales.sunSKU"></asp:SqlDataSource>

            </div>
        </div>

</body>
</html>

