<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._00caigoubiao11" EnableEventValidation="false" CodeBehind="00caigoubiao1.aspx.cs" %>

<%--CodeFile="00caigoubiao1.aspx.cs"--%>
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
    <script src="/dataPage/caigoubiao1.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            width: 195px;
            height: 39px;
            margin-left: 0px;
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div region="center" style="width: 500px; height: 300px; padding: 1px; overflow-y: hidden">
        <div id="grid">
        </div>
        <%--<button onclick=""><img src="file/1.jpg"></img></button>--%>
    </div>

    <div id="Dlg-Edit" title="编辑窗口" style="width: 703px; height: 325px;">
        <div style="padding: 20px 20px 40px 40px;">
            <form method="post">
                <table>
                    <tr>
                        <td>产品编号：
                        </td>
                        <td>
                            <input name="no" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                        <td>产品名称：
                        </td>
                        <td>
                            <input name="name" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                    </tr>

                    <tr>
                        <td>产品分组：
                        </td>
                        <td>
                            <input name="grouping" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>采购成本：
                        </td>
                        <td>
                            <input name="cost" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>采购负责人：
                        </td>
                        <td>
                            <input name="buyer" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>在售账户：
                        </td>
                        <td>
                            <input name="sale" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>产品长（厘米）：
                        </td>
                        <td>
                            <input name="length" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>产品宽（厘米）：
                        </td>
                        <td>
                            <input name="width" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>产品高（厘米）：
                        </td>
                        <td>
                            <input name="high" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                        <td>产品重量（公斤）：
                        </td>
                        <td>
                            <input name="weight" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                    <tr>
                        <td>包装清单：
                        </td>
                        <td>
                            <input name="pack" class="easyui-validatebox" style="width: 150px;" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
   <div id="search-window" title="查询窗口" style="width: 452px; height: 168px;">
        <div style="padding: 20px 20px 40px 80px;">
            <form method="post">
                <table>
                    <tr>
                        <td>产品编号：
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
                    </tr>
                        <asp:Button ID="Button1"  runat="server" Text="上传" OnClientClick="return check()" OnClick="Export_Click" />
                    </table>
            </form>
        </div>
        <%--<div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">取消</a>
        </div>--%>
    </div>

    <div id="excelWin1" title="导出预览" style="width: 1099px; height: 300px; margin-left: 5px;">

        <div style="padding: 20px 20px 40px 80px; text-align: center">
            <form id="Form2" method="post" action="">
                <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </form>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="1042px" Style="margin-left: 0px; margin-top: 22px">
                <Columns>
                    <asp:BoundField DataField="产品编号" HeaderText="产品编号" SortExpression="产品编号" />
                    <asp:BoundField DataField="产品分组" HeaderText="产品分组" SortExpression="产品分组" />
                    <asp:BoundField DataField="产品名称" HeaderText="产品名称" SortExpression="产品名称" />
                    <asp:BoundField DataField="采购成本" HeaderText="采购成本" SortExpression="采购成本" />
                    <asp:BoundField DataField="采购负责人" HeaderText="采购负责人" SortExpression="采购负责人" />
                    <asp:BoundField DataField="在售账户" HeaderText="在售账户" SortExpression="在售账户" />
                    <asp:BoundField DataField="产品长（厘米）" HeaderText="产品长（厘米）" SortExpression="产品长（厘米）" />
                    <asp:BoundField DataField="产品宽（厘米）" HeaderText="产品宽（厘米）" SortExpression="产品宽（厘米）" />
                    <asp:BoundField DataField="产品高（厘米）" HeaderText="产品高（厘米）" SortExpression="产品高（厘米）" />
                    <asp:BoundField DataField="产品重量（公斤）" HeaderText="产品重量（公斤）" SortExpression="产品重量（公斤）" />
                    <asp:BoundField DataField="包装清单" HeaderText="包装清单" SortExpression="包装清单" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select no as '产品编号',grouping as '产品分组',name as '产品名称',cost as '采购成本', buyer as '采购负责人',sale as '在售账户',length as '产品长（厘米）',width as '产品宽（厘米）',high as '产品高（厘米）',weight as '产品重量（公斤）',pack as '包装清单' from Product "></asp:SqlDataSource>

        </div>
    </div>

</body>
</html>

