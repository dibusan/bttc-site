$(document).on('turbolinks:load', function() {
    $('#covid-19-rules-alert').on('click', function(){
        const URL = 'https://13278531-8f3a-64e2-9cb9-fdc360e79c7f.filesusr.com/ugd/af38e3_ca8afe44a9ca4c9d83320f418d62ac73.pdf'
        window.open(URL, '_blank');
    });
});
