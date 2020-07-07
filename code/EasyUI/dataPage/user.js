$(function () {

    //编辑框对象dlg_Edit
    dlg_Edit = $('#Dlg-Edit').dialog({
        closed: true,
        modal: true,
        toolbar: [{
            text: '保存',
            iconCls: 'icon-save',
            handler: saveData //点击保存图标时，运行saveData
        }, '-', {
            text: '关闭',
            iconCls: 'icon-no',
            handler: function () {
                dlg_Edit.dialog('close');
            }
        }]
    });


    //编辑框对象dlg_Edit中的表单
    dlg_Edit_form = dlg_Edit.find('form');

    //权限窗口
    $('#btn-quanxian-canel').linkbutton();
    quanxian = $('#quanxian').window({
        closed: true,
        modal: true,
        onBeforeClose: function () {
            empty();
        }
    });

    //excel窗口
    $('#btn-excel-canel').linkbutton();
    excelWin = $('#excelWin').window({
        closed: true,
        modal: true
    });
    //excel1窗口
    $('#btn-excel-canel-1').linkbutton();
    excelWin1 = $('#excelWin1').window({
        closed: true,
        modal: true
    });

    $('#btn-search,#btn-search-cancel').linkbutton();
    //查询窗口
    searchWin = $('#search-window').window({
        closed: true,
        modal: true
    });
    searchForm = searchWin.find('form');


    grid = $('#grid').datagrid({
        title: '采购预录表',
        iconCls: 'icon-save',
        methord: 'get', //请求远程数据的 method 类型
        url: 'dataController/user.ashx?action=list&ran=' + Math.random(),  //从远程站点请求数据的 URL
        sortName: 'id',  //定义可以排序的列
        sortOrder: 'desc',
        idField: 'id', //标识字段
        pageSize: 30,   //初始化页码尺寸
        frozenColumns: [[
	                { field: 'ID', checkbox: true }//checkbox: true 表示显示 checkbox
                    //,{ title: 'ID', field: 'ID', width: 80, sortable: true }
        ]], //和列的特性一样，但是这些列将被冻结在左边。
        columns: [[
					{ field: 'account', title: '用户名', width: 100, sortable: true, align: 'center' }, //fieldfield 列的字段名,title列的标题文字,sortable 是否允许此列被排序
					{ field: 'pwd', title: '密码', width: 100, sortable: true, align: 'center' },
                    { field: 'LV', title: '权限级别', width: 100, sortable: true, align: 'center' },

        ]], //datagrid 的 column 的配置对象
        fit: true,
        pagination: true, //True 就会在 datagrid 的底部显示分页栏
        rownumbers: true, //True 就会显示行号的列
        fitColumns: true,//True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动。
        singleSelect: false, //True 就会只允许选中一行。
        toolbar: [{
            text: '新增',
            iconCls: 'icon-add',
            handler: add    //为按钮添加方法
        }, '-', {
            text: '修改',
            iconCls: 'icon-edit',
            handler: edit
        }, '-', {
            text: '删除',
            iconCls: 'icon-remove',
            handler: del
        }
        , '-', {
            text: '查找',
            iconCls: 'icon-search',
            handler: OpensearchWin
        }, '-', {
            text: '所有',
            iconCls: 'icon-search',
            handler: showAll
            //}, '-', {
            //    text: '导入excel',
            //    iconCls: 'icon-save',
            //    handler: OpenExcelWin
            //}, '-', {
            //    text: '导出excel',
            //    iconCls: 'icon-print',
            //    handler: OpenExcelWin1
        }
         , '-', {
             text: '修改权限',
             iconCls: 'icon-edit',
             handler: lvv
         }
        ],
        onHeaderContextMenu: function (e, field) {//当 datagrid 的头部被右键单击时触发
            e.preventDefault();
            if (!$('#tmenu').length) {
                createColumnMenu();
            }
            $('#tmenu').menu('show', {
                left: e.pageX,
                top: e.pageY
            });
        }
    });
    $('body').layout();

    InitLeftMenu1();

});


var choices = {
    sqlArr: [],
    dbName: ['add', 'upd', 'del', 'sel', 'selAll', 'exportExcel', 'importExcel', 'empty', 'look', 'importImage'],
    viewName: ['新增', '修改', '删除', '查询', '查询全部', '导入excel', '导出excel', '清空该表', '查看该表', '导入图片']
}


function init() {
    $(".check_boxs").html("");
    var insert = "";
    var arr = [];

    var sqlarr = []

    for (var y = 0; y < choices.sqlArr.length; y++) {
        if (viewName == choices.sqlArr[y].viewName) {
            sqlarr = choices.sqlArr[y]
        }
    }

    for (var j = 0; j < _menus.menus.length; j++) {
        for (var x = 0; x < _menus.menus[j].menus.length; x++) {
            if (_menus.menus[j].menus[x].url == viewName) {
                arr = _menus.menus[j].menus[x].operation;
            }
        }
    }
    for (var i = 0; i < arr.length; i++) {
        if (sqlarr.arr[arr[i]] > 0) {
            insert += "<div class='check_box' style='background-color:#E0ECFF'><a ref='" + arr[i] + "," + choices.dbName[arr[i]] + "' >" + choices.viewName[arr[i]] + "</a></div>";
        } else {
            insert += "<div class='check_box' style='background-color:white;'><a ref='" + arr[i] + "," + choices.dbName[arr[i]] + "' >" + choices.viewName[arr[i]] + "</a></div>";
        }
    }

    $(".check_boxs").append(insert)

    $(".check_box a").click(function () {
        var result = $(this).attr("ref")
        var check_id = result.split(",")[0]
        var dbName = result.split(",")[1]

        for (var i = 0; i < choices.sqlArr.length; i++) {
            if (choices.sqlArr[i].viewName == viewName) {
                choices.sqlArr[i].isUpd = true
                if (choices.sqlArr[i].arr[check_id] > '0') {
                    $(this).parent().css("background-color", "white")
                    choices.sqlArr[i].arr[check_id] = '0'
                } else {
                    $(this).parent().css("background-color", "#E0ECFF")
                    choices.sqlArr[i].arr[check_id] = '1'
                }
                if (compareArr(choices.sqlArr[i].oldSqlarr,choices.sqlArr[i].arr)) {
                    choices.sqlArr[i].isUpd = false;
                }
            }
        }
    })
}

function compareArr(arr1,arr2) {
    var num = 0;
    for (var i = 0; i < arr1.length;i++){
        if (arr1[i]==arr2[i]) {
            num++
        }
    }
    if (num == arr1.length) {
        return true
    } else {
        return false
    }
}

function InitLeftMenu1() {
    $(".list").empty();
    var menulist = "";

    $.each(_menus.menus, function (i, n) {
        menulist += '<div class="item"><div class="item_header" id="' + n.menuid + '">' + n.menuname + '</div>';
        menulist += '<ul class="item_ul" style="display:none">';
        $.each(n.menus, function (j, o) {
            menulist += '<li id="item_li" class="item_li_mouse_out"><a ref="' + o.menuid + '" rel="' + o.url + '" ><span class="icon ' + o.icon + '" >&nbsp;</span><span class="nav">' + o.menuname + '</span></a></li> ';
        })
        menulist += '</ul></div>';
    })


    $(".list").append(menulist);

    $('.list li a').click(function () {
        $('.list li').not($(this).parent()).attr("class", "item_li_mouse_out");
        $(this).parent().attr("class", "item_li_choice");
        viewName = $(this).attr("rel");

        var ishave = false;

        for (var i = 0; i < choices.sqlArr.length;i++){
            if (viewName==choices.sqlArr[i].viewName) {
                ishave = true;
            }
        }

        if (ishave) {
            init();
            ishave = false;
        } else {
            $.ajax({
                url: 'dataController/accManager.ashx?operation=viewAccess&tableName=' + viewName + '&access_id=' + access_id,
                type: 'GET',
                error: function () {
                    $.messager.alert('错误', 'error');
                },
                success: function (data) {
                    var sqlarr = { viewName: viewName, caozuo: "", arr: [] ,isUpd : false,oldSqlarr : []}
                    if (data == "") {
                        alert("该用户对该表未设置规则！将默认对该表无权限！")
                        sqlarr.caozuo = "add";
                        for (var i = 0; i < 10; i++) {
                            sqlarr.arr[i] = '0';
                        }
                        
                    } else {
                        sqlarr.caozuo = "upd";
                        var arr = data.split(",");
                        for (var i = 0; i < 10; i++) {
                            sqlarr.arr[i] = arr[i]
                        }
                    }
                    for (var i = 0; i < sqlarr.arr.length;i++){
                        sqlarr.oldSqlarr.push(sqlarr.arr[i])
                    }
                    choices.sqlArr.push(sqlarr)
                    init();
                    ishave = false;
                }
            })
        }
    })

    $('.list li a').mouseover(function () {
        var className = $(this).parent().attr("class");
        if (className == "item_li_choice") {
            $(this).css("text-decoration", "underline")
            return;
        } else {
            $(this).css("text-decoration", "underline")
            $(this).parent().attr("class", "item_li_mouse_on");
        }
    })

    $('.list li a').mouseout(function () {
        $(this).css("text-decoration", "none ")
        var className = $(this).parent().attr("class");
        if (className == "item_li_choice") {
            return;
        } else {
            $(this).parent().attr("class", "item_li_mouse_out");
        }

    })

    $(".item_header").hover(function () {
        $(this).css("cursor", "pointer")
    })

    $(".item_header").mouseout(function () {
        $(this).css("cursor", "default ")
    })

    $(".item_header").click(function () {
        var index = parseInt($(this).attr("id"));
        var hid = _menus.menus[index - 1].hid;

        if (hid > 0) {
            $(this).next(".item_ul").css("display", "none");
            $(this).css("font-weight", "normal")
            _menus.menus[index - 1].hid = "0"
        } else {
            $(".item_ul").css("display", "none");
            $(this).next().css({ "display": "block" });
            $(this).css("font-weight", "bold")
            $(".item_header").not(this).css("font-weight", "normal")
            for (var i = 0; i < _menus.menus.length; i++) {
                if (i == index - 1) {
                    _menus.menus[i].hid = "1"
                    continue;
                }
                _menus.menus[i].hid = "0"
            }
        }

    })
}

function accessSave() {
    var sqlarr = JSON.stringify(choices.sqlArr);

    $.ajax({
        url: 'dataController/accManager.ashx',
        data: {
            'sqlarr': sqlarr,
            'operation': 'updAccess',
            'access_id': access_id
        },
        type: 'GET',
        error: function () {
            $.messager.alert('错误', 'error');
        },
        success: function (data) {
            if (data=="True") {
                alert("保存成功！")
                choices.sqlarr = [];
                window.parent.location.reload(true);
            } else if (data == "isNotUpd") {
                alert("未修改！")
            }
        }
    })
}
function closeAccWindow() {
    CloseQuanxian();
}

function createColumnMenu() {
    var tmenu = $('<div id="tmenu" style="width:100px;"></div>').appendTo('body');
    var fields = grid.datagrid('getColumnFields');
    for (var i = 0; i < fields.length; i++) {
        $('<div iconCls="icon-ok"/>').html(fields[i]).appendTo(tmenu);
    }
    tmenu.menu({
        onClick: function (item) {
            if (item.iconCls == 'icon-ok') {
                grid.datagrid('hideColumn', item.text);
                tmenu.menu('setIcon', {
                    target: item.target,
                    iconCls: 'icon-empty'
                });
            } else {
                grid.datagrid('showColumn', item.text);
                tmenu.menu('setIcon', {
                    target: item.target,
                    iconCls: 'icon-ok'
                });
            }
        }
    });
}

function empty() {
    $(".check_boxs").html("");
    $(".item_ul").css("display", "none");
    $(".item_header").css("font-weight", "normal")
    for (var i = 0; i < _menus.menus.length; i++) {
        _menus.menus[i].hid = "0"
    }
    $('.list li').attr("class", "item_li_mouse_out");

    viewName = "";
    access_id = "";
    choices.sqlArr = [];
    quanxian.window('close', true);
}

var viewName = "";
var access_id = "";
var grid;
var dlg_Edit;
var dlg_Edit_form;
var searchWin;
var searchForm;
var excelWin;
var excelWin1;
var quanxian;


//quanxian
function OpenQuanxian() {
    quanxian.window('open');
}

function CloseQuanxian() {
    empty();
}


//excel
function OpenExcelWin() {
    excelWin.window('open');
}

function CloseExcelWindow() {
    excelWin.window('close');
}

//excel1
function OpenExcelWin1() {
    excelWin1.window('open');
}

function CloseExcelWindow() {
    excelWin1.window('close');
}



function getSelectedArr() {
    var ids = [];
    var rows = grid.datagrid('getSelections');
    for (var i = 0; i < rows.length; i++) {
        ids.push(rows[i].id);
    }
    return ids;
}
function getSelectedID() {
    var ids = getSelectedArr();
    return ids.join(',');
}
function arr2str(arr) {
    return arr.join(',');
}




//权限编辑传id
function lvv() {
    var rows = grid.datagrid('getSelections');
    var num = rows.length;
    if (num == 0) {
        Msgslide('未选中，请选择一个账号修改权限!'); //$.messager.alert('提示', '请选择一条记录进行操作!', 'info');
        return;
    }
    else if (num > 1) {
        Msgfade('您选中了多账号,一次只能选择一个账号修改权限!'); //$.messager.alert('提示', '您选择了多条记录,只能选择一条记录进行修改!', 'info');
        return;
    }
    else {
        access_id = rows[0].id;
        OpenQuanxian();
    }
}


//添加
function add() {
    dlg_Edit.dialog('open');
    dlg_Edit_form.form('clear');
    dlg_Edit_form.url = 'dataController/user.ashx?action=save';
}
//编辑
function edit() {
    var rows = grid.datagrid('getSelections');
    var num = rows.length;
    if (num == 0) {
        Msgslide('请选择一条记录进行操作!'); //$.messager.alert('提示', '请选择一条记录进行操作!', 'info');
        return;
    }
    else if (num > 1) {
        Msgfade('您选择了多条记录,只能选择一条记录进行修改!'); //$.messager.alert('提示', '您选择了多条记录,只能选择一条记录进行修改!', 'info');
        return;
    }
    else {
        dlg_Edit.dialog('open');
        dlg_Edit_form.form('load', 'dataController/user.ashx?action=get&id=' + rows[0].id);
        dlg_Edit_form.url = 'dataController/user.ashx?action=save&id=' + rows[0].id;
    }
}

//删除
function del() {
    var arr = getSelectedArr();
    if (arr.length > 0) {
        $.messager.confirm('提示信息', '您确认要删除吗?', function (data) {
            if (data) {
                $.ajax({
                    url: 'dataController/user.ashx?action=del&id=' + arr2str(arr),
                    type: 'GET',
                    timeout: 1000,
                    error: function () {
                        $.messager.alert('错误', '删除失败!', 'error');
                    },
                    success: function (data) {
                        eval('data=' + data);
                        if (data.success) {
                            grid.datagrid('reload');
                            grid.datagrid('clearSelections');
                        } else {
                            $.messager.alert('错误', data.msg, 'error');
                        }
                    }
                });
            }
        });
    } else {
        Msgshow('请先选择要删除的记录。');
    }
}

function Msgshow(msg) {
    $.messager.show({
        title: '提示',
        msg: msg,
        showType: 'show'
    });
}
function Msgslide(msg) {
    $.messager.show({
        title: '提示',
        msg: msg,
        timeout: 3000,
        showType: 'slide'
    });
}
function Msgfade(msg) {
    $.messager.show({
        title: '提示',
        msg: msg,
        timeout: 3000,
        showType: 'fade'
    });
}

//搜索全部
function showAll() {
    grid.datagrid({ url: 'dataController/user.ashx?action=list' });
}

//搜索
function OpensearchWin() {
    searchWin.window('open');
    searchForm.form('clear');
}

//保存数据
function saveData() {
    dlg_Edit_form.form('submit', {
        url: dlg_Edit_form.url,
        onSubmit: function () {
            return $(this).form('validate');
        },
        success: function (data) {
            //alert(data);
            eval('data=' + data);
            if (data.success) {
                grid.datagrid('reload');
                dlg_Edit.dialog('close');
            } else {
                $.messager.alert('错误', data.msg, 'error');
            }
        }
    });
}

function SearchOK() {
    var s_title = $("#s_title").val();
    searchWin.window('close');
    grid.datagrid({ url: 'dataController/user.ashx?action=query', queryParams: { title: s_title } });
}
function closeSearchWindow() {
    searchWin.window('close');
}
