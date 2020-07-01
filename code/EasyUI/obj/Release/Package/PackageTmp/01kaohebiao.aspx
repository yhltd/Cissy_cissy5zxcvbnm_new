<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01kaohebiao.aspx.cs" Inherits="EasyUI._01kaohebiao" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01kaohebiao"  EnableEventValidation = "false"  CodeBehind="01kaohebiao.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/kaohebiao.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 39px;
            width: 166px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid" >
        </div>
    </div>

   
   <div id="search-window" title="查询窗口" style="width: 435px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        子sku：
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
           <%-- <div style="text-align: center; padding: 5px;">
                <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">
                    取消</a>
            </div>--%>
        </div>

        <div id="excelWin1" title="导出预览" style="width: 1151px; height: 300px;">
        
            <div style="padding: 20px 20px 40px 80px; text-align: center; margin-left: 3px; margin-right: 79px;">
                    <form id="Form2" method="post" action="">
                    <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    </form>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="998px" style="margin-left: 0px; margin-top: 36px">
                    <Columns>
                        <asp:BoundField DataField="销售员" HeaderText="销售员" SortExpression="销售员" />
                        <asp:BoundField DataField="平台账户" HeaderText="平台账户" SortExpression="平台账户" />
                        <asp:BoundField DataField="父SKU" HeaderText="父SKU" SortExpression="父SKU" />
                        <asp:BoundField DataField="商品名称" HeaderText="商品名称" SortExpression="商品名称" />
                        <asp:BoundField DataField="子sku" HeaderText="子sku" SortExpression="子sku" />
                        <asp:BoundField DataField="净数量" HeaderText="净数量" SortExpression="净数量" ReadOnly="True" />
                        <asp:BoundField DataField="利润金额" HeaderText="利润金额" SortExpression="利润金额" ReadOnly="True" />
                        <asp:BoundField DataField="提成比例" HeaderText="提成比例" SortExpression="提成比例" />
                        <asp:BoundField DataField="汇率" HeaderText="汇率" SortExpression="汇率" />
                        <asp:BoundField DataField="提成" HeaderText="提成" ReadOnly="True" SortExpression="提成" />
                        <asp:BoundField DataField="评价考核系数" HeaderText="评价考核系数" SortExpression="评价考核系数" />
                        <asp:BoundField DataField="冗余考核系数" HeaderText="冗余考核系数" ReadOnly="True" SortExpression="冗余考核系数" />
                        <asp:BoundField DataField="无利润考核系数" HeaderText="无利润考核系数" ReadOnly="True" SortExpression="无利润考核系数" />
                        <asp:BoundField DataField="应发提成" HeaderText="应发提成" ReadOnly="True" SortExpression="应发提成" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="SELECT
	Sale.saler as '销售员',
	Sale.account as '平台账户',
	Sale.fatherSKU as '父SKU',
	Sale.name as '商品名称',
	Sale.sunSKU as '子sku',
	aa.净销售数量 as '净数量',
	aa.[利润] as '利润金额',
	Sale.commission AS '提成比例',
	Sale.rate AS 汇率,
	aa.[净销售额] * Sale.commission* Sale.rate AS 提成,
	Peizhi.rate1 AS 评价考核系数,
	(
CASE
	
	WHEN ( Sale.redundancy&gt; 180 ) THEN
	( 1-Peizhi.over181 ) 
	WHEN ( Sale.redundancy&lt;= 180 AND Sale.redundancy &gt; 90 ) THEN
	( 1-Peizhi.betw91180 ) 
	WHEN ( Sale.redundancy&lt;= 90 AND Sale.redundancy &gt; 30 ) THEN
	( 1-Peizhi.betw3190 ) 
	WHEN ( Sale.redundancy&lt;= 30 AND Sale.redundancy &gt; 0 ) THEN
	1 
END 
	) AS 冗余考核系数,
	( CASE WHEN aa.利润 &gt; 0 THEN 1 ELSE 0 END ) AS 无利润考核系数,
	((
		CASE
				
				WHEN aa.利润 &gt; 0 THEN
				1 ELSE 0 
			END 
				) * (
			CASE
					
					WHEN ( Sale.redundancy&gt; 180 ) THEN
					( 1-Peizhi.over181 ) 
					WHEN ( Sale.redundancy&lt;= 180 AND Sale.redundancy &gt; 90 ) THEN
					( 1-Peizhi.betw91180 ) 
					WHEN ( Sale.redundancy&lt;= 90 AND Sale.redundancy &gt; 30 ) THEN
					( 1-Peizhi.betw3190 ) 
					WHEN ( Sale.redundancy&lt;= 30 AND Sale.redundancy &gt; 0 ) THEN
					1 
				END 
				) * Peizhi.rate1* aa.[净销售额] * Sale.commission* Sale.rate 
			) AS 应发提成 
		FROM
			[dbo].[Sale]
			LEFT JOIN (
			SELECT
				Sales.sunSKU AS sunSKU,
                    Sales.account,
				SUM(CASE WHEN Sales.type= 'Order' THEN Sales.quantity WHEN Sales.type= 'Refund' THEN -Sales.quantity END) AS 净销售数量,
				SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.sales * Sales.quantity END ) AS 销售额,
				(
					SUM ((
						CASE
								
								WHEN Sales.type = 'Refund' THEN
								Sales.sales * Sales.quantity * Sale.rate 
								WHEN Sales.type = 'Transfer' THEN
								0 
                                WHEN Sales.type = 'Order' THEN
								(Sales.total- ( Product.cost + Freight.freight )) * Sales.quantity * Sale.rate ELSE Sales.total * Sales.quantity* Sale.rate  
							END 
							) 
						)) AS 利润,
					SUM (
					CASE
							
							WHEN Sales.type= 'Order' THEN
							Sales.total * Sales.quantity 
							WHEN Sales.type= 'Refund' THEN
							Sales.sales * Sales.quantity 
						END 
						) AS 净销售额,
						SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.quantity WHEN Sales.type= 'Refund' THEN - Sales.quantity END ) AS 净售出数量 
					FROM
						Sales
						LEFT JOIN Sale ON Sale.sunSKU= Sales.sunSKU
                    	AND Sale.account = Sales.account
						LEFT JOIN Product ON Sale.name = Product.name 
						LEFT JOIN Country ON Country.account = Sales.account
			            LEFT JOIN Freight ON Freight.country = Country.country  
					GROUP BY
						Sales.sunSKU,Sales.account 
					)  AS aa ON aa.sunSKU = Sale.sunSKU and aa.account = Sale.account
LEFT JOIN Peizhi ON Peizhi.star = Sale.star"></asp:SqlDataSource>

            </div>
        </div>

</body>
</html>

