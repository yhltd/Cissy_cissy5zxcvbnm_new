<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EasyUI.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta content="text/html; charset=utf-8" />
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

        var lookarr = {
            dbid: [],
            look: []
        };
        var _menus = {
            "menus": [
                 {
                     "menuid": "1", "icon": "icon-sys", "menuname": "采购和设计部预录",
                     "menus": [{ "menuid": "11", "menuname": "采购预录表", "icon": "icon-log", "url": "00caigoubiao1.aspx", "dbid": "1" },
                             { "menuid": "12", "menuname": "采购部（试算）", "icon": "icon-form_edit", "url": "00caigoubiao2.aspx", "dbid": "2" },
                             { "menuid": "13", "menuname": "设计部预录", "icon": "icon-log", "url": "01shejibiao.aspx", "dbid": "15" },
                     ]
                 }, {
                     "menuid": "2", "icon": "icon-sys", "menuname": "物流部预录",
                     "menus": [{ "menuid": "21", "menuname": "物流部预录表", "icon": "icon-log", "url": "00wuliubiao1.aspx", "dbid": "20" },
                     ]
                 }, {
                     "menuid": "3", "icon": "icon-sys", "menuname": "销售部预录",
                     "menus": [{ "menuid": "31", "menuname": "销售部预录表", "icon": "icon-log", "url": "00xiaoshoubiao1.aspx", "dbid": "21" },
                              { "menuid": "33", "menuname": "销售部(试算)", "icon": "icon-form_edit", "url": "00xiaoshoubiao2.aspx", "dbid": "22" },

                     ]
                 }, {
                     "menuid": "4", "icon": "icon-sys", "menuname": "财务部预录",
                     "menus": [{ "menuid": "41", "menuname": "财务预录表", "icon": "icon-log", "url": "00caiwubiao1.aspx ", "dbid": "3" },
                             { "menuid": "42", "menuname": "财务部（试算）", "icon": "icon-form_edit", "url": "00caiwubiao2.aspx", "dbid": "4" },
                             { "menuid": "43", "menuname": "每月销售记录", "icon": "icon-log", "url": "00caiwubiao3.aspx", "dbid": "5" },
                             { "menuid": "44", "menuname": "录入星级", "icon": "icon-log", "url": "00caiwubiao4.aspx", "dbid": "6" },
                             { "menuid": "45", "menuname": "冗余时间（天数）", "icon": "icon-log", "url": "00caiwubiao5.aspx", "dbid": "7" },
                     ]
                 }, {
                     "menuid": "5", "icon": "icon-go", "menuname": "运营部出具",
                     "menus": [//{ "menuid": "51", "menuname": "运营部表", "icon": "icon-log", "url": "01yunyingbuchuju1.aspx" },
                                 { "menuid": "51", "menuname": "销售总情况", "icon": "icon-log", "url": "01xiaoshouqingkuang.aspx", "dbid": "23" },
                                 { "menuid": "52", "menuname": "销售情况（城市）", "icon": "icon-log", "url": "01xiaoshouqiangkuang1.aspx", "dbid": "24" },
                                 { "menuid": "53", "menuname": "销售情况（州）", "icon": "icon-log", "url": "01xiaoshouqingkuang2.aspx", "dbid": "25" },
                                 { "menuid": "54", "menuname": "各平台销售情况", "icon": "icon-log", "url": "01xiaoshouqingkuang3.aspx", "dbid": "26" },
                     ]
                 }, {
                     "menuid": "6", "icon": "icon-go", "menuname": "财务部出具",
                     "menus": [{ "menuid": "61", "menuname": "考核表", "icon": "icon-log", "url": "01kaohebiao.aspx", "dbid": "9" },
                                { "menuid": "62", "menuname": "考核汇总表", "icon": "icon-log", "url": "01kaohebiao1.aspx", "dbid": "10" },
                                 { "menuid": "63", "menuname": "利润试算表", "icon": "icon-form_edit", "url": "01lirunshisuan.aspx", "dbid": "11" },
                                 { "menuid": "64", "menuname": "实际利润表", "icon": "icon-log", "url": "01shijilirun.aspx", "dbid": "16" },
                                 { "menuid": "65", "menuname": "实际利润汇总表", "icon": "icon-log", "url": "01shijilirun1.aspx", "dbid": "17" },
                                 { "menuid": "66", "menuname": "平台利润汇总表", "icon": "icon-log", "url": "01shijilirun2.aspx", "dbid": "18" },
                     ]
                 }, {
                     "menuid": "7", "icon": "icon-set", "menuname": "帮助和设置",
                     "menus": [{ "menuid": "71", "menuname": "库存核对表", "icon": "icon-kucun", "url": "01ruku.aspx", "dbid": "14" },
                               //{ "menuid": "72", "menuname": "产品目录", "icon": "icon-log", "url": "01chanpinmulu.aspx" },
                               { "menuid": "73", "menuname": "星级比例配置", "icon": "icon-log", "url": "01peizhi01.aspx", "dbid": "12" },
                               { "menuid": "74", "menuname": "冗余比例配置", "icon": "icon-log", "url": "01peizhi02.aspx", "dbid": "13" },
                               { "menuid": "75", "menuname": "平台所在地配置", "icon": "icon-log", "url": "01country.aspx", "dbid": "8" },
                               { "menuid": "76", "menuname": "用户管理", "icon": "icon-admin", "url": "01user.aspx", "dbid": "19" },
                     ]
                 }
            ]
        };

        function InitAccess() {
            var x = 0

            for (var j = 0; j < _menus.menus.length; j++) {
                for (var i = 0; i < _menus.menus[j].menus.length; i++) {
                    var dbid = _menus.menus[j].menus[i].dbid
                    for (var x = 0; x < lookarr.dbid.length; x++) {
                        if (dbid == lookarr.dbid[x]) {
                            if (lookarr.look[x] != '1') {
                                _menus.menus[j].menus[i] = ""
                            }
                        }
                    }
                }
                var y = 0;
                for (var i = 0; i < _menus.menus[j].menus.length; i++) {
                    if (_menus.menus[j].menus[i] != "") {
                        y++;
                    }
                }
                if (y == 0) {
                    _menus.menus[j] = "";
                }
            }
        }

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

            $.ajax({
                url: 'dataController/selCon.ashx?operation=tableAccess',
                type: 'GET',
                error: function () {
                    $.messager.alert('错误', 'error');
                },
                success: function (data) {
                    if (data != undefined || data != "") {
                        var look1 = data.split(":");
                        for (var i = 0; i < look1.length; i++) {
                            lookarr.dbid.push(look1[i].split(",")[1])
                            lookarr.look.push(look1[i].split(",")[0])
                        }
                        InitAccess();
                        $.each(_menus.menus, function (i, n) {
                            if (n != "") {
                                menulist += '<div title="' + n.menuname + '"  icon="' + n.icon + '" style="overflow:auto;">';
                                menulist += '<ul>';
                                $.each(n.menus, function (j, o) {
                                    if (o != "") {
                                        menulist += '<li disabled><div><a ref="' + o.menuid + '" href="#" rel="' + o.url + '" ><span class="icon ' + o.icon + '" >&nbsp;</span><span class="nav">' + o.menuname + '</span></a></div></li> ';
                                    }
                                })
                                menulist += '</ul></div>';
                            }
                        })
                        $(".easyui-accordion1").append(menulist);

                        $('.easyui-accordion1 li a').click(function () {
                            var tabTitle = $(this).children('.nav').text();

                            var url = $(this).attr("rel");
                            var menuid = $(this).attr("ref");
                            var icon = getIcon(menuid, icon);
                            addTab(tabTitle, url, icon);
                            $('.easyui-accordion1 li div').removeClass("selected");
                            $(this).parent().addClass("selected")

                        }).hover(function () {
                            $(this).parent().addClass("hover");
                        }, function () {
                            $(this).parent().removeClass("hover");
                        });

                        //导航菜单绑定初始化
                        $(".easyui-accordion1").accordion();
                    } else {
                        alert("ajax空！！")
                    }
                }
            })
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
        <span style="float: right; padding-right: 20px;" class="head">欢迎，您的身份：<text style="color: #33ccff"><%=backname()%>&nbsp&nbsp</text><%--<a href="#" id="editpass">修改密码</a>--%><span>&nbsp&nbsp</span><a href="#" id="loginOut">安全退出</a></span>
        <span style="padding-left: 10px; font-size: 16px;">
            <img src="images/tm_logo.png" width="40" height="30" align="absmiddle" />
            <text style="font-size: 20px; font-family: '楷体'">云合未来系统</text>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2;">
        <div class="footer">遇到问题或需要维护请联系：<a href="http://www.yhocn.cn">www.yhocn.cn</a></div>
    </div>
    <div region="west" split="true" title="导航菜单" style="width: 180px;" id="west">
        <div class="easyui-accordion1" fit="true" border="false">
            <!--  导航内容 -->



        </div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y: hidden">
        <div id="tabs" class="easyui-tabs" fit="true" border="false">
            <div title="欢迎使用" style="padding: 20px; overflow: hidden;" id="home">
                <h1 style="font-size: 25px; font-family: '楷体'">欢迎使用本系统</h1>
                <%--<h4 style="font-size: 15px; width: 600px;">本页作用：助您快速上手系统,提高办公效率。</h4>--%>
                <%--<text style="font-size: 13px; width: 600px;">
                    <h4>本系统分为两个部分，实际运营部分和利润试算部分</h4>

                    <h3>一、实际运营部分</h3>
                    <h2>完整的流程</h2>
                    1、录入部分
                    （1）由采购员录入或导入<text style="color:red">采购预录表</text>（位置：采购和设计部预录）
                    （2）接下来由物流部录入或导入<text style="color:red">物流预录表</text>（位置：物流部预录）
                    （3）接下来由销售部录入或导入<text style="color:red">销售预录表</text>（位置：销售部预录）
                    （4）接下来由财务部录入或导入<text style="color:red">财务预录表</text>（位置：财务部预录）
                    （5）接下来由财务部录入<text style="color:red">各个产品的星级</text>和<text style="color:red">冗余时间</text>（位置：财务部预录）

                    （6）接下来根据实际生产，录入或导入每月销售记录表（位置：财务部预录）

                    注意事项：
                    其中（1）采购预录表为必填，否则（2-5）不能录入；（6）必须在（1-5）之后录入，统计数据才生效

                    2、出具报表
                    （1）运营部出具3张表，关于销售情况出具销售情况、销售情况按城市排名、销售情况按州排名（点击列名可自动按大小排序）--> 销售情况表    报表1
                    （2）财务部出具5张表，关于员工考核出具考核表、考核汇总表                                                        -->员工考核表	  报表2	
			                    关于实际利润计算出具实际利润表、实际利润汇总表、平台利润汇总表				-->实际利润表	   报表3



                    二、利润试算部分
                    完整的流程
                    1、录入部分
                    （1）由采购员录入或导入采购部（试算）     （位置：采购和设计部预录）
                    （2）由销售部录入或导入销售部（试算）     （位置：销售部预录）
                    （3）由财务部录入或导入财务部（试算）     （位置：财务部预录）
                    （4）由物流部录入或导入物流预录表         （位置：物流部预录） 


                    2、出具报表
                    （1）财务部出具利润试算表，可手动填写或更改售价，自动计算利润
                </text>--%>
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
