$(function(){
    var modalElement = $('<div />', { class: 'modal hide fade', id: 'transacton-modal' })
        .append($('<div />', { class: 'modal-header' })
        .append($('<a/>', { class: 'close', text: 'x', 'data-dismiss': 'modal' } ))
        .append($('<h3/>', { text: 'Yeni Kayit Olustur' })))
        .append($('<div />', { class: 'modal-body'} ));

    $('.btn-modal').click(function(e) {
        e.preventDefault();
        var btn_data = $(this);
        modalElement.on('show', function () {
            $.get(btn_data.attr('data-href'), function(data) {
                modalElement.find('.modal-body').html(data);
            });
        });
        modalElement.modal({show: true , backdrop : true , keyboard: true});
    });
});