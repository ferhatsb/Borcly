$(function () {

    /*var modalElement = $('<div />', { class:'modal fade', id:'transacton-modal' })
     .append($('<div />', { class:'modal-header' })
     .append($('<a/>', { class:'close', text:'x', 'data-dismiss':'modal' }))
     .append($('<h3/>', { text:'Yeni Borc Ekle' })))
     .append($('<div />', { class:'modal-body'}));

     $('.btn-modal').click(function (e) {
     e.preventDefault();
     modalElement.find('h3').html($(this).attr('title'));

     modalElement.find('.modal-body').load($(this).attr('data-href'), function () {
     modalElement.modal({show:true, backdrop:true, keyboard:true});
     });

     modalElement.on('shown', function () {
     $('.ajax-form').each(function (index) {
     $(this).submit(function () {
     $(this).text();
     return true;
     });
     });
     });
     });*/

    $('.back-button').click(function (e) {
        history.go(-1);
        return false;
    });

    var modalElement = $('<div />', { class:'modal fade', id:'transacton-modal' })
        .append($('<div />', { class:'modal-header' })
        .append($('<a/>', { class:'close', text:'x', 'data-dismiss':'modal' }))
        .append($('<h3/>', { text:'Onaylayin' })))
        .append($('<div />', { class:'modal-body'}))
        .append($('<div />', { class:'modal-footer'}));


    modalElement.find('.modal-footer').html('<a class="btn btn-primary" href="#" onclick="submitApprovedForm()">Onayla</a><a data-dismiss="modal" class="btn" href="#">Iptal</a>');


    $('.check-paid').submit(function () {
        var email = $('#transaction_related_person_email').val();
        modalElement.find('.modal-body').html('Borc verdiginiz kullanicinin( ' + email + ') odenmemis borcu bulunmaktadir, yeni bir borc vermek istediginize emin misiniz?' );
        $.get('/admin/transactions/check?email=' + email , function (data) {

            var result = eval(data);
            if (result) {
                modalElement.modal({show:true, backdrop:true, keyboard:true});

            } else {
                $('.check-paid').unbind('submit');
                $('.check-paid').submit();
            }
        });

        return false;
    });

});

function submitApprovedForm() {
    $('.check-paid').unbind('submit');
    $('.check-paid').submit();
}

