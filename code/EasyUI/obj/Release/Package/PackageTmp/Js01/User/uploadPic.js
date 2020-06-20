﻿///上传头像
function fileboxInit() {
    $('#fileToUpload').filebox({
        buttonText: '选择文件',
        buttonAlign: 'right',
        accept: '.png,.gif,.jpg',
        onChange: function () {
            checkFiles();
        }
    });
}

//上传图片
function uploadPic() {
    //获取选中行记录
    if ($('#usergrid').datagrid('getSelected') == null) {
        $.messager.alert("提示", '请先选中一条数据');
        return;
    }

    $("#importFileForm").css("display", "block");

    $('#userUploadPic').dialog({
        title: "上传头像",
        modal: true,
        width: 400,
        shadow: true,
        height: 260,
        closed: false,
        onClose: function () {
            //清除Form表单数据
        }
    });
}

//导入文件
function importFileClick() {
    //获取form数据
    //var formData = new FormData($("#importFileForm")[0]);
    $("#importFileForm").submit();
    return;

    //下面代码有异常
    //调用apicontroller后台action方法，将form数据传递给后台处理。contentType必须设置为"multipart/form-data"
    $.ajax({
        url: "/Upload/UploadUserPic",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: "multipart/form-data",
        processData: false,
        success: function (returnInfo) {
            alert(returnInfo);
            //上传成功后将控件内容清空，并显示上传成功信息
            //document.getElementById('fileImport').value = null;
            //document.getElementById('uploadInfo').innerHTML = "<span style='color:Red'>" + returnInfo + "</span>";
        },
        error: function (returnInfo) {
            //上传失败时显示上传失败信息
            //document.getElementById('uploadInfo').innerHTML = "<span style='color:Red'>" + returnInfo + "</span>";
        }
    });
}

function checkFiles() {
    //获取上传文件控件内容
    var file = document.getElementsByName('fileToUpload')[0].files[0];

    //var file = $("#txtfilebox").filebox('getValue');
    //alert(document.getElementsByName('fileToUpload')[0].files[0]);
    //return;
    //判断控件中是否存在文件内容，如果不存在，弹出提示信息，阻止进一步操作
    if (file == null || file == "") { alert('错误，请选择文件'); return; }
    //获取文件名称
    var fileName = file.name;

    //获取文件类型名称
    var file_typename = fileName.substring(fileName.lastIndexOf('.'), fileName.length);
    //这里限定上传文件文件类型必须为.xlsx，如果文件类型不符，提示错误信息
    if (file_typename == '.png' || file_typename == '.gif') {
        //计算文件大小
        var fileSize = 0;
        //如果文件大小大于1024字节X1024字节，则显示文件大小单位为MB，否则为KB
        if (file.size > 1024 * 1024) {
            fileSize = Math.round(file.size * 100 / (1024 * 1024)) / 100;

            if (fileSize > 10) {
                alert('错误，文件超过10MB，禁止上传！'); return;
            }
            fileSize = fileSize.toString() + 'MB';
        }
        else {
            fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
        }
        //将文件名和文件大小显示在前端label文本中
        document.getElementById('fileInfo').innerHTML = "<span style='color:Blue'>文件名: " + file.name + ',大小: ' + fileSize + "</span>";
    }
    else {
        alert("文件类型错误");
        //将错误信息显示在前端label文本中
        document.getElementById('fileName').innerHTML = "<span style='color:Red'>错误提示:上传文件应该是.xlsx后缀而不应该是" + file_typename + ",请重新选择文件</span>"
    }
}