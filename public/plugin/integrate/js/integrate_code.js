
var IntegrateCode = (function() {

    var _options = {};

    // constructor
    function IntegrateCode( options ) {
        _options = options;

    };

    IntegrateCode.prototype.getOptions = function() {
        return _options;
    };

    IntegrateCode.prototype.setOptions = function( options ) {
        for( i in  options )  {
            // if( typeof( _options[options[i]] )=='undefined' ){
            _options[i] = options[i];
            // }
        }
    };
    
    IntegrateCode.prototype.fetchInfos = function(  ) {

        // url,  list_tpl_id, list_render_id
        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.filter_url,
            data: $('#filter_form').serialize()+_options.params,
            success: function (resp) {
                auth_check(resp);
                if(resp.data.rootPath.length){
                    var sourcepath = $('#'+_options.path_tpl_id).html();
                    var templatepath = Handlebars.compile(sourcepath);
                    var resultpath = templatepath(resp.data);

                    $('#' + _options.path_render_id).html(resultpath);

                }

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
                    $('#'+_options.list_render_id).empty();
                    $('#'+_options.list_render_id).append($('<tr><td colspan="5" id="' + _options.list_render_id + '_wrap"></td></tr>'))
                    $('#'+_options.list_render_id + '_wrap').append(emptyHtml.html)
                }

            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };

    IntegrateCode.prototype.branchSelect = function(  ){
        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.branch_url,
            data:  $('#filter_form').serialize(),
            success: function (resp) {
                auth_check(resp);
                $('#'+_options.branch_render_id).empty();
                if(resp.data.branch.length){
                    for(let bi = 0;bi<resp.data.branch.length;bi++){
                        let selected = (resp.data.branchNow === resp.data.branch[bi].name)?"selected":"";
                        $('#'+_options.branch_render_id).append(`<option value='${resp.data.branch[bi].name}' ${selected}>${resp.data.branch[bi].name}</option>`);
                    }
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };
    IntegrateCode.prototype.branchFetch = function(  ){
        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.branch_fetch_url,
            data:  $('#filter_form').serialize(),
            success: function (resp) {
                auth_check(resp);
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    };
    return IntegrateCode;
})();