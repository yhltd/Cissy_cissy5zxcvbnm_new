<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="01user1.aspx.cs" Inherits="EasyUI._01user1" %>

<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01user1" EnableEventValidation="false" CodeBehind="01user1.aspx.cs" %>

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
    <script src="/dataPage/user1.js" type="text/javascript"></script>
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
                        <td>用户名：
                        </td>
                        <td>
                            <input name="account" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                        <td>密码：
                        </td>
                        <td>
                            <input name="pwd" class="easyui-validatebox" required="true" style="width: 150px;" />
                        </td>
                    </tr>

                    <tr>
                        <td>权限级别：
                        </td>
                        <td>
                            <input name="LV" class="easyui-validatebox" style="width: 150px;" />
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
                        <td>用户名：
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

        
    </div>

</body>
</html>

