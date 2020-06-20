<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="excel.aspx.cs" Inherits="EasyUI.excel" %>

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
                        产品分组：
                    </td>
                    <td>
                        <input name="grouping" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        采购成本：
                    </td>
                    <td>
                        <input name="cost" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        采购负责人：
                    </td>
                    <td>
                        <input name="buyer" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        在售账户：
                    </td>
                    <td>
                        <input name="sale" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr> 
                <tr>
                    <td>
                        产品长（厘米）：
                    </td>
                    <td>
                        <input name="length" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        产品宽（厘米）：
                    </td>
                    <td>
                        <input name="width" class="easyui-validatebox"  style="width: 150px;" />
                    </td>      
                </tr>
                <tr>
                    <td>
                        产品高（厘米）：
                    </td>
                    <td>
                        <input name="high" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                    <td>
                        产品重量（厘米）：
                    </td>
                    <td>
                        <input name="weight" class="easyui-validatebox"  style="width: 150px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        包装清单：
                    </td>
                    <td>
                        <input name="pack" class="easyui-validatebox"  style="width: 150px;" />
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
                        序号：
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
        <div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">
                取消</a>
        </div>
    </div>

    <div id="excelWin1" title="从excel导入" style="width: 350px; height: 200px;">
        <div style="padding: 20px 20px 40px 80px;">
            AAAAAAAAAAAAAAA
        </div>
        <div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="CloseExcelWindow1()" id="btn-excel-canel-1" icon="icon-cancel">
                取消</a>
        </div>
    </div>

</body>
</html>

