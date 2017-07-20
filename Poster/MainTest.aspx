<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>API测试工具</title>
</head>
<body>
    <div id="msg" class="alert" style="display:none;position:absolute;top:5px;right:5px;width:300px;z-index:1000">	 
    </div>
    <div class="col-md-6 panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            参数设置
        </h3>
    </div>
    <div class="panel-body">
   <div class="form-group">
    <label for="name">请求地址</label>
    <input type="text" required="required" class="form-control" id="url" placeholder="请输入请求地址"/>
      </div>
  
        <div class="form-group">
    <label for="name">请求方式</label>
       <select class="form-control" id="type">
           <option value="Get">Get</option>
           <option value="Post">Post</option>
           <option value="Put">Put</option>
           <option value="Delete">Delete</option>
       </select>
      </div>

          <div class="form-group">
            <label for="name">传参设置</label>
              <div class="input-group">
            <span class="input-group-addon">参数个数</span>
            <input type="number" class="form-control" id="paramNum" value="1"/>
              </div>
              <br/>
            <div id="paramForm" class="form-group">
             <div class="input-group">
            <span class="input-group-addon">参数名称</span>
            <input type="text" class="form-control" placeholder="请输入参数名称"/>
                     <span class="input-group-addon">参数值</span>
            <input type="text" class="form-control" placeholder="请输入参数值"/>   
             </div>
            <br/>
            </div>

      </div>
          <button type="button" class="btn btn-primary" id="btnPost">发出请求</button>
        </div>
    </div>
  
    <div class="col-md-6 panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            Console           
        </h3>        
    </div>
    <div class="panel-body">       
        <div style="height:350px;overflow-y:scroll">   
         <label id="content"></label>
            </div>   
         <button type="button" class="btn btn-warning" id="btnClear">Clear</button>
             
             </div>
         </div>

    
    
    <script type="text/javascript">

        function MsgBox(title, msg, state) {
            $("#msg").removeClass("alert-success alert-warning");
            if (state)
                $("#msg").addClass("alert-warning").empty().append('<a href="#" class="close" data-dismiss="alert">&times;</a><strong>' + title + '</strong>' + msg).show("slow").fadeIn("slow");
            else
                $("#msg").addClass("alert-success").empty().append('<a href="#" class="close" data-dismiss="alert">&times;</a><strong>' + title + '</strong>' + msg).show("slow").fadeIn("slow");
            window.setTimeout(
                function () {
                    $("#msg").hide("slow");
                }, 3000
                );
        }

        $(function () {

            $("#btnClear").click(function () {
                $("#content").empty();
            });

            $("#paramNum").change(
                function () {
                    $("#paramForm").empty();
                    for (var i = 1; i <= $("#paramNum").val() ; i++) {
                        $("#paramForm").append("<div class='input-group'><span class='input-group-addon'>参数名称(" + i + ")</span><input type='text' class='form-control' placeholder='请输入参数名称'/><span class='input-group-addon'>参数值</span><input type='text' class='form-control' placeholder='请输入参数值'/></div><br/>");
                    }
                });
            $("#btnPost").click(function () {
                if ($("#url").val() == "")
                {
                    MsgBox("警告！", "请输入请求网址", 1);
                    return;
                }
                //参数
                var params = "{";
                $("#paramForm input").each(
                    function (index, data) {
                        if (index % 2 == 0) {
                            params += "'";
                            params += $(data).val();
                            params += "':";
                        }
                        else {
                            if (index == $("#paramForm input").length - 1) {
                                params += "'";
                                params += $(data).val();
                                params += "'}";
                            }
                            else {
                                params += "'";
                                params += $(data).val();
                                params += "',";
                            }
                        }
                    });
               // alert(params);
                $.ajax({
                    url: $("#url").val(),
                    type: $("#type").val(),
                    data: eval('(' + params + ')'),
                    success: function (data) {
                        MsgBox("成功！","请求成功");
                        $("#content").append(JSON.stringify(data)+"<br/>");
                    },
                    error: function (erro) {
                        MsgBox("失败！", "请求失败", 1);
                        $("#content").append(JSON.stringify(erro) + "<br/>");
                    }

                });
            });

        });
    </script>
</body>
</html>
