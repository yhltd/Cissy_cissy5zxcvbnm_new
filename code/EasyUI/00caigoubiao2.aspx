<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="00caigoubiao2.aspx.cs" Inherits="EasyUI._0caigoubiao2"  EnableEventValidation = "false" %>
<%--CodeFile="00caigoubiao2.aspx.cs"--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/caigoubiao2.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 35px;
            width: 184px;
            margin-left: 0px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px;overflow-y: hidden">
        <div id="grid" >
        </div>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 623px; height: 216px; margin-right: 0px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
            <table>
                <tr>
                    <td>
                        产品名称：
                    </td>
                    <td>
                        <input name="name" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        产品编号：
                    </td>
                    <td>
                        <input name="no" class="easyui-validatebox" required="true" style="width: 150px;" />
                    </td>
                    <td>
                        产品子编号：
                    </td>
                    <td>
                        <input name="num" class="easyui-validatebox" required="true" style="width: 150px;" />
                    </td>
                </tr>
                
                <tr>
                    <td>
                        颜色/型号：
                    </td>
                    <td>
                        <input name="color" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        采购成本：
                    </td>
                    <td>
                        <input name="cost" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                     
            </table>
            </form>
        </div>
    </div>
   <div id="search-window" title="查询窗口" style="width: 496px; height: 181px;">
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

        <div id="excelWin1" title="导出预览" style="width: 1165px; height: 300px;">
        
            <div style="padding: 20px 20px 40px 80px; text-align: center; margin-left: 40px;">
                    <form id="Form2" method="post" action="">
                    <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </form>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="999px" style="margin-left: 0px; margin-top: 58px">
                    <Columns>
                        <asp:BoundField DataField="产品编号" HeaderText="产品编号" SortExpression="产品编号" />
                        <asp:BoundField DataField="产品子编号" HeaderText="产品子编号" SortExpression="产品子编号" />
                        <asp:BoundField DataField="产品名称" HeaderText="产品名称" SortExpression="产品名称" />
                        <asp:BoundField DataField="颜色/型号" HeaderText="颜色/型号" SortExpression="颜色/型号" />
                        <asp:BoundField DataField="采购成本（试算）" HeaderText="采购成本（试算）" SortExpression="采购成本（试算）" />
                        <asp:BoundField DataField="产品长（厘米）" HeaderText="产品长（厘米）" SortExpression="产品长（厘米）" />
                        <asp:BoundField DataField="产品宽（厘米）" HeaderText="产品宽（厘米）" SortExpression="产品宽（厘米）" />
                        <asp:BoundField DataField="产品高（厘米）" HeaderText="产品高（厘米）" SortExpression="产品高（厘米）" />
                        <asp:BoundField DataField="产品重量（公斤）" HeaderText="产品重量（公斤）" SortExpression="产品重量（公斤）" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select Trial.no as '产品编号',Trial.num as '产品子编号',Trial.name as '产品名称',Trial.color as '颜色/型号',Trial.cost as '采购成本（试算）',Product.length as '产品长（厘米）',Product.width as '产品宽（厘米）',Product.high as '产品高（厘米）',Product.weight as '产品重量（公斤）' from Trial left join Product on Trial.no = Product.no and Trial.name = Product.name"></asp:SqlDataSource>

            </div>
        </div>

</body>
</html>

