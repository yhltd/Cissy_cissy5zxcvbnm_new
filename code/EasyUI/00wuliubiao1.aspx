<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="00wuliubiao1.aspx.cs" Inherits="EasyUI._0wuliubiao1" %>--%>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._0wuliubiao1"  EnableEventValidation = "false"  CodeBehind="00wuliubiao1.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/dataPage/wuliubiao1.js" type="text/javascript"></script>
    <style type="text/css">
        #Button2 {
            height: 42px;
            width: 128px;
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
                        产品编号：
                    </td>
                    <td>
                        <input name="no" class="easyui-validatebox" required="true" style="width: 150px;" />
                    </td>
                    <td>
                        产品名称：
                    </td>
                    <td>
                        <input name="name" class="easyui-validatebox" required="true" style="width: 150px;" />
                    </td>
                </tr>
                
                <tr>
                    <td>
                        抵运国：
                    </td>
                    <td>
                        <input name="country" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        单件头程运费：
                    </td>
                    <td>
                        <input name="freight" class="easyui-validatebox"  style="width: 150px;" />
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
                        产品编号：
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

    <div id="excelWin1" title="导出预览" style="width: 583px; height: 300px;">
        
        <div style="padding: 20px 20px 40px 80px; text-align: center">
                <form id="Form2" method="post" action="">
                <input type="button" id="Button2" runat="server" value="下载表格" onserverclick="Export_Click1"/>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Height="122px" style="margin-left: 29px; margin-right: 38px; margin-top: 33px" Width="421px">
                        <Columns>
                            <asp:BoundField DataField="产品序号" HeaderText="产品序号" SortExpression="产品序号" />
                            <asp:BoundField DataField="产品名称" HeaderText="产品名称" SortExpression="产品名称" />
                            <asp:BoundField DataField="运抵国" HeaderText="运抵国" SortExpression="运抵国" />
                            <asp:BoundField DataField="单件头程运费" HeaderText="单件头程运费" SortExpression="单件头程运费" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CissyConnectionString %>" SelectCommand="select no as '产品序号',name as '产品名称',country as '运抵国',freight as '单件头程运费' from Product"></asp:SqlDataSource>
                </form>

        </div>
    </div>

</body>
</html>