<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EasyUI.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script src="js/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <link href="Css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="js/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="js/themes/icon.css" />
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.js"></script>
    <script type="text/javascript" src="js/menu.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">

        var _menus = {
            "menus": [
                 {
                     "menuid": "1", "icon": "icon-sys", "menuname": "采购和设计部预录",
                     "menus": [{ "menuid": "11", "menuname": "采购预录表", "icon": "icon-log", "url": "00caigoubiao1.aspx" },
                             { "menuid": "12", "menuname": "采购预录（试算）", "icon": "icon-log", "url": "00caigoubiao2.aspx" },
                             { "menuid": "13", "menuname": "设计部预录", "icon": "icon-log", "url": "01shejibiao.aspx" },                       
                     ]
                 }, {
                     "menuid": "2", "icon": "icon-sys", "menuname": "物流部预录",
                     "menus": [{ "menuid": "21", "menuname": "物流部预录表", "icon": "icon-log", "url": "00wuliubiao1.aspx" },
                     ]
                 }, {
                     "menuid": "3", "icon": "icon-sys", "menuname": "销售部预录",
                     "menus": [{ "menuid": "31", "menuname": "销售部预录表", "icon": "icon-log", "url": "00xiaoshoubiao1.aspx" },
                     ]
                 }, {
                     "menuid": "4", "icon": "icon-sys", "menuname": "财务部预录",
                     "menus": [{ "menuid": "41", "menuname": "财务预录表", "icon": "icon-log", "url": "00caiwubiao1.aspx " },
                             { "menuid": "42", "menuname": "财务预录（试算）", "icon": "icon-log", "url": "00caiwubiao2.aspx" },
                             { "menuid": "43", "menuname": "每月销售记录", "icon": "icon-log", "url": "00caiwubiao3.aspx" },
                             { "menuid": "44", "menuname": "录入星级", "icon": "icon-log", "url": "00caiwubiao4.aspx" },
                             { "menuid": "45", "menuname": "冗余时间（天数）", "icon": "icon-log", "url": "00caiwubiao5.aspx" },
                     ]
                 }, {
                     "menuid": "5", "icon": "icon-sys", "menuname": "运营部出具",
                     "menus": [//{ "menuid": "51", "menuname": "运营部表", "icon": "icon-log", "url": "01yunyingbuchuju1.aspx" },
                                 { "menuid": "51", "menuname": "销售总情况", "icon": "icon-log", "url": "01xiaoshouqingkuang.aspx" },
                                 { "menuid": "52", "menuname": "销售情况（城市）", "icon": "icon-log", "url": "01xiaoshouqiangkuang1.aspx" },
                                 { "menuid": "53", "menuname": "销售情况（州）", "icon": "icon-log", "url": "01xiaoshouqingkuang2.aspx" },
                     ]
                 }, {
                     "menuid": "6", "icon": "icon-sys", "menuname": "财务部出具",
                     "menus": [{ "menuid": "61", "menuname": "考核表", "icon": "icon-log", "url": "01kaohebiao.aspx" },
                                { "menuid": "62", "menuname": "考核汇总表", "icon": "icon-log", "url": "01kaohebiao1.aspx" },
                                 { "menuid": "63", "menuname": "利润试算表", "icon": "icon-log", "url": "01lirunshisuan.aspx" },
                                 { "menuid": "64", "menuname": "实际利润表", "icon": "icon-log", "url": "01shijilirun.aspx" },
                                 { "menuid": "65", "menuname": "实际利润表汇总", "icon": "icon-log", "url": "01shijilirun1.aspx" },
                                 { "menuid": "66", "menuname": "平台利润表汇总", "icon": "icon-log", "url": "01shijilirun2.aspx" },
                     ]
                 }, {
                     "menuid": "7", "icon": "icon-sys", "menuname": "其他",
                     "menus": [{ "menuid": "71", "menuname": "库存核对表", "icon": "icon-log", "url": "01ruku.aspx" },
                               //{ "menuid": "72", "menuname": "产品目录", "icon": "icon-log", "url": "01chanpinmulu.aspx" },
                               { "menuid": "73", "menuname": "星级比例配置", "icon": "icon-log", "url": "01peizhi01.aspx" },
                               { "menuid": "74", "menuname": "冗余比例配置", "icon": "icon-log", "url": "01peizhi02.aspx" },

                     ]
                 }
            ]
        };

        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable: false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }


        //初始化左侧
        function InitLeftMenu1() {

            $(".easyui-accordion1").empty();
            var menulist = "";

            $.each(_menus.menus, function (i, n) {
                menulist += '<div title="' + n.menuname + '"  icon="' + n.icon + '" style="overflow:auto;">';
                menulist += '<ul>';
                $.each(n.menus, function (j, o) {
                    menulist += '<li><div><a ref="' + o.menuid + '" href="#" rel="' + o.url + '" ><span class="icon ' + o.icon + '" >&nbsp;</span><span class="nav">' + o.menuname + '</span></a></div></li> ';
                })
                menulist += '</ul></div>';
            })

            $(".easyui-accordion1").append(menulist);

            $('.easyui-accordion1 li a').click(function () {
                var tabTitle = $(this).children('.nav').text();

                var url = $(this).attr("rel");
                var menuid = $(this).attr("ref");
                var icon = getIcon(menuid, icon);

                addTab(tabTitle, url, icon);
                $('.easyui-accordion1 li div').removeClass("selected");
                $(this).parent().addClass("selected");
            }).hover(function () {
                $(this).parent().addClass("hover");
            }, function () {
                $(this).parent().removeClass("hover");
            });

            //导航菜单绑定初始化
            $(".easyui-accordion1").accordion();
        }


        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }

            $.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function (msg) {
                msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + msg, 'info');
                $newpass.val('');
                $rePass.val('');
                close();
            })
        }
        $(function () {
            var formLogin = $('#formLogin');
            if (getCookie('username') == null)//未登录显示登录Dialog否则不渲染            

                formLogin.dialog({
                    modal: true,
                    closable: false,
                    buttons: [{
                        text: '登录', handler: function () {
                            if (!formLogin.form("validate")) {
                                return;
                            }
                            $.post(
                            '/Ajax/HandlerLogin.ashx',
                              { "username": $("#ipt_username").val(), "userpwd": $("#ipt_userpwd").val() },

                            function (a) {
                                if (a == '0') {//登录成功

                                    $.messager.alert('提示', '登录成功', 'info')
                                    SetCookie('username', 'wikstone');
                                    formLogin.dialog('close');
                                }
                                else {//登录失败
                                    $.messager.alert('提示', '登录失败', 'info')
                                }
                            }
                            );
                        }
                    }]
                }
                 );
            openPwd();
            InitLeftMenu1();

            $('#editpass').click(function () {
                $('#w').window('open');
            });

            $('#btnEp').click(function () {
                serverLogin();
            })

            $('#btnCancel').click(function () { closePwd(); })

            $('#loginOut').click(function () {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {

                    if (r) {
                        location.href = 'Login.aspx';
                    }
                });
            })
        });
    </script>
    <title>云合未来系统</title>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <noscript>
        <div style="position: absolute; z-index: 100000; height: 2046px; top: 0px; left: 0px; width: 100%; background: white; text-align: center;">
            <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
        </div>
    </noscript>
    <div region="north" split="true" border="false" style="overflow: hidden; height: 36px; background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height: 20px; color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float: right; padding-right: 20px;" class="head">欢迎，您的身份：<span style="color: #33ccff">管理员&nbsp&nbsp</span><a href="#" id="editpass">修改密码</a><span>&nbsp&nbsp</span><a href="#" id="loginOut">安全退出</a></span>
        <span style="padding-left: 10px; font-size: 16px;">
            <img src="images/tm_logo.png" width="40" height="30" align="absmiddle" />
            <text style="font-size: 20px; font-family: '楷体'">云合未来系统</text>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2;">
        <div class="footer">遇到问题或需要维护请联系：xxxxxxx-xxxxxxx-xxxxxx</div>
    </div>
    <div region="west" split="true" title="导航菜单" style="width: 180px;" id="west">
        <div class="easyui-accordion1" fit="true" border="false">
            <!--  导航内容 -->



        </div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y: hidden">
        <div id="tabs" class="easyui-tabs" fit="true" border="false">
            <div title="欢迎使用" style="padding: 20px; overflow: hidden;" id="home">
                <h1 style="font-size: 25px; font-family: '楷体'">系统操作说明书</h1>
                <h4 style="font-size: 15px; width: 600px;">本页作用：助您快速上手系统,提高办公效率。</h4>
                <text style="font-size: 13px; width: 600px;">
                    1.请先输入采购部预录的“<text style="color:red">采购预录表</text>”
                </text>
            </div>
        </div>
    </div>


    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save" style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding="3">
                    <tr>
                        <td>新密码：</td>
                        <td>
                            <input id="txtNewPass" type="Password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td>
                            <input id="txtRePass" type="Password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>

    <div id="mm" class="easyui-menu" style="width: 150px;">
        <div id="mm-tabclose">关闭</div>
        <div id="mm-tabcloseall">全部关闭</div>
        <div id="mm-tabcloseother">除此之外全部关闭</div>
        <div class="menu-sep"></div>
        <div id="mm-tabcloseright">当前页右侧全部关闭</div>
        <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
        <div class="menu-sep"></div>
        <div id="mm-exit">退出</div>
    </div>


</body>
</html>
