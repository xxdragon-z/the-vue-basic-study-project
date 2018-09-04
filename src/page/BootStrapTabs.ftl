<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/style.css"/>
    <link rel="stylesheet" href="../assets/css/ace.min.css"/>
    <link rel="stylesheet" href="../assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="../Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link href="../Widget/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <!--[if IE 7]>
    <link rel="stylesheet" href="../assets/css/font-awesome-ie7.min.css"/>
    <![endif]-->
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="../assets/css/ace-ie.min.css"/>
    <![endif]-->
    <script src="../js/jquery-1.9.1.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/typeahead-bs2.min.js"></script>
    <!-- page specific plugin scripts -->
    <script src="../assets/js/jquery.dataTables.min.js"></script>
    <script src="../assets/js/jquery.dataTables.bootstrap.js"></script>
    <script type="text/javascript" src="../js/H-ui.js"></script>
    <script type="text/javascript" src="../js/H-ui.admin.js"></script>
    <script src="../assets/layer/layer.js" type="text/javascript"></script>
    <script src="../assets/laydate/laydate.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
    <script src="../js/lrtk.js" type="text/javascript"></script>
    <title>设备列表</title>
</head>
<body>
<div class="page-content clearfix">
    <div id="products_style">
        <div class="search_style">
            <ul class="search_content clearfix">
                <li>
                    <input id="role_name" name="" type="text" class="text_add" placeholder="输入权限名称"
                           style=" width:250px"/>
                </li>
                <li style="width:90px;">
                    <button id="role_name_search" type="button" class="btn_search"><i class="icon-search"></i>查询
                    </button>
                </li>
                <li style="width:90px;float: right;">
                    <button id="menu_add" type="button" class="btn_add" data-toggle="modal"
                            data-target="#addBody"><i class="icon-adn"></i>添加
                    </button>
                </li>
            </ul>
        </div>

        <!--删除悬浮窗-->
        <div class="modal fade" id="removeBody" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">录入提供商</h4>
                    </div>
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>权限名称</td>
                                <td>
                                    <input type="hidden" id="remove_menuId"/>
                                    <input type="text" id="remove_menuName">
                                </td>
                            </tr>
                            <tr>
                                <td>权限URL</td>
                                <td>
                                    <input type="text" id="remove_url">
                                </td>
                            </tr>
                            <tr>
                                <td>下级权限</td>
                                <td>&nbsp;&nbsp;<select id="remove_select_senior">
                                    <option value="0">选择下级权限</option>
                                </select></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                        <button type="button" class="btn btn-danger" id="remove_senior_btn">删除子权限</button>
                        <button type="button" class="btn btn-danger" id="remove_btn">删除主权限</button>
                    </div>
                </div>
            </div>
        </div>


        <!--添加悬浮框 -->
        <div class="modal fade" id="addBody" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">添加主权限</h4>
                    </div>
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>权限名称:</td>
                                <td><input type="text" id="add_menuName" class="modal_input"/></td>
                            </tr>
                            <tr>
                                <td>权限URL:</td>
                                <td><input type="text" id="add_menuUrl" class="modal_input"/></td>
                            </tr>
                            <tr>
                                <td>权限备注:</td>
                                <td><input type="text" id="add_menuRemark" class="modal_input"/></td>
                            </tr>
                            <tr>
                                <td>权限等级:</td>
                                <td>&nbsp;&nbsp;<select id="add_select_orderNum">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                        <button type="button" class="btn btn-primary" onclick="addNewMenu()">添加</button>
                    </div>
                </div>
            </div>
        </div>

        <!--编辑悬浮框 -->
        <div class="modal fade" id="editBody" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">权限编辑</h4>
                    </div>
                    <div class="modal-body">
                    <#--选项卡-->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a class="edit_tab" href="#edit_menu" aria-controls="edit_menu" role="tab"
                                   data-toggle="tab">主权限编辑</a></li>
                            <li role="presentation">
                                <a class="edit_tab" href="#edit_add_senior_div" aria-controls="edit_add_senior_div"
                                   role="tab"
                                   data-toggle="tab">添加子权限</a></li>
                            <li role="presentation" class="dropdown">
                                <a id="dLabel" data-target="#" href="" data-toggle="dropdown"
                                   role="button" aria-haspopup="true" aria-expanded="true">
                                    子权限下拉框
                                <#--用于指定下拉样式-->
                                    <span class="caret"></span>
                                </a>
                                <ul id="edit_senior_ul" class="dropdown-menu" role="tablist" aria-labelledby="dLabel">

                                </ul>
                            </li>
                        </ul>

                    <#--tab pane-->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="edit_menu">
                                <table>
                                    <tr>
                                        <td>权限名称</td>
                                        <td>
                                            <input type="hidden" id="edit_menuId"/>
                                            <input type="text" id="edit_menuName"></td>
                                    </tr>
                                    <tr>
                                        <td>权限URL</td>
                                        <td><input type="text" id="edit_url"></td>
                                    </tr>
                                    <tr>
                                        <td>拥有权限</td>
                                        <td><span id="edit_has_senior_menus"></span></td>
                                    </tr>
                                </table>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="edit_add_senior_div">
                                <table>
                                    <tr>
                                        <td>子权限名称</td>
                                        <td><input type="text" id="edit_add_senior_menuName"/></td>
                                    </tr>
                                    <tr>
                                        <td>子权限URL</td>
                                        <td><input type="text" id="edit_add_senior_url"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="edit_senior_menus">
                                <table>
                                    <tr>
                                        <td>子权限名称</td>
                                        <td><input type="text" id="edit_senior_menuName"/></td>
                                    </tr>
                                    <tr>
                                        <td>子权限URL</td>
                                        <td><input type="text" id="edit_senior_url"/></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                        <button type="button" class="btn btn-primary" id="btn_modify">确认操作</button>
                    </div>
                </div>
            </div>
        </div>


        <span class="r_f">共：<b id="total"></b>个提供商</span>
    <#--<div class="border clearfix">-->
    <#--&lt;#&ndash;<span class="l_f">&ndash;&gt;-->
    <#--&lt;#&ndash;<a href="picture-add.html" title="添加设备版本" class="btn btn-warning Order_form"><i class="icon-plus"></i>添加设备版本</a>&ndash;&gt;-->
    <#--&lt;#&ndash;<a href="javascript:void()" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>&ndash;&gt;-->
    <#--&lt;#&ndash;<a href="javascript:void()" class="btn btn-info"><i class="icon-eye-open"></i>导入</a>&ndash;&gt;-->
    <#--&lt;#&ndash;<a href="javascript:void()" class="btn btn-info"><i class="icon-off"></i>导出</a>&ndash;&gt;-->
    <#--&lt;#&ndash;</span>&ndash;&gt;-->
    <#---->
    <#--</div>-->
        <!--设备列表展示-->
    <#--<div class="h_products_list clearfix" id="products_list">-->
    <#--<div id="scrollsidebar" class="left_Treeview">-->
    <#--<div class="show_btn" id="rightArrow"><span></span></div>-->
    <#--<div class="widget-box side_content">-->
    <#--&lt;#&ndash;<div class="side_title"><a title="隐藏" class="close_btn"><span></span></a></div>&ndash;&gt;-->
    <#--<div class="side_list">-->
    <#--<div class="widget-header header-color-green2"><h4 class="lighter smaller">设备类型列表</h4></div>-->
    <#--<div class="widget-body">-->
    <#--<div class="widget-main padding-8">-->
    <#--<div id="treeDemo" class="ztree"></div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--表格数据-->
        <div class="table_menu_list" id="testIframe">
            <table class="table table-striped table-bordered table-hover" id="sample-table">
                <thead>
                <tr>
                    <th width="50px">编号</th>
                    <th width="120px">权限名称</th>
                    <th width="100px">权限URL</th>
                    <th width="100px">子类权限</th>
                    <th width="100px">操作</th>
                </tr>
                </thead>
            </table>
            <div class="">
                    <span class="l_f pull-right">
                    <a href="javascript:void()" class="btn btn-info" id="resourceExcel"><i class="icon-off"></i>导出Excel</a>
                    </span>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
<script>
    $(function () {
        $("#remove_senior_btn").on('click', function () {
            var menuId = $("#remove_select_senior").val();
            if (menuId == 0)
                layer.alert("请选择下拉框权限后重试！");
            else {
                $.ajax({
                    url: "",
                    type: "post",
                    data: {
                        "menuId": menuId,
                        _method: "delete"
                    },
                    success: function (data) {
                        if (data) {
                            $("#addBody").toggle("modal");
                        } else
                            layer.alert("数据异常，删除失败！");
                    },
                    error: function () {
                        layer.alert("系统繁忙，请稍后重试！");
                    }
                });
            }
            flushTable();
        });
        $("#remove_btn").on("click", function () {
            var menuId = $("#remove_menuId").val();
            layer.confirm("确定要删除嘛？删除后，所有子权限也将删除！", function () {
                $.ajax({
                    url: "",
                    type: "post",
                    data: {
                        "menuId": menuId,
                        _method: "delete"
                    },
                    success: function (data) {
                        if (data) {
                            $("#removeBody").toggle("modal");
                        } else
                            layer.alert("数据异常，删除失败！");
                    },
                    error: function () {
                        layer.alert("系统繁忙，请稍后重试！");
                    }
                });
                layer.closeAll("dialog");
            });
            flushTable();
        });
        $("#resourceExcel").click(function () {
            $.ajax({
                url:"/devicemanager/settings/resourceExcel",
                type:"GET",
                success:function (data) {
                    if(data){
                        layer.msg("资源管理已经在桌面生成！",{icon:1,time:2000});
                    }else{
                        layer.msg("文件已经生成,请勿重复点击！",{icon:3,time:2000});
                    }
                }
            });
        })
        $("li").on('shown.bs.tab', ".edit_tab", function (e) {
            console.info("选新卡切换");
            // console.info("target========"+e.target); // newly activated tab
            // console.info("relatedTarget"+e.relatedTarget);// previous active tab
            var tabName = $(this).text();
            switch (tabName) {
                case "主权限编辑":
                    $("#btn_modify").text("确认修改");
                    break;
                case "添加子权限":
                    $("#btn_modify").text("确认添加");
                    break;
                default:
                    var seniorMenuName = $(this).text();
                    for (var i = 0, k = seniorMenus.length; i < k; i++) {
                        if (seniorMenus[i]._menuName == seniorMenuName) {
                            $("#edit_senior_menuName").val(seniorMenus[i]._menuName);
                            initInputLength($("#edit_senior_url"), seniorMenus[i]._url);
                            $("#btn_modify").text("确认修改");
                            break;
                        }
                    }
                    break;
            }
            console.info($(this).text());
        })
    });

    function initInputLength(e, val) {
        $(e).val(val);
        var length = val.length;
        if (length > 20)
            $(e).width(180 + (length - 20) * 6);
        else
            $(e).width(155);

    }

    function flushTable() {
        if (dataTable) {
            var settings = dataTable.fnSettings();
            console.info("url" + settings.ajax);
            settings.ajax.url = "/devicemanager/settings/resourceManager/list";
            settings.ajax.type = "GET";
            settings.ajax.data = {};
            settings.ajax.error = function (data) {
                layer.alert("没有查到相关设备");
            };
            console.info("新的URL" + settings.ajax.url);
            //刷新表格
            dataTable.fnDraw(false);
            gettotalCount();
        }
    }

    //添加权限
    function addNewMenu() {
        var menuName = $("#add_menuName").val();
        var url = $("#add_menuUrl").val();
        $(".modal_input").val("");
        $("#_createTime").val("");
        console.info("{_providerName}" + menuName);
        $.ajax({
            type: "post",
            url: "",
            data: {
                "menuName": menuName,
                "url": url
            },
            datatype: "json",
            success: function (data) {
                if (data)
                    flushTable();
                else
                    layer.alert("抱歉，添加失败");
            },
            error: function () {
                layer.alert("系统繁忙，请重试");
                $("#add_menuName").val(menuName);
                $("#add_menuUrl").val(url);
            }
        });
        $("#addBody").modal('toggle');
    }

    //
    // laydate({
    //     elem: '#_createTime',
    //     event: 'focus'
    // });
    var seniorMenus;
    var dataTable;
    var areaId;
    jQuery(function ($) {
        areaId = window.location.search;
        gettotalCount();
        //调用表单查询，初始化表单数据
        dataTable = $('#sample-table').dataTable({
            "bFilter": false,
            //"aaSorting": [[1, "desc"]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aLengthMenu": [5, 10],
            /*"bProcessing" : true, //开启读取服务器数据时显示正在加载中……特别是大数据量的时候，开启此功能比较好
            "bServerSide" : true,//服务器处理分页，默认是false，需要服务器处理，必须true
            "sAjaxDataProp" : "aData",//是服务器分页的标志，必须有*/
            "serverSide": true,
            //"paging": false, // 禁止分页
            /*"processing": true,*/
            "ajax": {
                url: "/devicemanager/settings/resourceManager/list",
                type: "GET"
            },//通过ajax实现分页的url路径.
            "bPaginate": true,
            "columns": [
                {"data": "_menuId"},
                {"data": "_menuName"},
                {"data": "_url"},
                {"data": "_underMenuName"},
                {"data": "manager"}
            ],
            "columnDefs": [
                {
                    "targets": [0],
                    "data": "_menuId",
                    "render": function (data, type, full, meta) {
                        return meta.row + 1 + meta.settings._iDisplayStart;//<td width='25px'><label><input type='checkbox' class='ace' name='"+data+"'><span class='lbl'></span></label></td>
                    }
                },
                {
                    "targets": [1],
                    "data": "_menuName",
                    "render": function (data, type, full) {
                        return "<td width='100px'>" + data + "</td>";
                    }
                },
                {
                    "targets": [2],
                    "data": "_url",
                    "render": function (data, type, full) {
                        return "<td width='100px'>" + data + "</td>";
                    }
                },
                {
                    "targets": [3],
                    "data": "_underMenuName",
                    "render": function (data, type, full) {
                        if (data != null) {
                            return "<td width=\"100px\">" + data + "</td>";
                        }
                        else {
                            return "<td width=\"100px\"><span style='color:red'>暂无子类权限</span></td>";
                        }
                    }
                },
                {
                    "targets": [4],
                    "data": "manager",
                    "render": function (data, type, full) {
                        return "<td><a class='btn btn-xs btn-danger' id='delete_a'>删除</a>" +
                                "<a class='btn btn-xs btn-info' id='edit_a'>编辑</a></td>";
                    }
                }
            ],
            /*"oLanguage": { // 国际化配置
                "sProcessing": "正在获取数据，请稍后...",
                "sLengthMenu": "显示 _MENU_ 条",
                "sZeroRecords": "没有找到数据",
                "sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
                "sInfoEmpty": "记录数为_TOTAL_",
                "sInfoFiltered": "(全部记录数 _MAX_ 条)",
                "sInfoPostFix": "",
                "sSearch": "查询",
                "sUrl": "",
                "oPaginate": {
                    "sFirst": "第一页",
                    "sPrevious": "上一页",
                    "sNext": "下一页",
                    "sLast": "最后一页"
                }
            }*/
            "language": {
                "lengthMenu": "每页 _MENU_ 条记录",
                "zeroRecords": "没有找到记录",
                "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
                "infoEmpty": "无记录",
                "infoFiltered": "(从 _MAX_ 条记录过滤)"
            }
            /*"oLanguage" : { // 国际化配置
                "sProcessing" : "正在获取数据，请稍后...",
                "sLengthMenu" : "显示 _MENU_ 条",
                "sZeroRecords" : "没有找到数据",
                "sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
                "sInfoEmpty" : "记录数为0",
                "sInfoFiltered" : "(全部记录数 _MAX_ 条)",
                "sInfoPostFix" : "",
                "sSearch" : "查询",
                "sUrl" : "",
                "oPaginate" : {
                    "sFirst" : "第一页",
                    "sPrevious" : "上一页",
                    "sNext" : "下一页",
                    "sLast" : "最后一页"
                }
            }*/

        });


        // $('table th input:checkbox').on('click', function () {
        //     var that = this;
        //     $(this).closest('table').find('tr > td:first-child input:checkbox')
        //             .each(function () {
        //                 this.checked = that.checked;
        //                 $(this).closest('tr').toggleClass('selected');
        //             });
        //
        // });

        //删除权限查询的方法
        $("#sample-table").on('click', '#delete_a', function () {
            var Datatable = $("#sample-table").DataTable();
            var tr = $(this).closest('tr');
            var data = Datatable.row(tr).data();
            //直接从表单中获取值
            var id = data["_id"];
            $.ajax(
                    {
                        type: "get",
                        url: "/devicemanager/settings/resourceManager/list",
                        data: {
                            "id": id
                        },
                        success: function (data) {
                            if (data) {
                                console.info(data)
                                seniorMenus = data.data[0]._menus;
                                $("#remove_menuId").val(data.data[0]._menuId);
                                $("#remove_menuName").val(data.data[0]._menuName);
                                initInputLength($("#remove_url"), data.data[0]._url);
                                console.info(seniorMenus);
                                $("#remove_select_senior").html("");
                                $("#remove_senior_btn").attr('disabled', false);
                                if (seniorMenus.length > 0) {
                                    $("#remove_select_senior").html("<option value='0'>选择下级权限</option>");
                                    for (var i = 0, k = seniorMenus.length; i < k; i++) {
                                        var ops = $("<option value=" + seniorMenus[i]._menuId + ">" + seniorMenus[i]._menuName + "</option>");
                                        $("#remove_select_senior").append($(ops));
                                    }
                                } else {
                                    $("#remove_select_senior").html("<option value='0'>暂无下级权限</option>");
                                    $("#remove_senior_btn").attr('disabled', true);
                                }
                                $("#removeBody").modal("toggle");
                            } else
                                layer.alert("系统异常，请稍后重试！");
                        },
                        error: function () {
                            layer.alert("数据异常！");
                        }
                    });
        });

        //编辑资源管理方法
        $("#sample-table").on('click', '#edit_a', function () {
            var Datatable = $("#sample-table").DataTable();
            var tr = $(this).closest('tr');
            var data = Datatable.row(tr).data();
            //直接从表单中获取值
            var id = data["_id"];
            console.info("id------------->=" + id);
            //通过ajax重新查询该对象的值
            $.ajax({
                type: "get",
                url: "/devicemanager/settings/resourceManager/list",
                data: {
                    "id": id
                },
                success: function (data) {
                    if (data) {
                        console.info(data);
                        $("#edit_menuId").val(data.data[0]._menuId);
                        $("#edit_menuName").val(data.data[0]._menuName);
                        initInputLength($("#edit_url"), data.data[0]._url);
                        $("#edit_senior_ul").html("");
                        if (!data.data[0]._underMenuName)
                            $("#edit_has_senior_menus").html("&nbsp;&nbsp;<i style='color:red;'>暂无子类权限</i>");
                        else {
                            seniorMenus = data.data[0]._menus;
                            console.info(seniorMenus);
                            $("#edit_has_senior_menus").html("&nbsp;&nbsp;" + seniorMenus.length + "个");
                            for (var i = 0, k = seniorMenus.length; i < k; i++) {
                                var lis = $("<li role='presentation'> <a class='edit_tab' href='#edit_senior_menus' aria-controls='edit_senior_menus' role='tab' data-toggle='tab'>" + seniorMenus[i]._menuName + "</a> </li>");
                                $("#edit_senior_ul").append($(lis));
                            }
                        }
                        //
                        // if (data.data[index]._parentId) {
                        //     $("#select_parentId2").val(data.data[index]._parentId);
                        //     console.info("parentId=" + data.data[index]._parentId);
                        //     $("#select_parentId2").attr("disabled", false);
                        // } else {
                        //     $("#select_parentId2").val(data.data[index]._menuId);
                        //     $("#select_parentId2").attr("disabled", true);
                        // }
                        $("#editBody").modal("toggle");
                    }
                    else
                        layer.alert("该数据已被删除！");
                },
                error: function () {
                    layer.alert("系统繁忙，稍后重试");
                }
            });
        });
        //编辑提交
        $("#btn_modify").on('click', function () {
            var menuId = $("#menuId2").val();
            var menuName = $("#menuName2").val();
            var menuUrl = $("#menuUrl2").val();
            var parentId = $("#select_parentId2").val();
            $("#menuId2").val("");
            $("#menuName2").val("");
            $("#menuUrl2").val("");
            console.info("vid" + menuId + "providerName" + menuName + "providerAddress" + menuUrl + "parentId=" + parentId);
            $.ajax(
                    {
                        url: "/devicemanager/settings/modifyMenus",
                        type: "post",
                        data: {
                            "menuId": menuId,
                            "menuName": menuName,
                            "menuUrl": menuUrl,
                            "parentId": parentId,
                            _method: "PUT"
                        },
                        success: function (data) {
                            if (data)
                                flushTable();
                            else
                                layer.alert("数据异常！");
                        },
                        error: function () {
                            $("#menuId2").val(vid);
                            $("#menuName2").val(providerName);
                            $("#menuUrl2").val(providerAddress);
                            layer.alert("系统繁忙请稍后重试！");
                        }
                    });
            $("#editBody").modal("toggle");
        });

        $('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});

        function tooltip_placement(context, source) {
            var $source = $(source);
            var $parent = $source.closest('table');
            var off1 = $parent.offset();
            var w1 = $parent.width();
            var off2 = $source.offset();
            var w2 = $source.width();

            if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2)) return 'right';
            return 'left';
        }
    });

    $(function () {
        $("#products_style").fix({
            float: 'left',
            //minStatue : true,
            skin: 'green',
            durationTime: false,
            spacingw: 30,
            spacingh: 260,
        });

        //点击查询事件
        $('#role_name_search').on('click', function () {
            console.info("点击事件");
            var name = $("#role_name").val();
            console.info("关键字" + name);
            var settings = dataTable.fnSettings();
            console.info("url" + settings.ajax.url);
            gettotalCount();
            settings.ajax.url = "/devicemanager/settings/resourceManager/list";
            settings.ajax.type = "GET";
            settings.ajax.data = {
                "keyWord": name
            };
            settings.ajax.error = function (data) {
                layer.alert("没有查到相关设备");
            };
            console.info("新的URL" + settings.ajax.url);
            //刷新表格
            dataTable.fnDraw(false);
        });

    });

    //查询设备总数ajax
    function gettotalCount() {
        console.info("得到维修记录");
        var name = $("#role_name").val();
        $.ajax({
            url: "/devicemanager/settings/resourceManager/list",
            type: "GET",
            data: {
                "name": name
            },
            success: function (data) {
                console.info(data);
                $("#total").text(data.recordsFiltered);

            }
        });

    }

    /*  点击导出Excel
      $("#export_product_list").on('click', function () {
          $.get("", function () {

          })
      })
  */

    //初始化宽度、高度
    $(".widget-box").height($(window).height() - 215);
    $(".table_menu_list").width($(window).width() - 260);
    $(".table_menu_list").height($(window).height() - 215);
    //当文档窗口发生改变时 触发
    $(window).resize(function () {
        $(".widget-box").height($(window).height() - 215);
        $(".table_menu_list").width($(window).width() - 260);
        $(".table_menu_list").height($(window).height() - 215);
    });

    /*******树状图*******/
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: false,
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: ""
            }
        },
        callback: {
            beforeClick: function (treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj("tree");
                if (treeNode.isParent) {
                    zTree.expandNode(treeNode);
                    return false;
                } else {
                    demoIframe.attr("src", treeNode.file + ".html");
                    return true;
                }
            }
        }
    };

    <#--var zNodes =${zNodes};-->

    var code;

    function showCode(str) {
        if (!code) code = $("#code");
        code.empty();
        code.append("<li>" + str + "</li>");
    }


    // $(document).ready(function () {
    //     // var t = $("#treeDemo");
    //     // t = $.fn.zTree.init(t, setting, zNodes);
    //     demoIframe = $("#testIframe");
    //     demoIframe.bind("load", loadReady);
    //     var zTree = $.fn.zTree.getZTreeObj("tree");
    //     zTree.selectNode(zTree.getNodeByParam("id", '11'));
    // });


    // //面包屑返回值
    // var index = parent.layer.getFrameIndex(window.name);
    // parent.layer.iframeAuto(index);
    // $('.Order_form').on('click', function () {
    //     var cname = $(this).attr("title");
    //     var chref = $(this).attr("href");
    //     var cnames = parent.$('.Current_page').html();
    //     var herf = parent.$("#iframe").attr("src");
    //     parent.$('#parentIframe').html(cname);
    //     parent.$('#iframe').attr("src", chref).ready();
    //     ;
    //     parent.$('#parentIframe').css("display", "inline-block");
    //     parent.$('.Current_page').attr({"name": herf, "href": "javascript:void(0)"}).css({
    //         "color": "#4c8fbd",
    //         "cursor": "pointer"
    //     });
    //     //parent.$('.Current_page').html("<a href='javascript:void(0)' name="+herf+" class='iframeurl'>" + cnames + "</a>");
    //     parent.layer.close(index);
    // });

</script>
