$(function(){
    var modalElement = $('<div />', { class: 'modal fade', id: 'transacton-modal' })
        .append($('<div />', { class: 'modal-header' })
        .append($('<a/>', { class: 'close', text: 'x', 'data-dismiss': 'modal' } ))
        .append($('<h3/>', { text: 'Yeni Kayit Olustur' })))
        .append($('<div />', { class: 'modal-body'} ));

    $('.btn-modal').click(function(e) {
        e.preventDefault();
        modalElement.find('h3').html($(this).attr('title'));

        modalElement.find('.modal-body').load($(this).attr('data-href') , function(){
            modalElement.modal({show: true , backdrop : true , keyboard: true});
        });

        modalElement.on('shown', function () {
            ajax_form();
        });
    });
});


function ajax_form() {
    $('.ajax-form').each(function(index) {
        $(this).submit(function() {
            $(this).text();
            return true;
        });
    });
}

