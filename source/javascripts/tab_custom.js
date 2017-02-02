$(document).ready(function(){
    var gotoHashTab = function (customHash) {
        var hash = customHash || location.hash;
        var hashPieces = hash.split('?'),
            activeTab = $('[href=' + hashPieces[0] + ']'),
            activeId = $(hashPieces[0]);

        activeTab && activeTab.tab('show');
        if(hashPieces[0].length > 0){
            console.log(hashPieces);
            $("html, body").animate({ scrollTop: $(activeId).offset().top }, 0);
        }
    }

    // onready go to the tab requested in the page hash
    gotoHashTab();

    // when the nav item is selected update the page hash
//    $('.nav a').on('click', function (e) {
//        window.location.hash = $(this).attr('href');
//    });

    // when a link within a tab is clicked, go to the tab requested
//    $('.tab-pane a').click(function (event) {
//        if (event.target.hash) {
//            gotoHashTab(event.target.hash);
//        }
//    });

    // Bootstrap ScrollSpy init
    $('body').scrollspy({ target: '.documentation-sidebar' });

    $(document).on('click', '[data-toggle="tab-code"]', function (e) {
       e.preventDefault()

        var langTarget = $(this).data('lang');
        $('[data-lang="' + langTarget + '"]').tab('show');
   });

});


