$(document).ready(function(){
    $('.list-group-item-action').on('click', function(){
        var name =$(this).data('table_name');
        if(name != undefined && name.length > 0){
            setTimeout(function(){
                $('#' + name + '_table').DataTable().responsive.recalc();
            }, 200);
        }
    });
});