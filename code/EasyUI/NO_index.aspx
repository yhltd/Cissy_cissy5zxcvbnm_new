<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NO_index.aspx.cs" Inherits="EasyUI.NO_index" %>
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
                     "menuid": "6", "icon": "icon-sys", "menuname": "库存核对",
                     "menus": [{ "menuid": "61", "menuname": "库存核对表", "icon": "icon-log", "url": "01rukuhesuan.aspx" },
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
        <span style="float: right; padding-right: 20px;" class="head">欢迎，您的身份：<span style="color: #ffffff">普通用户&nbsp&nbsp</span><a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
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

                <h1 style="font-size: 20px">欢迎阅读系统操作说明</h1>
                <h4 style="font-size: 15px; width: 600px; font-family: '楷体'">一个幽灵，共产主义的幽灵，在欧洲大陆徘徊。为了对这个幽灵进行神圣的围剿，旧欧洲的一切势力，教皇和沙皇、梅特涅和基佐、法国的激进派和德国的警察，都联合起来了。
                有哪一个反对党不被它的当政的敌人骂为共产党呢？又有哪一个反对党不拿共产主义这个罪名去回敬更进步的反对党人和自己的反动敌人呢？从这一事实中可以得出两个结论：
共产主义已经被欧洲的一切势力公认为一种势力；现在是共产党人向全世界公开说明自己的观点、自己的目的、自己的意图并且拿党自己的宣言来反驳关于共产主义幽灵的神话的时候了。
为了这个目的，各国共产党人集会于伦敦，拟定
                </h4>
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
