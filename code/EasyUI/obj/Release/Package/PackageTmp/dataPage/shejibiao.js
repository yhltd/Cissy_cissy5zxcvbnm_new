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
        title: '设计部预录',
        iconCls: 'icon-save',
        methord: 'get', //请求远程数据的 method 类型
        url: 'dataController/shejibiao.ashx?action=list&ran=' + Math.random(),  //从远程站点请求数据的 URL
        sortName: 'id',  //定义可以排序的列
        sortOrder: 'desc',
        idField: 'id', //标识字段
        pageSize: 30,   //初始化页码尺寸
        frozenColumns: [[
	                { field: 'ID', checkbox: true }//checkbox: true 表示显示 checkbox
                    //,{ title: 'ID', field: 'ID', width: 80, sortable: true }
        ]], //和列的特性一样，但是这些列将被冻结在左边。
        columns: [[
					{ field: 'no', title: '产品编号', width: 100, sortable: true, align: 'center' }, //fieldfield 列的字段名,title列的标题文字,sortable 是否允许此列被排序
					{ field: 'num', title: '产品子编号', width: 100, sortable: true, align: 'center' },
                    {
                        field: 'opt1', title: '上传', width: 100, sortable: true, align: 'center',
                        formatter: function (val, row, index) {
                            var btn = '<button class="detail" onclick="ShowDetail1(\'' + row.id + '\')"  href="javascript:void(0)">点击上传图片</a>';
                            return btn;
                        }
                    },
                    {
                        field: 'opt2', title: '下载', width: 100, align: 'center',
                        formatter: function (val, row, index) {
                            var btn = '<button class="detail" onclick="ShowDetail2(\'' + row.id + '\')"  href="javascript:void(0)">点击查看图片</a>';
                            return btn;
                        }
                    }
        ]], //datagrid 的 column 的配置对象
        fit: true,
        pagination: true, //True 就会在 datagrid 的底部显示分页栏
        rownumbers: true, //True 就会显示行号的列
        fitColumns: true,//True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动。
        singleSelect: false, //True 就会只允许选中一行。
        onLoadSuccess: function (data) {
            $('.detail1').linkbutton({ text: '', plain: true, iconCls: 'icon-add' });
        },
        onLoadSuccess: function (data) {
            $('.detail2').linkbutton({ text: '', plain: true, iconCls: 'icon-tip' });
        },

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
        }, '-', {
            text: '导入excel',
            iconCls: 'icon-save',
            handler: OpenExcelWin
        }, '-', {
            text: '导出excel',
            iconCls: 'icon-print',
            handler: OpenExcelWin1
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
});

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

var grid;
var dlg_Edit;
var dlg_Edit_form;
var searchWin;
var searchForm;
var excelWin;
var excelWin1;


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

//添加
function add() {
    dlg_Edit.dialog('open');
    dlg_Edit_form.form('clear');
    dlg_Edit_form.url = 'dataController/shejibiao.ashx?action=save';
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
        dlg_Edit_form.form('load', 'dataController/shejibiao.ashx?action=get&id=' + rows[0].id);
        dlg_Edit_form.url = 'dataController/shejibiao.ashx?action=save&id=' + rows[0].id;
    }
}

//删除
function del() {
    var arr = getSelectedArr();
    if (arr.length > 0) {
        $.messager.confirm('提示信息', '您确认要删除吗?', function (data) {
            if (data) {
                $.ajax({
                    url: 'dataController/shejibiao.ashx?action=del&id=' + arr2str(arr),
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
    grid.datagrid({ url: 'dataController/shejibiao.ashx?action=list' });
}

//搜索
function OpensearchWin() {
    searchWin.window('open');
    searchForm.form('clear');
}

保存数据
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
    grid.datagrid({ url: 'dataController/shejibiao.ashx?action=query', queryParams: { title: s_title } });
}
function closeSearchWindow() {
    searchWin.window('close');
}
