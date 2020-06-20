<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01kaohebiao1.aspx.cs" Inherits="EasyUI._01kaohebiao1" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01kaohebiao1"  EnableEventValidation = "false"  CodeBehind="01kaohebiao1.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/kaohebiao1.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 38px;
            width: 120px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid" >
        </div>
    </div>

   
   <div id="search-window" title="查询窗口" style="width: 350px; height: 200px;">
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

        <div id="excelWin1" title="导出预览" style="width: 987px; height: 300px;">
        
            <div style="padding: 20px 20px 40px 80px; text-align: center; margin-left: 40px;">
                    <form id="Form2" method="post" action="">
                    <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </form>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="817px" style="margin-left: 0px; margin-top: 27px">
                    <Columns>
                        <asp:BoundField DataField="销售员" HeaderText="销售员" SortExpression="销售员" />
                        <asp:BoundField DataField="净销售数量" HeaderText="净销售数量" SortExpression="净销售数量" ReadOnly="True" />
                        <asp:BoundField DataField="净销售额" HeaderText="净销售额" SortExpression="净销售额" ReadOnly="True" />
                        <asp:BoundField DataField="利润" HeaderText="利润" SortExpression="利润" ReadOnly="True" />
                        <asp:BoundField DataField="提成" HeaderText="提成" ReadOnly="True" SortExpression="提成" />
                        <asp:BoundField DataField="无利润考核系数" HeaderText="无利润考核系数" ReadOnly="True" SortExpression="无利润考核系数" />
                        <asp:BoundField DataField="考评后应发提成" HeaderText="考评后应发提成" ReadOnly="True" SortExpression="考评后应发提成" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="SELECT
	Sale.saler as '销售员',
	SUM(aa.净销售数量) AS 净销售数量,
	SUM(aa.[净销售额]) AS 净销售额,
	SUM(aa.[利润]) AS 利润,
	SUM(aa.[净销售额] * Sale.commission* Sale.rate )AS 提成,
	( CASE WHEN SUM(aa.[利润]) &gt; 0 THEN 1 ELSE 0 END ) AS 无利润考核系数,
	SUM((
		CASE
				
				WHEN aa.[利润] &gt; 0 THEN
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
			) AS 考评后应发提成 
		FROM
			[dbo].[Sale]
			LEFT JOIN (
			SELECT
				Sales.sunSKU AS sunSKU,
				SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.quantity WHEN Sales.type= 'Refund' THEN - Sales.quantity END ) AS 净销售数量,
				SUM ( CASE WHEN Sales.type= 'Order' THEN Sales.sales * Sales.quantity END ) AS 销售额,
				(
					SUM ((
						CASE
								
								WHEN Sales.type = 'Refund' THEN
								Sales.sales * Sales.quantity * Sale.rate 
								WHEN Sales.type = 'Transfer' THEN
								0 
                                WHEN Sales.type = 'Order' THEN
								(Sales.total- ( Product.cost + Product.freight )) * Sales.quantity * Sale.rate ELSE Sales.total * Sales.quantity* Sale.rate  
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
						LEFT JOIN Product ON Sale.name = Product.name 
					GROUP BY
						Sales.sunSKU 
					) AS aa ON aa.sunSKU = Sale.sunSKU
LEFT JOIN Peizhi ON Peizhi.star = Sale.star
GROUP BY Sale.saler"></asp:SqlDataSource>

            </div>
        </div>

</body>
</html>


