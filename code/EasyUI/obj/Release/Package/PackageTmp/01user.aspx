<%@ Page Language="C#" AutoEventWireup="true" Inherits="EasyUI._01yonghuguanli" EnableEventValidation="false" CodeBehind="01user.aspx.cs" %>

<%--CodeFile="00caigoubiao1.aspx.cs"--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/checkbox.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="/EasyUiDataGrid/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/EasyUiDataGrid/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/EasyUiDataGrid/datagrid-export.js" type="text/javascript"></script>
    <script src="/dataPage/user.js" type="text/javascript"></script>

    <link href="/js/newJs/easyui.css" rel="stylesheet" type="text/css"/>


    <script type="text/javascript">

        $(function () {
        })

        var _menus = {
            "menus": [
                 {
                     "menuid": "1", "icon": "icon-sys", "menuname": "采购和设计部预录", "hid": "0",
                     "menus": [{ "menuid": "11", "menuname": "采购预录表", "icon": "icon-log", "url": "caigouyulu", "operation": ['0', '1', '2', '3', '4', '5', '6', '7', '8'] },
                             { "menuid": "12", "menuname": "采购部（试算）", "icon": "icon-form_edit", "url": "caigoushisuan", "operation": ['0', '1', '2', '3', '4', '5', '6', '7', '8'] },
                             { "menuid": "13", "menuname": "设计部预录", "icon": "icon-log", "url": "shejiyulu", "operation": ['0', '1', '2', '3', '4', '8', '9'] },
                     ]
                 }, {
                     "menuid": "2", "icon": "icon-sys", "menuname": "物流部预录", "hid": "0",
                     "menus": [{ "menuid": "21", "menuname": "物流部预录表", "icon": "icon-log", "url": "wuliuyulu", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                     ]
                 }, {
                     "menuid": "3", "icon": "icon-sys", "menuname": "销售部预录", "hid": "0",
                     "menus": [{ "menuid": "31", "menuname": "销售部预录表", "icon": "icon-log", "url": "xiaoshouyulu", "operation": ['0', '1', '2', '3', '4', '5', '6', '7', '8'] },
                              { "menuid": "33", "menuname": "销售部(试算)", "icon": "icon-form_edit", "url": "xiaoshoushisuan", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },

                     ]
                 }, {
                     "menuid": "4", "icon": "icon-sys", "menuname": "财务部预录", "hid": "0",
                     "menus": [{ "menuid": "41", "menuname": "财务预录表", "icon": "icon-log", "url": "caiwuyulu", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                             { "menuid": "42", "menuname": "财务部（试算）", "icon": "icon-form_edit", "url": "caiwushisuan", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                             { "menuid": "43", "menuname": "每月销售记录", "icon": "icon-log", "url": "meiyuexiaoshou", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                             { "menuid": "44", "menuname": "录入星级", "icon": "icon-log", "url": "luruxingji", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                             { "menuid": "45", "menuname": "冗余时间（天数）", "icon": "icon-log", "url": "rongyushijian", "operation": ['0', '1', '2', '3', '4', '5', '6', '8'] },
                     ]
                 }, {
                     "menuid": "5", "icon": "icon-go", "menuname": "运营部出具", "hid": "0",
                     "menus": [//{ "menuid": "51", "menuname": "运营部表", "icon": "icon-log", "url": "01yunyingbuchuju1.aspx" },
                                 { "menuid": "51", "menuname": "销售总情况", "icon": "icon-log", "url": "xiaochouqingkuang1", "operation": ['3', '4', '6', '8'] },
                                 { "menuid": "52", "menuname": "销售情况（城市）", "icon": "icon-log", "url": "xiaochouqingkuang2", "operation": ['3', '4', '6', '8'] },
                                 { "menuid": "53", "menuname": "销售情况（州）", "icon": "icon-log", "url": "xiaochouqingkuang3", "operation": ['3', '4', '6', '8'] },
                                 { "menuid": "54", "menuname": "各平台销售情况", "icon": "icon-log", "url": "xiaochouqingkuang4", "operation": ['3', '4', '6', '8'] },
                     ]
                 }, {
                     "menuid": "6", "icon": "icon-go", "menuname": "财务部出具", "hid": "0",
                     "menus": [{ "menuid": "61", "menuname": "考核表", "icon": "icon-log", "url": "kaohe", "operation": ['3', '4', '5', '8'] },
                                { "menuid": "62", "menuname": "考核汇总表", "icon": "icon-log", "url": "kaohehuizong", "operation": ['3', '4', '5', '8'] },
                                 { "menuid": "63", "menuname": "利润试算表", "icon": "icon-form_edit", "url": "lirunshixuan", "operation": ['1', '3', '4', '5', '6', '8'] },
                                 { "menuid": "64", "menuname": "实际利润表", "icon": "icon-log", "url": "shijilirun", "operation": ['3', '4', '5', '8'] },
                                 { "menuid": "65", "menuname": "实际利润汇总表", "icon": "icon-log", "url": "shijilirunhuizong", "operation": ['3', '4', '5', '8'] },
                                 { "menuid": "66", "menuname": "平台利润汇总表", "icon": "icon-log", "url": "pingtailirunhuizong", "operation": ['3', '4', '5', '8'] },
                     ]
                 }, {
                     "menuid": "7", "icon": "icon-set", "menuname": "帮助和设置", "hid": "0",
                     "menus": [{ "menuid": "71", "menuname": "库存核对表", "icon": "icon-kucun", "url": "kucunhedui", "operation": ['3', '4', '8'] },
                               { "menuid": "73", "menuname": "星级比例配置", "icon": "icon-log", "url": "xinjibilipeizhi", "operation": ['0', '1', '2', '3', '4', '8'] },
                               { "menuid": "74", "menuname": "冗余比例配置", "icon": "icon-log", "url": "rongyubilipeizhi", "operation": ['0', '1', '2', '8'] },
                               { "menuid": "75", "menuname": "平台所在地配置", "icon": "icon-log", "url": "pingtaipeizhi", "operation": ['0', '1', '2', '3', '4', '5', '8'] },
                               { "menuid": "76", "menuname": "用户管理", "icon": "icon-admin", "url": "yonghugaunli", "operation": ['0', '1', '2', '3', '4', '5', '8'] },
                     ]
                 }
            ]
        };





    </script>
    <style type="text/css">
        #Button2
        {
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
                            <input name="name" class="easyui-validatebox" style="width: 150px;" />
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
                    <asp:Button ID="Button1" runat="server" Text="上传" OnClientClick="return check()" OnClick="Export_Click" />
                </table>
            </form>
        </div>
        <%--<div style="text-align: center; padding: 5px;">
            <a href="javascript:void(0)" onclick="CloseExcelWindow()" id="btn-excel-canel" icon="icon-cancel">取消</a>
        </div>--%>
    </div>







    <div id="quanxian" title="权限编辑" style="height: 550px; width:700px">
        <div class="list" style="float:left"></div>
		<div class="check_boxs">
				
				
		</div>
        <div>
            <button class="bt_caozuo" onclick="accessSave()">保存</button>
            <button class="bt_caozuo" onclick="closeAccWindow()">取消</button>
        </div>
    </div>


    <div id="excelWin1" title="导出预览" style="width: 1099px; height: 300px; margin-left: 5px;">
    </div>

</body>
</html>

