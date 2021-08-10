
var Integrate = (function() {

    var _options = {};
    // constructor
    function Integrate( options ) {
        _options = options;
        $("#btn-plugin_save").click(function(){
            if($('#id_action').val()==='add'){
                Integrate.prototype.add();
            }else{
                Integrate.prototype.update();
            }
        });
        $("#btn-create_plugin").click(function(){
            Integrate.prototype.create();
        });

    };

    Integrate.prototype.getOptions = function() {
        return _options;
    };

    Integrate.prototype.setOptions = function( options ) {
        for( i in  options )  {
            // if( typeof( _options[options[i]] )=='undefined' ){
            _options[i] = options[i];
            // }
        }
    };

    Integrate.prototype.fetchIntegrates = function(  ) {

        // url,  list_tpl_id, list_render_id

        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.filter_url,
            data: $('#'+_options.filter_form_id).serialize() ,
            success: function (resp) {
                auth_check(resp);
                if(resp.data.integrates.length){
                    var source = $('#'+_options.list_tpl_id).html();
                    var template = Handlebars.compile(source);
                    var result = template(resp.data);

                    $('#' + _options.list_render_id).html(result);

                    $(".list_for_repo").click(function(){
                        location.href=_options.repo_url+'?repo='+ $(this).attr("data-value");
                    });


                    $(".list_for_edit").click(function(){
                        Integrate.prototype.edit( $(this).attr("data-value") );
                    });

                    $(".list_for_delete").click(function(){
                        Integrate.prototype._delete( $(this).attr("data-value") );
                    });
                }else{
                    var emptyHtml = defineStatusHtml({
                        message : '暂无数据',
                        handleHtml: ''
                    })
                    $('#'+_options.list_render_id).append($('<tr><td colspan="5" id="' + _options.list_render_id + '_wrap"></td></tr>'))
                    $('#'+_options.list_render_id + '_wrap').append(emptyHtml.html)
                }

            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };
    Integrate.prototype.fetchInfos = function(  ) {

        // url,  list_tpl_id, list_render_id
        console.log(_options.filter_url);
        var params = {  format:'json' };
        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.filter_url,
            data: $('#'+_options.filter_form_id).serialize() ,
            success: function (resp) {
                auth_check(resp);
                if(resp.data.infos.length){
                    var source = $('#'+_options.list_tpl_id).html();
                    var template = Handlebars.compile(source);
                    var result = template(resp.data);

                    $('#' + _options.list_render_id).html(result);

                }else{
                    var emptyHtml = defineStatusHtml({
                        message : '暂无数据',
                        handleHtml: ''
                    })
                    $('#'+_options.list_render_id).append($('<tr><td colspan="5" id="' + _options.list_render_id + '_wrap"></td></tr>'))
                    $('#'+_options.list_render_id + '_wrap').append(emptyHtml.html)
                }

            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };
    Integrate.prototype.create = function( ) {
        $("#modal-plugin").modal('show');
        $('#modal-header-title').html('创建-版本库');
        $('#form-plugin')[0].reset();
        $("#id_action").val('add');
        $('#tip_name').show();
        $("#id_path").val('');
        $("#id_scm").val('');
        $("#id_encoding").val('');
        $("#id_client").val('');
        $("#id_desc").text('');
        console.log(window.uploader)
        window.uploader.reset();

    };

    Integrate.prototype.edit = function(id ) {

        $("#modal-plugin").modal('show');
        $('#modal-header-title').html('编辑-版本库');
        $("#id_action").val('update');
        loading.show('#modal-body');
        var method = 'get';
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.get_url+"?id="+id,
            data: { id:id} ,
            success: function (resp) {
                loading.closeAll();
                auth_check(resp);
                $("#edit_id").val(resp.data.id);
                $("#id_name").val(resp.data.name);
                $('#tip_name').hide();
                $("#id_path").val(resp.data.path);
                $("#id_scm").val(resp.data.scm);
                $("#id_encoding").val(resp.data.encoding);
                $("#id_client").val(resp.data.client);
                $("#id_desc").text(resp.data.desc);
                $('.selectpicker').selectpicker('refresh');
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };



    Integrate.prototype.add = function(  ) {

        var method = 'post';
        var params = $('#form-plugin').serialize();
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.add_url,
            data: params ,
            success: function (resp) {
                auth_check(resp);
                if( resp.ret ==='200'  ){
                    window.location.reload();
                }else{
                    notify_error( resp.msg ,resp.data);
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };

    Integrate.prototype.update = function(  ) {

        var method = 'post';
        var params = $('#form-plugin').serialize();
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.update_url,
            data: params ,
            success: function (resp) {
                auth_check(resp);
                if( resp.ret ==='200'  ){
                    window.location.reload();
                }else{
                    notify_error( resp.msg );
                }

            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };
    Integrate.prototype._delete = function(id ) {

        if  (!window.confirm('您确认删除吗?')) {
            return false;
        }
        var method = 'POST';
        $.ajax({
            type: method,
            dataType: "json",
            data:{id:id},
            url: _options.delete_url,
            success: function (resp) {
                auth_check(resp);
                notify_success( resp.msg ,  resp.data);
                if( resp.ret ==='200'  ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };

    return Integrate;
})();