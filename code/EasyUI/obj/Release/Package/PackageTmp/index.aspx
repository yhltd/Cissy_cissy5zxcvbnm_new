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
                     "menuid": "1", "icon": "icon-sys", "menuname": "�ɹ�����Ʋ�Ԥ¼",
                     "menus": [{ "menuid": "11", "menuname": "�ɹ�Ԥ¼��", "icon": "icon-log", "url": "00caigoubiao1.aspx", "dbid": "1" },
                             { "menuid": "12", "menuname": "�ɹ��������㣩", "icon": "icon-form_edit", "url": "00caigoubiao2.aspx", "dbid": "2" },
                             { "menuid": "13", "menuname": "��Ʋ�Ԥ¼", "icon": "icon-log", "url": "01shejibiao.aspx", "dbid": "15" },
                     ]
                 }, {
                     "menuid": "2", "icon": "icon-sys", "menuname": "������Ԥ¼",
                     "menus": [{ "menuid": "21", "menuname": "������Ԥ¼��", "icon": "icon-log", "url": "00wuliubiao1.aspx", "dbid": "20" },
                     ]
                 }, {
                     "menuid": "3", "icon": "icon-sys", "menuname": "���۲�Ԥ¼",
                     "menus": [{ "menuid": "31", "menuname": "���۲�Ԥ¼��", "icon": "icon-log", "url": "00xiaoshoubiao1.aspx", "dbid": "21" },
                              { "menuid": "33", "menuname": "���۲�(����)", "icon": "icon-form_edit", "url": "00xiaoshoubiao2.aspx", "dbid": "22" },

                     ]
                 }, {
                     "menuid": "4", "icon": "icon-sys", "menuname": "����Ԥ¼",
                     "menus": [{ "menuid": "41", "menuname": "����Ԥ¼��", "icon": "icon-log", "url": "00caiwubiao1.aspx ", "dbid": "3" },
                             { "menuid": "42", "menuname": "���񲿣����㣩", "icon": "icon-form_edit", "url": "00caiwubiao2.aspx", "dbid": "4" },
                             { "menuid": "43", "menuname": "ÿ�����ۼ�¼", "icon": "icon-log", "url": "00caiwubiao3.aspx", "dbid": "5" },
                             { "menuid": "44", "menuname": "¼���Ǽ�", "icon": "icon-log", "url": "00caiwubiao4.aspx", "dbid": "6" },
                             { "menuid": "45", "menuname": "����ʱ�䣨������", "icon": "icon-log", "url": "00caiwubiao5.aspx", "dbid": "7" },
                     ]
                 }, {
                     "menuid": "5", "icon": "icon-go", "menuname": "��Ӫ������",
                     "menus": [//{ "menuid": "51", "menuname": "��Ӫ����", "icon": "icon-log", "url": "01yunyingbuchuju1.aspx" },
                                 { "menuid": "51", "menuname": "���������", "icon": "icon-log", "url": "01xiaoshouqingkuang.aspx", "dbid": "23" },
                                 { "menuid": "52", "menuname": "������������У�", "icon": "icon-log", "url": "01xiaoshouqiangkuang1.aspx", "dbid": "24" },
                                 { "menuid": "53", "menuname": "����������ݣ�", "icon": "icon-log", "url": "01xiaoshouqingkuang2.aspx", "dbid": "25" },
                                 { "menuid": "54", "menuname": "��ƽ̨�������", "icon": "icon-log", "url": "01xiaoshouqingkuang3.aspx", "dbid": "26" },
                     ]
                 }, {
                     "menuid": "6", "icon": "icon-go", "menuname": "���񲿳���",
                     "menus": [{ "menuid": "61", "menuname": "���˱�", "icon": "icon-log", "url": "01kaohebiao.aspx", "dbid": "9" },
                                { "menuid": "62", "menuname": "���˻��ܱ�", "icon": "icon-log", "url": "01kaohebiao1.aspx", "dbid": "10" },
                                 { "menuid": "63", "menuname": "���������", "icon": "icon-form_edit", "url": "01lirunshisuan.aspx", "dbid": "11" },
                                 { "menuid": "64", "menuname": "ʵ�������", "icon": "icon-log", "url": "01shijilirun.aspx", "dbid": "16" },
                                 { "menuid": "65", "menuname": "ʵ��������ܱ�", "icon": "icon-log", "url": "01shijilirun1.aspx", "dbid": "17" },
                                 { "menuid": "66", "menuname": "ƽ̨������ܱ�", "icon": "icon-log", "url": "01shijilirun2.aspx", "dbid": "18" },
                     ]
                 }, {
                     "menuid": "7", "icon": "icon-set", "menuname": "����������",
                     "menus": [{ "menuid": "71", "menuname": "���˶Ա�", "icon": "icon-kucun", "url": "01ruku.aspx", "dbid": "14" },
                               //{ "menuid": "72", "menuname": "��ƷĿ¼", "icon": "icon-log", "url": "01chanpinmulu.aspx" },
                               { "menuid": "73", "menuname": "�Ǽ���������", "icon": "icon-log", "url": "01peizhi01.aspx", "dbid": "12" },
                               { "menuid": "74", "menuname": "�����������", "icon": "icon-log", "url": "01peizhi02.aspx", "dbid": "13" },
                               { "menuid": "75", "menuname": "ƽ̨���ڵ�����", "icon": "icon-log", "url": "01country.aspx", "dbid": "8" },
                               { "menuid": "76", "menuname": "�û�����", "icon": "icon-admin", "url": "01user.aspx", "dbid": "19" },
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

        //���õ�¼����
        function openPwd() {
            $('#w').window({
                title: '�޸�����',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable: false
            });
        }
        //�رյ�¼����
        function closePwd() {
            $('#w').window('close');
        }


        //��ʼ�����
        function InitLeftMenu1() {
            $(".easyui-accordion1").empty();
            var menulist = "";

            $.ajax({
                url: 'dataController/selCon.ashx?operation=tableAccess',
                type: 'GET',
                error: function () {
                    $.messager.alert('����', 'error');
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

                        //�����˵��󶨳�ʼ��
                        $(".easyui-accordion1").accordion();
                    } else {
                        alert("ajax�գ���")
                    }
                }
            })
        }


        //�޸�����
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('ϵͳ��ʾ', '���������룡', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('ϵͳ��ʾ', '����һ���������룡', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('ϵͳ��ʾ', '�������벻һ��������������', 'warning');
                return false;
            }

            $.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function (msg) {
                msgShow('ϵͳ��ʾ', '��ϲ�������޸ĳɹ���<br>����������Ϊ��' + msg, 'info');
                $newpass.val('');
                $rePass.val('');
                close();
            })
        }
        $(function () {
            var formLogin = $('#formLogin');
            if (getCookie('username') == null)//δ��¼��ʾ��¼Dialog������Ⱦ            

                formLogin.dialog({
                    modal: true,
                    closable: false,
                    buttons: [{
                        text: '��¼', handler: function () {
                            if (!formLogin.form("validate")) {
                                return;
                            }
                            $.post(
                            '/Ajax/HandlerLogin.ashx',
                              { "username": $("#ipt_username").val(), "userpwd": $("#ipt_userpwd").val() },

                            function (a) {
                                if (a == '0') {//��¼�ɹ�

                                    $.messager.alert('��ʾ', '��¼�ɹ�', 'info')
                                    SetCookie('username', 'wikstone');
                                    formLogin.dialog('close');
                                }
                                else {//��¼ʧ��
                                    $.messager.alert('��ʾ', '��¼ʧ��', 'info')
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
                $.messager.confirm('ϵͳ��ʾ', '��ȷ��Ҫ�˳����ε�¼��?', function (r) {

                    if (r) {
                        location.href = 'Login.aspx';
                    }
                });
            })
        });
    </script>
    <title>�ƺ�δ��ϵͳ</title>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <noscript>
        <div style="position: absolute; z-index: 100000; height: 2046px; top: 0px; left: 0px; width: 100%; background: white; text-align: center;">
            <img src="images/noscript.gif" alt='��Ǹ���뿪���ű�֧�֣�' />
        </div>
    </noscript>
    <div region="north" split="true" border="false" style="overflow: hidden; height: 36px; background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height: 20px; color: #fff; font-family: Verdana, ΢���ź�,����">
        <span style="float: right; padding-right: 20px;" class="head">��ӭ��������ݣ�<text style="color: #33ccff"><%=backname()%>&nbsp&nbsp</text><%--<a href="#" id="editpass">�޸�����</a>--%><span>&nbsp&nbsp</span><a href="#" id="loginOut">��ȫ�˳�</a></span>
        <span style="padding-left: 10px; font-size: 16px;">
            <img src="images/tm_logo.png" width="40" height="30" align="absmiddle" />
            <text style="font-size: 20px; font-family: '����'">�ƺ�δ��ϵͳ</text>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2;">
        <div class="footer">�����������Ҫά������ϵ��<a href="http://www.yhocn.cn">www.yhocn.cn</a></div>
    </div>
    <div region="west" split="true" title="�����˵�" style="width: 180px;" id="west">
        <div class="easyui-accordion1" fit="true" border="false">
            <!--  �������� -->



        </div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y: hidden">
        <div id="tabs" class="easyui-tabs" fit="true" border="false">
            <div title="��ӭʹ��" style="padding: 20px; overflow: hidden;" id="home">
                <h1 style="font-size: 25px; font-family: '����'">��ӭʹ�ñ�ϵͳ</h1>
                <%--<h4 style="font-size: 15px; width: 600px;">��ҳ���ã�������������ϵͳ,��߰칫Ч�ʡ�</h4>--%>
                <%--<text style="font-size: 13px; width: 600px;">
                    <h4>��ϵͳ��Ϊ�������֣�ʵ����Ӫ���ֺ��������㲿��</h4>

                    <h3>һ��ʵ����Ӫ����</h3>
                    <h2>����������</h2>
                    1��¼�벿��
                    ��1���ɲɹ�Ա¼�����<text style="color:red">�ɹ�Ԥ¼��</text>��λ�ã��ɹ�����Ʋ�Ԥ¼��
                    ��2����������������¼�����<text style="color:red">����Ԥ¼��</text>��λ�ã�������Ԥ¼��
                    ��3�������������۲�¼�����<text style="color:red">����Ԥ¼��</text>��λ�ã����۲�Ԥ¼��
                    ��4���������ɲ���¼�����<text style="color:red">����Ԥ¼��</text>��λ�ã�����Ԥ¼��
                    ��5���������ɲ���¼��<text style="color:red">������Ʒ���Ǽ�</text>��<text style="color:red">����ʱ��</text>��λ�ã�����Ԥ¼��

                    ��6������������ʵ��������¼�����ÿ�����ۼ�¼��λ�ã�����Ԥ¼��

                    ע�����
                    ���У�1���ɹ�Ԥ¼��Ϊ�������2-5������¼�룻��6�������ڣ�1-5��֮��¼�룬ͳ�����ݲ���Ч

                    2�����߱���
                    ��1����Ӫ������3�ű�����������������������������������������������������������������������Զ�����С����--> ���������    ����1
                    ��2�����񲿳���5�ű�����Ա�����˳��߿��˱����˻��ܱ�                                                        -->Ա�����˱�	  ����2	
			                    ����ʵ������������ʵ�������ʵ��������ܱ�ƽ̨������ܱ�				-->ʵ�������	   ����3



                    �����������㲿��
                    ����������
                    1��¼�벿��
                    ��1���ɲɹ�Ա¼�����ɹ��������㣩     ��λ�ã��ɹ�����Ʋ�Ԥ¼��
                    ��2�������۲�¼��������۲������㣩     ��λ�ã����۲�Ԥ¼��
                    ��3���ɲ���¼�������񲿣����㣩     ��λ�ã�����Ԥ¼��
                    ��4����������¼���������Ԥ¼��         ��λ�ã�������Ԥ¼�� 


                    2�����߱���
                    ��1�����񲿳���������������ֶ���д������ۼۣ��Զ���������
                </text>--%>
            </div>
        </div>
    </div>


    <!--�޸����봰��-->
    <div id="w" class="easyui-window" title="�޸�����" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save" style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding="3">
                    <tr>
                        <td>�����룺</td>
                        <td>
                            <input id="txtNewPass" type="Password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>ȷ�����룺</td>
                        <td>
                            <input id="txtRePass" type="Password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">ȷ��</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">ȡ��</a>
            </div>
        </div>
    </div>

    <div id="mm" class="easyui-menu" style="width: 150px;">
        <div id="mm-tabclose">�ر�</div>
        <div id="mm-tabcloseall">ȫ���ر�</div>
        <div id="mm-tabcloseother">����֮��ȫ���ر�</div>
        <div class="menu-sep"></div>
        <div id="mm-tabcloseright">��ǰҳ�Ҳ�ȫ���ر�</div>
        <div id="mm-tabcloseleft">��ǰҳ���ȫ���ر�</div>
        <div class="menu-sep"></div>
        <div id="mm-exit">�˳�</div>
    </div>


</body>
</html>
