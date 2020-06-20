﻿
//导出
function outputExcel(url, params) {
    //getExcelXML有一个JSON对象的配置，配置项看了下只有title配置，为excel文档的标题
    //var data = $('#' + gridID).datagrid('getExcelXml', { title: 'XXX' }); //获取datagrid数据对应的excel需要的xml格式的内容

    //用ajax发动到动态页动态写入xls文件中
    $.ajax({
        url: url,
        data: params,
        type: 'POST',
        dataType: 'json',
        success: function (data) {
            //防止浏览器对js拦截
            var aexportexcellink = document.createElement("a");
            aexportexcellink.setAttribute("href", data.filename);
            //a.setAttribute("target", "_blank");
            aexportexcellink.setAttribute("id", "euiexportexcel");
            document.body.appendChild(aexportexcellink);
            aexportexcellink.click();
            //用完移除节点
            aexportexcellink.parentNode.removeChild(aexportexcellink);
        },
        error: function (xhr) {
            $.messager.alert("错误提示", '导出失败');
        }
    });
}

$.extend($.fn.datagrid.methods, {
    getExcelXml: function (jq, param) {
        var worksheet = this.createWorksheet(jq, param);
        //alert($(jq).datagrid('getColumnFields'));
        var totalWidth = 0;
        var cfs = $(jq).datagrid('getColumnFields');
        for (var i = 0; i < cfs.length; i++) {
            totalWidth += $(jq).datagrid('getColumnOption', cfs[i]).width;
        }
        //var totalWidth = this.getColumnModel().getTotalWidth(includeHidden);
        return '<?xml version="1.0" encoding="utf-8"?>' +//xml申明有问题，以修正，注意是utf-8编码，如果是gb2312，需要修改动态页文件的写入编码
    '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:o="urn:schemas-microsoft-com:office:office">' +
    '<o:DocumentProperties><o:Title>' + param.title + '</o:Title></o:DocumentProperties>' +
    '<ss:ExcelWorkbook>' +
    '<ss:WindowHeight>' + worksheet.height + '</ss:WindowHeight>' +
    '<ss:WindowWidth>' + worksheet.width + '</ss:WindowWidth>' +
    '<ss:ProtectStructure>False</ss:ProtectStructure>' +
    '<ss:ProtectWindows>False</ss:ProtectWindows>' +
    '</ss:ExcelWorkbook>' +
    '<ss:Styles>' +
    '<ss:Style ss:ID="Default">' +
    '<ss:Alignment ss:Vertical="Top"  />' +
    '<ss:Font ss:FontName="arial" ss:Size="10" />' +
    '<ss:Borders>' +
    '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Top" />' +
    '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Bottom" />' +
    '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Left" />' +
    '<ss:Border ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Right" />' +
    '</ss:Borders>' +
    '<ss:Interior />' +
    '<ss:NumberFormat />' +
    '<ss:Protection />' +
    '</ss:Style>' +
    '<ss:Style ss:ID="title">' +
    '<ss:Borders />' +
    '<ss:Font />' +
    '<ss:Alignment  ss:Vertical="Center" ss:Horizontal="Center" />' +
    '<ss:NumberFormat ss:Format="@" />' +
    '</ss:Style>' +
    '<ss:Style ss:ID="headercell">' +
    '<ss:Font ss:Bold="1" ss:Size="10" />' +
    '<ss:Alignment  ss:Horizontal="Center" />' +
    '<ss:Interior ss:Pattern="Solid"  />' +
    '</ss:Style>' +
    '<ss:Style ss:ID="even">' +
    '<ss:Interior ss:Pattern="Solid"  />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="even" ss:ID="evendate">' +
    '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="even" ss:ID="evenint">' +
    '<ss:NumberFormat ss:Format="0" />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="even" ss:ID="evenfloat">' +
    '<ss:NumberFormat ss:Format="0.00" />' +
    '</ss:Style>' +
    '<ss:Style ss:ID="odd">' +
    '<ss:Interior ss:Pattern="Solid"  />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="odd" ss:ID="odddate">' +
    '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="odd" ss:ID="oddint">' +
    '<ss:NumberFormat ss:Format="0" />' +
    '</ss:Style>' +
    '<ss:Style ss:Parent="odd" ss:ID="oddfloat">' +
    '<ss:NumberFormat ss:Format="0.00" />' +
    '</ss:Style>' +
    '</ss:Styles>' +
    worksheet.xml +
    '</ss:Workbook>';
    },
    createWorksheet: function (jq, param) {
        // Calculate cell data types and extra class names which affect formatting
        var cellType = [];
        var cellTypeClass = [];
        //var cm = this.getColumnModel();
        var totalWidthInPixels = 0;
        var colXml = '';
        var headerXml = '';
        var visibleColumnCountReduction = 0;
        var cfs = $(jq).datagrid('getColumnFields');
        var colCount = cfs.length;
        for (var i = 0; i < colCount; i++) {
            if (cfs[i] != '') {
                var w = $(jq).datagrid('getColumnOption', cfs[i]).width;
                totalWidthInPixels += w;
                if (cfs[i] === "") {
                    cellType.push("None");
                    cellTypeClass.push("");
                    ++visibleColumnCountReduction;
                }
                else {
                    colXml += '<ss:Column ss:AutoFitWidth="1" ss:Width="130" />';
                    headerXml += '<ss:Cell ss:StyleID="headercell">' +
                '<ss:Data ss:Type="String">' + $(jq).datagrid('getColumnOption', cfs[i]).title + '</ss:Data>' +
                '<ss:NamedCell ss:Name="Print_Titles" /></ss:Cell>';
                    cellType.push("String");
                    cellTypeClass.push("");
                }
            }
        }
        var visibleColumnCount = cellType.length - visibleColumnCountReduction;
        var result = {
            height: 9000,
            width: Math.floor(totalWidthInPixels * 30) + 50
        };
        var rows = $(jq).datagrid('getRows');
        // Generate worksheet header details.
        var t = '<ss:Worksheet ss:Name="' + param.title + '">' +
    '<ss:Names>' +
    '<ss:NamedRange ss:Name="Print_Titles" ss:RefersTo="=\'' + param.title + '\'!R1:R2" />' +
    '</ss:Names>' +
    '<ss:Table x:FullRows="1" x:FullColumns="1"' +
    ' ss:ExpandedColumnCount="' + (visibleColumnCount + 2) +
    '" ss:ExpandedRowCount="' + (rows.length + 2) + '">' +
    colXml +
    '<ss:Row ss:AutoFitHeight="1">' +
    headerXml +
    '</ss:Row>';
        // Generate the data rows from the data in the Store
        //for (var i = 0, it = this.store.data.items, l = it.length; i < l; i++) {
        for (var i = 0, it = rows, l = it.length; i < l; i++) {
            t += '<ss:Row>';
            var cellClass = (i & 1) ? 'odd' : 'even';
            r = it[i];
            var k = 0;
            for (var j = 0; j < colCount; j++) {
                //if ((cm.getDataIndex(j) != '')
                if (cfs[j] != '') {
                    //var v = r[cm.getDataIndex(j)];
                    var v = r[cfs[j]];
                    if (cellType[k] !== "None") {
                        t += '<ss:Cell ss:StyleID="' + cellClass + cellTypeClass[k] + '"><ss:Data ss:Type="' + cellType[k] + '">';
                        if (cellType[k] == 'DateTime') {
                            t += v.format('Y-m-d');
                        } else {
                            t += v;
                        }
                        t += '</ss:Data></ss:Cell>';
                    }
                    k++;
                }
            }
            t += '</ss:Row>';
        }
        result.xml = t + '</ss:Table>' +
    '<x:WorksheetOptions>' +
    '<x:PageSetup>' +
    '<x:Layout x:CenterHorizontal="1" x:Orientation="Landscape" />' +
    '<x:Footer x:Data="Page &P of &N" x:Margin="0.5" />' +
    '<x:PageMargins x:Top="0.5" x:Right="0.5" x:Left="0.5" x:Bottom="0.8" />' +
    '</x:PageSetup>' +
    '<x:FitToPage />' +
    '<x:Print>' +
    '<x:PrintErrors>Blank</x:PrintErrors>' +
    '<x:FitWidth>1</x:FitWidth>' +
    '<x:FitHeight>32767</x:FitHeight>' +
    '<x:ValidPrinterInfo />' +
    '<x:VerticalResolution>600</x:VerticalResolution>' +
    '</x:Print>' +
    '<x:Selected />' +
    '<x:DoNotDisplayGridlines />' +
    '<x:ProtectObjects>False</x:ProtectObjects>' +
    '<x:ProtectScenarios>False</x:ProtectScenarios>' +
    '</x:WorksheetOptions>' +
    '</ss:Worksheet>';
        return result;
    }
});